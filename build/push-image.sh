#!/bin/bash
set -ev

declare -a tags
declare registry image_base

# Set built image base name
if [ "${TRAVIS_BRANCH}" = "master" ] && [ "${TRAVIS_TAG}" ]; then
  registry="${DOCKER_REGISTRY}"
  image_base="${DOCKER_REGISTRY}/${IMAGE_NAME}"
elif [ "${DOCKER_REGISTRY_DEV}" ]; then
  registry="${DOCKER_REGISTRY_DEV}"
  image_base="${DOCKER_REGISTRY_DEV}/${IMAGE_NAME}"
else
  echo "DOCKER_REGISTRY_DEV not set for a non release image, exiting."
  exit 1
fi

# Log in to registry
if [ "${registry}" ]; then
  echo docker login -e="${DOCKER_EMAIL}" -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}" ${registry}
else
  echo "Docker registry failed to set properly, exiting."
  exit 1
fi

# Pull requests (image:commit-branch-pr-prnum)
if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then
  tags+=("${image_base}:${TRAVIS_COMMIT}-${TRAVIS_BRANCH}-pr-${TRAVIS_PULL_REQUEST}")
fi

# If commit tagged in master, tag as version and latest
if [ "${TRAVIS_BRANCH}" = "master" ] && [ "${TRAVIS_TAG}" ]; then
  tags+=("${image_base}:${TRAVIS_TAG}")
  tags+=("${image_base}:latest")
else
  tags+=("${image_base}:${TRAVIS_COMMIT}-${TRAVIS_BRANCH}")
fi

# Tag and push all image tags
for tag in ${tags[@]}; do
  echo docker tag ${IMAGE_NAME}:${TRAVIS_COMMIT} ${tag}
done

# Push images (may add branch criteria in the future)
for tag in ${tags[@]}; do
  echo docker push ${tag}
done
