# 直す

Kubernetesは直してくれないので、**人間が**直しましょう。正しいラベルを書いたファイルをapplyします。

## やること

```
kubectl apply -f ~/manifests/03-service/service-fixed.yaml
```{{exec}}

## 観察する

接続先が戻ったことを確認しましょう。

```
kubectl get endpointslices
```{{exec}}

ブラウザでもう一度アプリを開いてみてください。

[アプリを開く]({{TRAFFIC_HOST1_30080}})

開けたら「Check」を押しましょう。
