#!/bin/bash
# 配布するYAMLを配置し、イメージを事前にpullする
set -x

REPO=https://github.com/aoi1/killercoda-scenario.git

for i in 1 2 3 4 5; do
  git clone --depth 1 "$REPO" /opt/handson && break
  rm -rf /opt/handson
  sleep 3
done

cp -r /opt/handson/manifests /root/manifests
bash /opt/handson/setup.sh

touch /tmp/handson-ready
