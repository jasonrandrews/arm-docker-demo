#!/bin/bash

HUBU=jasonrandrews
IMG=hello-world

arch=$(uname -m)
if [ "$arch" == 'arm64' ]; then
  arch=aarch64
fi

docker tag $IMG:$arch $HUBU/$IMG:latest-$arch
docker push $HUBU/$IMG:latest-$arch 

