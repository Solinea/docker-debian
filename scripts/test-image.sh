#!/bin/bash
set -ev

docker images --digests "${DOCKER_REGISTRY_DEV}/${NAME}"

docker run -ti "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}" echo Success