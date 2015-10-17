#!/bin/bash
set -e

docker push "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}"

if [ "${TRAVIS_BRANCH}" = "master" ] && [ "${TRAVIS_TAG}" ]; then

docker tag -f "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}" "${DOCKER_REGISTRY}/${NAME}:${TRAVIS_TAG}"
docker push "${DOCKER_REGISTRY}/${NAME}:${TRAVIS_TAG}"
docker tag -f "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}" "${DOCKER_REGISTRY}/${NAME}:latest"
docker push "${DOCKER_REGISTRY}/${NAME}:latest"

fi

if [ "${TRAVIS_BRANCH}" = "master" ] && [ "${TRAVIS_TAG}" = "stable" ]; then
  docker tag -f "${DOCKER_REGISTRY_DEV}/${NAME}:${TRAVIS_BRANCH}-${COMMIT}" "${DOCKER_REGISTRY}/${NAME}:stable"
  docker push "${DOCKER_REGISTRY}/${NAME}:stable"
fi
