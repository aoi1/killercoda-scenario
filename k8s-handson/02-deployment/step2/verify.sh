#!/bin/bash
# Podが消されて作り直された（Podが4回以上作られた）うえで、3つともReadyであること

CREATED=$(kubectl get events --field-selector reason=SuccessfulCreate,involvedObject.kind=ReplicaSet -o name | wc -l)
[ "$CREATED" -ge 4 ] || exit 1

READY=$(kubectl get deployment hello -o jsonpath='{.status.readyReplicas}')
[ "$READY" = "3" ]
