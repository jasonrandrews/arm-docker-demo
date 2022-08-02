#!/bin/bash

HUBU=jasonrandrews
IMG=hello-world

docker context use default
docker run --rm $HUBU/$IMG
