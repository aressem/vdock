#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <tag>"
    exit 1
fi

readonly VERSION=$1

sed -i.orig "s/RUN.*yum.*install.*vespa-zookeeper-c-client-[0-9]\.[0-9]*\.[0-9]*.*/RUN yum install -y vespa-zookeeper-c-client-6.100.2/" Dockerfile
git commit -am "Updated version to $VERSION"
git tag -a -m "Release $VERSION" $VERSION
git push --follow-tags
