# rahadiangg/deployment-tool

This docker image to help CI/CD Pipeline when need some tools

## How to build

Please use docker buildx because we need to get $TARGETARCH variable
```
docker buildx build -t rahadiangg/deployment-tool:latest --load .
```