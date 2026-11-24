#!/bin/bash
# Killercodaの「Check」ボタンの代わり。例：check 01-pod 2
# @REPO_DIR@ はインストール時にリポジトリのパスに置き換える

SCENARIO=${1:-}
STEP=${2:-}
VERIFY="@REPO_DIR@/k8s-handson/${SCENARIO}/step${STEP}/verify.sh"

if [ -z "$SCENARIO" ] || [ -z "$STEP" ] || [ ! -f "$VERIFY" ]; then
  echo "使い方：check <シナリオ> <ステップ番号>（例：check 01-pod 2）"
  exit 2
fi

if bash "$VERIFY" >/dev/null 2>&1; then
  echo "✅ できています！次に進みましょう"
else
  echo "❌ まだできていないようです。手順とヒントを見直してみましょう"
  exit 1
fi
