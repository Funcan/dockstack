#!/bin/bash

MAJOR_VERSION=0
MINOR_VERSION=$(git rev-list HEAD --count)
VERSION_TAG=$(git describe --always --dirty --tags)

VERSION=$MAJOR_VERSION.$MINOR_VERSION-$VERSION_TAG

ALL_COMPONENTS="rabbit"

if [[ "$1" == "baseimage" ]]
then
    echo Building a new base image
    sudo docker build --no-cache -t duncant/baseimage:$VERSION dockerfiles/duncant_baseimage
    exit 0
fi

function component_found()
{
    C=$1
    shift
    for ARG in $@
    do
        if [[ "$C" == "$ARG" ]]
        then
            return 1
        fi
    done

    return 0
}


# FIXME It would be nice to do some sort of version number analysis or something rather than just using the latest one
IMAGE_LINE=$(sudo docker images| grep -v ^REPOSITORY | grep ^duncant/baseimage | head -1)
IMAGE_VERSION=$(echo $IMAGE_LINE | awk '{print $2}')
IMAGE_ID=$(echo $IMAGE_LINE | awk '{print $3}')
echo "Using baseimage $IMAGE_VERSION (ID $IMAGE_ID)"

if [[ $# -eq 0 ]]
then
    echo "Usage: $0 <component> [<component> ...]" 
else
    echo "Attempting to build components $@"
    echo
fi

component_found "rabbit" $@
if [[ $? -ne 0 ]]
then
    echo "Building a rabbit docker image $VERSION"
    # FIXME: We should be able to use duncant/baseimage:latest in the Dockerfile
    #        rather than messing with sed
    sed "s/{{BASEIMAGE}}/$IMAGE_ID/" dockerfiles/rabbit/Dockerfile > dockerfiles/rabbit/Dockerfile.tmp
    sudo docker build --no-cache -t duncant/rabbit:$VERSION -f dockerfiles/rabbit/Dockerfile.tmp dockerfiles/rabbit
fi
