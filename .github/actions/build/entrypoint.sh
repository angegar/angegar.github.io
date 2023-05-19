#!/bin/bash

build_marp () {
    source="$1"
    destination="$2"
    theme="$3"

    # marp "$source/README.md" -o "$destination/README.html"
    if [ -z "$theme" ]; then
        marp -I "$source" -o "$destination"
    else
        marp -I "$source" -o "$destination" --theme-set "$theme"
    fi

    if [ -d "$source/img" ]; then 
        cp -r "$source/img" "$destination/"
    fi

    if [ -d "$source/assets" ]; then 
        cp -r "$source/assets" "$destination/"
    fi
}

# ==================================================================

echo "Marp version: $(marp --version)" >> $GITHUB_STEP_SUMMARY

## Build Platform Engineering slides
build_marp slidedecks/platform-engineering docs/platform-engineering theme.css

## Build Kubernetes slides
build_marp slidedecks/kubernetes-overview docs/Kubernetes/kubernetes-overview

## Build CDK slides
build_marp slidedecks/cdk docs/cdk/

## Build Dagger slides
build_marp slidedecks/dagger docs/dagger/ addo.css

## Build web site - must be the latest task
mkdocs build

export MKDOCS_GIT_COMMITTERS_APIKEY=$GH_TOKEN
mkdocs gh-deploy --force