FROM alpine AS builder
#FROM arm32v7/alpine AS builder
RUN apk add build-base
WORKDIR /home
COPY hello.c .
RUN gcc "-DARCH=\"`uname -a`\"" hello.c -o hello
 

FROM alpine
#FROM arm32v7/alpine
WORKDIR /home
COPY --from=builder /home/hello .
CMD ["./hello"]
