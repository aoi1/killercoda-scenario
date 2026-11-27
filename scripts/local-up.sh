#!/bin/bash
# 手元のマシン（Docker＋kind）でハンズオンの環境を準備する。
# リポジトリのルートで実行する：bash scripts/local-up.sh
set -euo pipefail

CLUSTER_NAME=${KIND_CLUSTER_NAME:-handson}
REPO_DIR=$(cd "$(dirname "$0")/.." && pwd)
cd "$REPO_DIR"

for command in docker kind kubectl; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "$command が見つかりません。docs/local/README.md を見てインストールしてください" >&2
    exit 1
  fi
done

if ! docker info >/dev/null 2>&1; then
  echo "Dockerが起動していません。Docker Desktopなどを起動してから、もう一度実行してください" >&2
  exit 1
fi

if kind get clusters | grep -qx "$CLUSTER_NAME"; then
  # アプリを開くには30080番ポートを外に出しておく必要がある。別の設定で作られたクラスタは使えない
  if ! docker port "${CLUSTER_NAME}-control-plane" 30080 >/dev/null 2>&1; then
    echo "kindのクラスタ「${CLUSTER_NAME}」はありますが、アプリ用の30080番ポートが使えない設定です。" >&2
    echo "次のコマンドで消してから、もう一度実行してください：kind delete cluster --name ${CLUSTER_NAME}" >&2
    exit 1
  fi
else
  kind create cluster --name "$CLUSTER_NAME" --config .devcontainer/kind-config.yaml
fi
kubectl config use-context "kind-${CLUSTER_NAME}"

# Killercodaと同じ ~/manifests/... のパスでYAMLを指定できるようにする
if [ ! -e ~/manifests ]; then
  ln -s "${REPO_DIR}/manifests" ~/manifests
elif [ "$(readlink ~/manifests)" != "${REPO_DIR}/manifests" ]; then
  echo "~/manifests がすでにあるので、そのままにします。手順のコマンドは ~/manifests を ${REPO_DIR}/manifests に読み替えてください" >&2
fi

KIND_CLUSTER_NAME=$CLUSTER_NAME bash setup.sh

echo
echo "準備ができました！ アプリは http://localhost:30080 で開けます（②でDeploymentを作ったあと）"
