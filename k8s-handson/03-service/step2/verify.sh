#!/bin/bash
# Serviceのselectorがずれていて、接続先（EndpointSlice）が空であること

SELECTOR=$(kubectl get service hello -o jsonpath='{.spec.selector.app}')
[ "$SELECTOR" = "helo" ] || exit 1

ADDRESSES=$(kubectl get endpointslices -l kubernetes.io/service-name=hello -o jsonpath='{.items[*].endpoints[*].addresses[*]}')
[ -z "$ADDRESSES" ]
