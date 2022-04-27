#!/usr/bin/env bash

USERNAME=kail4ek

latest_release_version() {
  curl --silent "https://api.github.com/repos/fatedier/frp/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/' |
    sed -E 's/^v//'
}

frp_version=$(latest_release_version)

docker build \
  --tag "$USERNAME/frp:$frp_version" \
  --tag "$USERNAME/frp:latest" \
  --build-arg frp_version="$frp_version" \
  --compress \
  .

docker push --all-tags "$USERNAME/frp"
