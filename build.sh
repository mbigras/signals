#!/bin/bash
# Build latest and versioned docker image

docker build \
--tag mbigras/signals:$(cat VERSION) \
--build-arg VCS_REF=$(git rev-parse HEAD) \
--build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
--build-arg BUILD_VERSION=$(cat VERSION) \
.

docker build \
--tag mbigras/signals:latest \
--build-arg VCS_REF=$(git rev-parse HEAD) \
--build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
--build-arg BUILD_VERSION=$(cat VERSION) \
.
