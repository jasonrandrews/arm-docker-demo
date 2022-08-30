#!/bin/bash

HUBU=jasonrandrews
IMG=hello-world

arch=$(uname -m)
if [ "$arch" == 'arm64' ]; then
  arch=aarch64
fi

docker tag $IMG:$(arch) $HUBU/$IMG:$(arch)
docker push $HUBU/$IMG:$(arch) 

