#!/bin/bash
set -ex
#
# The following env variables must be set:
# IMAGE_NAME
# DOCKER_EMAIL
# DOCKER_USERNAME
# DOCKER_PASSWORD
# DOCKER_REGISTRY
#
# TRAVIS_COMMIT
# TRAVIS_BRANCH
# TRAVIS_TAG (optional)

registry="${DOCKER_REGISTRY}"
image_base="${registry}/${IMAGE_NAME}"

if [ "${TRAVIS_BRANCH}" != "master" ]; then
  echo "Not in master, exiting release."
fi

# Log in to registry
docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}" "${registry}"

exec docker tag ${IMAGE_NAME}:${TRAVIS_COMMIT} ${image_base}:${TRAVIS_TAG}
exec docker push ${image_base}:${TRAVIS_TAG}

exec docker tag ${IMAGE_NAME}:${TRAVIS_COMMIT} ${image_base}:latest
exec docker push ${image_base}:latest
