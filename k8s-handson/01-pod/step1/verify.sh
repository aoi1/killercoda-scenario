#!/bin/bash
# hello-pod がReadyであること

kubectl wait --for=condition=Ready pod/hello-pod --timeout=1s
