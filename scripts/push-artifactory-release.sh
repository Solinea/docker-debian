#!/bin/bash
set -e

if [ "${TRAVIS_BRANCH}" != "master" ]; then
  echo "Not in master, exiting release."
fi

registry="${DOCKER_REGISTRY}"
image_base="${registry}/${IMAGE_NAME}"
tag="${image_base}:${TRAVIS_TAG}"

echo "Logging in to Docker registry..."
exec docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}" "${registry}"

echo "Tagging image..."
exec docker tag "${IMAGE_NAME}:${TRAVIS_COMMIT}" "${tag}"
exec docker tag ${IMAGE_NAME}:${TRAVIS_COMMIT} ${image_base}:latest

echo "Pushing tags..."
exec docker push "${tag}"
exec docker push ${image_base}:latest
