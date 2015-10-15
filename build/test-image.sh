#!/bin/bash
set -ev

docker run -ti $IMAGE_NAME:$TRAVIS_COMMIT echo Success