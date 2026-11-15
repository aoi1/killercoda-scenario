#!/bin/bash
# Deploymentの3つのPodがすべてReadyであること

READY=$(kubectl get deployment hello -o jsonpath='{.status.readyReplicas}')
[ "$READY" = "3" ]
