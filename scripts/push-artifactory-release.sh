#!/bin/bash
set -e

if [ "${TRAVIS_BRANCH}" != "master" ]; then
  echo "Not in master, exiting release."
fi

registry="${DOCKER_REGISTRY}"
image_base="${registry}/${NAME}"
tag="${image_base}:${TRAVIS_TAG}"

exec docker tag "${NAME}:${COMMIT}" "${tag}"
exec docker push "${tag}"

exec docker tag ${NAME}:${COMMIT} ${image_base}:latest
exec docker push ${image_base}:latest
