#!/bin/bash

HUBU=jasonrandrews
IMG=hello-world

docker manifest create $HUBU/$IMG:latest \
--amend $HUBU/$IMG:latest-aarch64 \
--amend $HUBU/$IMG:latest-amd64
docker manifest push --purge $HUBU/$IMG:latest

