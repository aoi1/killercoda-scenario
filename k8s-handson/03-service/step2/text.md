# Serviceをこわす

## やること

```
kubectl apply -f ~/manifests/03-service/service-broken.yaml
```{{exec}}

## 観察する

ブラウザでアプリをリロードしてみてください。

[アプリを開く]({{TRAFFIC_HOST1_30080}})

Podの状態も見てみましょう。

```
kubectl get pods
```{{exec}}

Podはすべて `Running` なのに、アプリが開けません。なぜでしょう？

<details><summary>ヒント1：接続先を見てみよう</summary>

もう一度、Serviceの接続先を見てみましょう。さっきと何が違いますか？

```
kubectl get endpointslices
```{{exec}}

</details>

<details><summary>ヒント2：元のファイルと何が違う？</summary>

```
diff ~/manifests/03-service/service.yaml ~/manifests/03-service/service-broken.yaml
```{{exec}}

`selector`（どのラベルのPodにつなぐか）が `helo` になっています。でも、Podのラベルは `hello` です。

</details>

## なぜ？

Serviceは、`selector` に書かれたラベルを持つPodを探してつなぎます。ラベルが1文字ずれただけで、つなぐ相手が**ひとつも見つからなく**なりました。

Podは元気なので、Kubernetesから見ると「何も壊れていない」状態です。だから、Kubernetesは直してくれません。

確認できたら「Check」を押して次に進みましょう。
