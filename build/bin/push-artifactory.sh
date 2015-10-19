#!/bin/bash
set -ex

# Tag & Push 'branch-commit' tag to Development Registry
docker tag -f "${NAME}" "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}"
docker push "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}"

if [ "${TRAVIS_TAG}" ]; then
  # Tag & Push Version tag to Release Registry
  docker tag -f "${NAME}" "${DOCKER_REGISTRY}/${NAME}:${TRAVIS_BRANCH}"
  docker push "${DOCKER_REGISTRY}/${NAME}:${TRAVIS_BRANCH}"

  # Tag & Push Version tag to Docker Hub
  docker tag -f "${NAME}" "solinea/${NAME}:${TRAVIS_BRANCH}"
  docker push "solinea/${NAME}:${TRAVIS_BRANCH}"
fi

docker images "${DOCKER_REGISTRY_DEV}/${NAME}"

echo Push complete.
