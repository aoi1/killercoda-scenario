#!/bin/bash
# kubectl get pods -w が実行中であること

pgrep -f 'kubectl get (po|pods?)( .*)? (-w|--watch)' >/dev/null
