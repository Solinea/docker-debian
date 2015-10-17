#!/bin/bash
set -ex

docker tag -f "${NAME}" "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}"

# Tag & Push 'branch-commit' tag to Development Registry
docker push "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}"

if [ "${TRAVIS_TAG}" ]; then
  # Tag & Push Version tag to Development Registry
  docker tag -f "${NAME}" "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}"
  docker push "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}"

  # Tag & Push 'latest' tag to Development Registry
  docker tag -f "${NAME}" "${DOCKER_REGISTRY_DEV}/${NAME}:latest"
  docker push "${DOCKER_REGISTRY_DEV}/${NAME}:latest"

  # Tag & Push Version tag to Release Registry
  docker tag -f "${NAME}" "${DOCKER_REGISTRY}/${NAME}:${TRAVIS_BRANCH}"
  docker push "${DOCKER_REGISTRY}/${NAME}:${TRAVIS_BRANCH}"

  # Tag & Push 'latest' tag to Release Registry
  docker tag -f "${NAME}" "${DOCKER_REGISTRY}/${NAME}:latest"
  docker push "${DOCKER_REGISTRY}/${NAME}:latest"
fi

if [ "${TRAVIS_BRANCH}" = "stable" ] && [ "${TRAVIS_TAG}" ]; then
  # Tag & Push 'stable' to Release Registry
  docker tag -f "${NAME}" "${DOCKER_REGISTRY}/${NAME}:stable"
  docker push "${DOCKER_REGISTRY}/${NAME}:stable"
fi

docker images "${DOCKER_REGISTRY_DEV}/${NAME}"

echo Push complete.
