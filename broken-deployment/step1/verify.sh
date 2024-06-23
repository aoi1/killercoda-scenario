#!/bin/bash
# Get the names of all Pods created by the Deployment
PODS=$(kubectl get pods -l app=my-app -o jsonpath='{.items[*].metadata.name}')
echo $PODS

# Check if each Pod is in Running state
# for POD in $PODS; do
# STATUS=$(kubectl get pod $POD -o jsonpath='{.status.phase}')
# if [ "$STATUS" != "Running" ]; then
#   exit 1
# fi
# done
# 
# exit 0
