#!/usr/bin/env bash

OWNER=$1
REPO=$2
PAT=$3
NAME=$4

token=$(curl -s -XPOST \
    -H "authorization: token ${PAT}" \
    https://api.github.com/repos/wayofthepie/gh-app-test/actions/runners/registration-token | jq -r .token)

./config.sh \
    --url https://github.com/${OWNER}/${REPO} \
    --token ${token} \
    --name ${NAME} \
    --work _work

./run.sh 

