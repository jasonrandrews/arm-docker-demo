#! /bin/bash

HUBU=jasonrandrews
IMG=hello-world

docker context create remote --docker "host=ssh://ubuntu@IP"
docker context use remote

docker build --platform linux/amd64 -t $HUBU/$IMG:latest-amd64  .
docker push $HUBU/$IMG:latest-amd64


