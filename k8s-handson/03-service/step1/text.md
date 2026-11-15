# Serviceを見てみる

まずは、アプリが開けることを確認しましょう。何回かリロードすると、表示されるPod名が変わります。

[アプリを開く]({{TRAFFIC_HOST1_30080}})

## やること

Serviceを見てみましょう。

```
kubectl get service hello
```{{exec}}

Serviceが「どのPodにつなぐか」は、**ラベル**で決まっています。Podについているラベルを見てみましょう。`LABELS` の列に `app=hello` とあるはずです。

```
kubectl get pods --show-labels
```{{exec}}

Serviceが実際にどのPodにつないでいるか（接続先）も見てみましょう。`ENDPOINTS` に、PodのIPアドレスが3つ並んでいるはずです。

```
kubectl get endpointslices
```{{exec}}

確認できたら「Next」を押して次に進みましょう。
