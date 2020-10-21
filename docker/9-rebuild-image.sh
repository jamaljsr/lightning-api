#!/bin/bash

set -e -x

docker build \
  -t guggero/lightning-api \
  --build-arg GITHUB_ACCESS_TOKEN=$GITHUB_ACCESS_TOKEN \
  docker/

docker push guggero/lightning-api
