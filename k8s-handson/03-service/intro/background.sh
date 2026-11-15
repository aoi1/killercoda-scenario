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

until kubectl get nodes; do sleep 1; done

# シナリオ②が終わった状態（Deploymentが動いていて、Serviceでつながる）から始める
kubectl apply -f /root/manifests/02-deployment/deployment.yaml
kubectl apply -f /root/manifests/03-service/service.yaml
kubectl rollout status deployment/hello --timeout=300s

touch /tmp/handson-ready
