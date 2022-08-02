#!/bin/bash

HUBU=jasonrandrews
IMG=hello-world

docker run --rm  $HUBU/$IMG

docker run --rm  --platform linux/arm64 $HUBU/$IMG
docker run --rm  --platform linux/arm/v7 $HUBU/$IMG
docker run --rm  --platform linux/amd64 $HUBU/$IMG
