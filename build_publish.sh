#!/bin/sh

set -e
set -x

export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y --no-install-recommends adduser net-tools iputils-ping procps

adduser --system --home /run/fr24feed --uid 900 --group --quiet fr24feed

mkdir -p /var/log/fr24feed
touch /etc/fr24feed.ini
chmod 0600 /etc/fr24feed.ini
chown fr24feed:fr24feed /var/log/fr24feed /etc/fr24feed.ini
