This information is out-of-date. Please refer to the Learning Path [Learn how to use Docker](https://learn.arm.com/learning-paths/cross-platform/docker/)

# Simple docker demos for Arm

Some ideas for working with Docker on the Arm architecture. 

The example docker image is a simple C program (hello.c) which prints a message and the architecture (as reported by the Linux command: uname -a)

It also prints if it is a 32-bit application or a 64-bit application.

There are multiple ways to work with multi-architecture images. 

## Use buildx to emulate non-native architectures

build.sh: does everything on the local machine:
- Create a buildx builder
- Use the builder
- Build for 3 target architectures on the local machine
- Push the multi-arch image to Docker Hub 

```bash
docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t jasonrandrews/hello-world --push .
```

Edit build.sh and set HUBU to your Docker Hub username and try it:
```bash
./build.sh
```

Substitute your Docker Hub username and run the native image (automatically detected):

```bash
docker run --rm  jasonrandrews/hello-world
```

run.sh: Run a specific architecture, which may or may not be the native architecture:

```bash
docker run --rm  --platform linux/arm64 jasonrandrews/hello-world
docker run --rm  --platform linux/arm/v7 jasonrandrews/hello-world
docker run --rm  --platform linux/amd64 jasonrandrews/hello-world
```

Edit run.sh, substitute your Docker Hub username, and run all architectures.

```bash
./run.sh
```

This works well if the build process is mostly file copying and software installation. This does not work well if complex commands must be emulated, such as compiling a large C++ project.

Running non-native images shows it can be done, but not practical for real workloads.

## Use a remote builder via ssh to build non-native architectures

Multi-arch images can be created without using buildx.

Edit remote-build.sh to fill in the username and IP address of a remote x86 machine which is accessible via ssh and has docker installed.
- Create and use a remote context
- Build for an architecture which is native to the remote machine
- Push the resulting image to Docker Hub

```bash
docker context create remote --docker "host=ssh://ubuntu@IP"
docker context use remote
docker build --platform linux/amd64 -t jasonrandrews/hello-world:latest-amd64  .
docker push jasonrandrews/hello-world:latest-amd64
```

Edit remote-build.sh and change to your Docker Hub username to try it.

```bash
./remote-build.sh
```

The new image can be run on any x86 machine. This is not a multi-arch image.

```bash
docker run --rm jasonrandrews/hello-world:latest-amd64
```

On the local Arm machine build the Arm image.

```bash
docker context use default
docker build --platform linux/arm64 -t jasonrandrews/hello-world:latest-arm64  .
docker push jasonrandrews/hello-world:latest-arm64
```

# Use docker manifest to create multi-arch images

To create a multi-arch image from multiple images use the docker manifest command. 

This makes it easy to build and test images on their native architecture (without the complexity of buildx) and join them together into a single image.

 Users will automatically get the right architecture when they run.

- Create a manifest with a list of multiple images, each for a different archichitecture
- Join them together into a single multi-arch image

```bash
docker manifest create jasonrandrews/hello-world:latest \
--amend jasonrandrews/hello-world:latest-arm64 \
--amend jasonrandrews/hello-world:latest-amd64
docker manifest push --purge jasonrandrews/hello-world:latest
```

