#!/bin/sh

set -e
set -x

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y --no-install-recommends install curl jq ca-certificates tar

DEB_ARCH=$(dpkg --print-architecture)
case "$DEB_ARCH" in
  i386)
    FR24_URL="$(curl -s https://repo-feed.flightradar24.com/fr24feed_versions.json | jq -r '.platform.linux_x86_tgz.url.software')"
    ;;
  amd64)
    FR24_URL="$(curl -s https://repo-feed.flightradar24.com/fr24feed_versions.json | jq -r '.platform.linux_x86_64_tgz.url.software')"
    ;;
  arm64)
    FR24_URL="$(curl -s https://repo-feed.flightradar24.com/fr24feed_versions.json | jq -r '.platform.linux_arm_tgz.url.software')"
    ;;
  armhf)
    FR24_URL="$(curl -s https://repo-feed.flightradar24.com/fr24feed_versions.json | jq -r '.platform.linux_arm_tgz.url.software')"
    ;;
  *)
    echo "Unknown architecture: $DEB_ARCH"
    exit 1
esac

if [ -z "$FR24_URL" ]; then
  echo "Cannot find platform URL from https://repo-feed.flightradar24.com/fr24feed_versions.json"
  exit 1
fi

curl -v -o fr24feed.tgz "$FR24_URL"
tar zxvf fr24feed.tgz
cp fr24feed_*/fr24feed .
chmod 0755 fr24feed
