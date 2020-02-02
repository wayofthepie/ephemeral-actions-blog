#!/usr/bin/env bash

OWNER=$1
REPO=$2
TOKEN=$3
NAME=$4

./config.sh \
    --url https://github.com/${OWNER}/${REPO} \
    --token ${TOKEN} \
    --name ${NAME} \
    --work _work

./run.sh 

