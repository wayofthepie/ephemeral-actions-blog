#!/usr/bin/env bash

PAT=$1
OWNER=$2
REPO=$3

# make sure we have values for all our arguments
[ -z ${PAT} ] || [ -z ${OWNER} ] || [ -z $REPO ] && {
    echo "Incorrect usage, example: ./orc.sh personal-access-token owner some-repo"
    exit 1
}

# get the latest commit
latest_commit=$(curl -s -H "authorization: token ${PAT}"  \
    https://api.github.com/repos/${OWNER}/${REPO}/commits |\
    jq -r .[0].sha)

# for each check run requested for this commit, get the "status"
# field and assign to the "check_status" variable 
for check_status in $(curl -s \
    -H "accept: application/vnd.github.antiope-preview+json" \
    -H "authorization: token ${PAT}"\
    https://api.github.com/repos/${OWNER}/${REPO}/commits/${latest_commit}/check-runs \
    | jq -r '.check_runs[] | "\(.status)"'); do

    # if "check_status" is queued launch an action runner
    if [ "${check_status}" == "queued" ]; then
        echo "Found check run request with status ${check_status}, launching job ..."
        cat job.yaml \
            | sed -r "s/\{NAME\}/$(uuidgen)/g; s/\{OWNER\}/${OWNER}/; s/\{REPO\}/${REPO}/" \
            | kubectl apply -f -
    else
        echo "Found check run request with status '${check_status}', nothing to do ..."
    fi
done
