#!/bin/bash
set -e

if [ "${TRAVIS_BRANCH}" != "master" ]; then
  echo "Not in master, exiting release."
fi

registry="${DOCKER_REGISTRY}"
image_base="${registry}/${NAME}"
tag="${image_base}:${TRAVIS_TAG}"

docker tag "${NAME}:${COMMIT}" "${tag}"
docker push "${tag}"

docker tag ${NAME}:${COMMIT} ${image_base}:latest
docker push ${image_base}:latest
