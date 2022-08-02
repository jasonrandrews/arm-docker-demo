#!/bin/bash

HUBU=jasonrandrews
IMG=hello-world

docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t $HUBU/$IMG --push .

