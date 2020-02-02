#!/usr/bin/env bash
##
# Detects new commits in a given repo by checking every minute
# and storing a reference to the last seen commit in a file called
# prev.
##

PAT=$1
OWNER=$2
REPO=$3

cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
prev="${cur_dir}/prev"

# make sure we have values for all our arguments
[ -z ${PAT} ] || [ -z ${OWNER} ] || [ -z $REPO ] && {
    echo "Incorrect usage, example: ./orc.sh personal-access-token owner some-repo"
    exit 1
}

# make sure the prev file exists
touch ${prev}

# get the latest commit
latest_commit=$(curl -s -H "authorization: token ${PAT}"  \
    https://api.github.com/repos/${OWNER}/${REPO}/commits |\
    jq -r .[0].sha)

# read the last commit we saw
prev_commit=$(cat ${prev})

echo "Latest commit is ${latest_commit}"
echo "Previous commit is ${prev_commit}"

# compare the commits, running an action runner if they differ
if [ "${latest_commit}" != "${prev_commit}" ]; then
    echo "Detected new commit, starting runner"
    docker run -d --rm actions-image \
        ${OWNER} \
        ${REPO} \
        ${PAT} \
        $(uuidgen)
fi

# update the previous commit store with the latest commit
echo ${latest_commit} > ${prev}
