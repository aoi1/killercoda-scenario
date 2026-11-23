#!/bin/bash
# クラスタが使えるようになるまで待つ
set -x

until kubectl get nodes; do sleep 1; done

touch /tmp/handson-ready
