#!/bin/bash
# Deploymentのイメージが v1 に戻り、3つのPodがすべて新しい状態でReadyであること

IMAGE=$(kubectl get deployment hello -o jsonpath='{.spec.template.spec.containers[0].image}')
[ "$IMAGE" = "ghcr.io/aoi1/handson-app:v1" ] || exit 1

UPDATED=$(kubectl get deployment hello -o jsonpath='{.status.updatedReplicas}')
READY=$(kubectl get deployment hello -o jsonpath='{.status.readyReplicas}')
TOTAL=$(kubectl get deployment hello -o jsonpath='{.status.replicas}')
[ "$UPDATED" = "3" ] && [ "$READY" = "3" ] && [ "$TOTAL" = "3" ]
