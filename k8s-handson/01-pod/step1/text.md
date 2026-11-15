# Podを作る

**Pod**（ポッド）は、Kubernetesでコンテナを動かすときの一番小さな単位です。まずはPodを1つだけ作ってみましょう。

## やること

配布済みのYAMLファイルを使って、Podを作ります。

```
kubectl apply -f ~/manifests/01-pod/pod.yaml
```{{exec}}

Podの状態を見てみましょう。

```
kubectl get pods
```{{exec}}

## 観察する

`STATUS` が `Running` になるまで、何回か `kubectl get pods` を実行してみてください。

<details><summary>ヒント</summary>

`ContainerCreating` と表示されているあいだは、コンテナを準備中です。少し待ってからもう一度実行してみましょう。

</details>

`Running` になったら「Check」を押して次に進みましょう。
