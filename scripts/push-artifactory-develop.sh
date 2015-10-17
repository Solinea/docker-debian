#!/bin/bash
set -e

registry="${DOCKER_REGISTRY_DEV}"
image_base="${registry}/${IMAGE_NAME}"
tag="${image_base}:${TRAVIS_COMMIT}-${TRAVIS_BRANCH}"

echo "Logging in to Docker registry..."
exec docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}" "${registry}"

echo "Tagging image..."
exec docker tag "${IMAGE_NAME}:${TRAVIS_COMMIT}" "${tag}"

echo "Pushing image..."
exec docker push "${tag}"
