#!/usr/bin/env bash

set -eo pipefail

source project.properties
image_version_tag="${owner}/${project}:${version}"
image_latest_tag="${owner}/${project}:latest"
docker build --no-cache -t ${image_latest_tag} . --build-arg VERSION=${version}
docker push ${image_latest_tag}
docker tag ${image_latest_tag} ${image_version_tag}
docker push ${image_version_tag}


