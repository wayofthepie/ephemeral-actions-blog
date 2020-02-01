#!/usr/bin/env bash

OWNER=$1
REPO=$2
TOKEN=$3
NAME=$4

echo ${NAME} | ./config.sh --url https://github.com/${OWNER}/${REPO} --token ${TOKEN} 

./run.sh 

