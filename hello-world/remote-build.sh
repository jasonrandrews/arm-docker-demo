#! /bin/bash

docker context create remote --docker "host=ssh://ubuntu@IP"
docker context use remote

docker build --platform linux/arm/v7 -t jasonrandrews/hello-world-v7  .
docker push jasonrandrews/hello-world-v7


