#!/bin/bash
# hello-pod を一度作って（イベントが残っている）、いまは存在しないこと

kubectl get events --field-selector involvedObject.name=hello-pod -o name | grep -q . || exit 1
if kubectl get pod hello-pod; then exit 1; fi
