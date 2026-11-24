#!/bin/bash
# Codespacesの作成時に一度だけ実行する：kindのクラスタを作り、Killercodaと同じ手順で進められるようにする
set -euo pipefail

KIND_VERSION=v0.31.0
CLUSTER_NAME=handson
REPO_DIR=$(pwd)

curl -fsSLo /tmp/kind "https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-$(dpkg --print-architecture)"
sudo install -m 755 /tmp/kind /usr/local/bin/kind

# Killercodaの「Check」ボタンの代わりに、check コマンドでverifyスクリプトを実行できるようにする
sed "s|@REPO_DIR@|${REPO_DIR}|" .devcontainer/check.sh > /tmp/check
sudo install -m 755 /tmp/check /usr/local/bin/check

until docker info >/dev/null 2>&1; do sleep 1; done
kind get clusters | grep -qx "$CLUSTER_NAME" ||
  kind create cluster --name "$CLUSTER_NAME" --config .devcontainer/kind-config.yaml

# Killercodaと同じ ~/manifests/... のパスでYAMLを指定できるようにする
ln -sfn "${REPO_DIR}/manifests" ~/manifests

KIND_CLUSTER_NAME=$CLUSTER_NAME bash setup.sh

echo "準備ができました！"
