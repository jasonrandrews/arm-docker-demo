#!/bin/bash

IMG=hello-world

arch=$(uname -m)
if [ "$arch" == 'arm64' ]; then
  arch=aarch64
fi

docker context use default
docker build -t $IMG:$arch .

