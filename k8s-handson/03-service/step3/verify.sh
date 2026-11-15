#!/bin/bash
# Serviceの接続先（EndpointSlice）にPodが1つ以上あること

ADDRESSES=$(kubectl get endpointslices -l kubernetes.io/service-name=hello -o jsonpath='{.items[*].endpoints[*].addresses[*]}')
[ -n "$ADDRESSES" ]
