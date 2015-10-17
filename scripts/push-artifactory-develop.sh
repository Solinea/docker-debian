#!/bin/bash
set -ev

registry="${DOCKER_REGISTRY_DEV}"
image_base="${registry}/${NAME}"
tag="${image_base}:${TRAVIS_BRANCH}-${COMMIT}"

exec docker tag "${NAME}:${COMMIT}" "${tag}"
exec docker push "${tag}"
