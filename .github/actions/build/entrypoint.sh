#!/bin/bash

## Build Kubernetes slides
marp slidedecks/kubernetes-overview/README.md -o docs/Kubernetes/kubernetes-overview/README.html
cp -r slidedecks/kubernetes-overview/img docs/Kubernetes/kubernetes-overview/

## Build CDK slides
marp slidedecks/cdk/README.md -o docs/cdk/README.html
cp -r slidedecks/cdk/img docs/cdk/


## Build web site - must be the latest task
mkdocs build
export MKDOCS_GIT_COMMITTERS_APIKEY=$GH_TOKEN
mkdocs gh-deploy --force
# marp ${MARP_INPUT_PATH} -o ${GITHUB_WORKSPACE}/${MARP_OUTPUT_PATH}
# cp -r ${MARP_INPUT_PATH}/img ${GITHUB_WORKSPACE}/${MARP_OUTPUT_PATH}/
# mkdocs build
# ls -al