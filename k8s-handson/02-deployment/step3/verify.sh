#!/bin/bash
# 壊れたイメージ（v2-typo）に更新されていること

IMAGE=$(kubectl get deployment hello -o jsonpath='{.spec.template.spec.containers[0].image}')
[ "$IMAGE" = "ghcr.io/aoi1/handson-app:v2-typo" ]
