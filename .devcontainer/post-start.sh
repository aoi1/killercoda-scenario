#!/bin/bash
# Codespacesを再開したときに、止まっているkindのクラスタを起動し直す
set -uo pipefail

until docker info >/dev/null 2>&1; do sleep 1; done
docker start handson-control-plane >/dev/null 2>&1 || true
