#!/usr/bin/env bash

OWNER=$1
REPO=$2
PAT=$3
NAME=$4

# if set this script will only run ./config.sh
# it will not run the actions runner
REGISTER_ONLY=$5

cleanup() {
    token=$(curl -s -XPOST -H "authorization: token ${PAT}" \
        https://api.github.com/repos/${OWNER}/${REPO}/actions/runners/registration-token | jq -r .token)
    ./config.sh remove --token $token
}

token=$(curl -s -XPOST \
    -H "authorization: token ${PAT}" \
    https://api.github.com/repos/${OWNER}/${REPO}/actions/runners/registration-token | jq -r .token)

./config.sh \
    --url https://github.com/${OWNER}/${REPO} \
    --token ${token} \
    --name ${NAME} \
    --work _work

if [ -z ${REGISTER_ONLY} ]; then
    ./run.sh --once
    cleanup
fi
