#!/bin/bash
# ブラウザからアプリを開けるように、Serviceを先に用意しておく（中身はステップ③で扱う）

kubectl apply -f /root/manifests/03-service/service.yaml
