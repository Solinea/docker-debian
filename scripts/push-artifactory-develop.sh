#!/bin/bash
set -ev
#
# The following env variables must be set:
# IMAGE_NAME
# DOCKER_EMAIL
# DOCKER_USERNAME
# DOCKER_PASSWORD
# DOCKER_REGISTRY
# DOCKER_REGISTRY_DEV
#
# TRAVIS_COMMIT
# TRAVIS_BRANCH

registry="${DOCKER_REGISTRY_DEV}"
image_base="${registry}/${IMAGE_NAME}"
tag="${image_base}:${TRAVIS_COMMIT}-${TRAVIS_BRANCH}"

# Log in to registry
docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}" "${registry}"

exec docker tag ${IMAGE_NAME}:${TRAVIS_COMMIT} ${tag}

exec docker push ${tag}
