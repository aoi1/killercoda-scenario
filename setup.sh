#!/bin/bash
# 共通の初期化処理：ハンズオンで使うイメージを事前にpullしておく。
# 参加者全員が同時にpullしても待たされないようにするため。
set -euo pipefail

IMAGES=(
  ghcr.io/aoi1/handson-app:v1
  ghcr.io/aoi1/handson-app:v2
)

if command -v crictl >/dev/null 2>&1; then
  # Killercoda（kubeadm）：ノードのコンテナランタイムに直接pullする
  for image in "${IMAGES[@]}"; do
    crictl pull "$image"
  done
elif command -v kind >/dev/null 2>&1; then
  # 予備環境（kind）：手元でpullしてからkindのノードに読み込む
  for image in "${IMAGES[@]}"; do
    docker pull "$image"
    kind load docker-image "$image" --name "${KIND_CLUSTER_NAME:-handson}"
  done
else
  echo "crictl も kind も見つからないので、イメージの事前pullをスキップします" >&2
fi
