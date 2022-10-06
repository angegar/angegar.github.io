#!/bin/bash

build_marp () {
    source="$1"
    destination="$2"

    # marp "$source/README.md" -o "$destination/README.html"
    marp -I "$source" -o "$destination"
    if [ -d "$source/img" ]; then 
        cp -r "$source/img" "$destination/"
    fi
}

# ==================================================================


## Build Kubernetes slides
build_marp slidedecks/kubernetes-overview docs/Kubernetes/kubernetes-overview

## Build CDK slides
build_marp slidedecks/cdk docs/cdk/

## Build web site - must be the latest task
mkdocs build
export MKDOCS_GIT_COMMITTERS_APIKEY=$GH_TOKEN
mkdocs gh-deploy --force