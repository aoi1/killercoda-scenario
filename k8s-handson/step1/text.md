# ① Podをこわす

**Pod**（ポッド）は、Kubernetesでコンテナを動かすときの一番小さな単位です。まずはPodを1つだけ作ってみましょう。

## やること

配布済みのYAMLファイルを使って、Podを作ります。

```
kubectl apply -f ~/manifests/01-pod/pod.yaml
```{{exec}}

Podの状態を見てみましょう。`STATUS` が `Running` になるまで、何回か実行してみてください。

```
kubectl get pods
```{{exec}}

`Running` になったら、このPodを**消して**みます。

```
kubectl delete pod hello-pod
```{{exec}}

## 観察する

もう一度、Podの状態を見てみましょう。

```
kubectl get pods
```{{exec}}

少し待ってから、もう一度実行してみてください。Podは戻ってきましたか？

<details><summary>ヒント</summary>

`No resources found in default namespace.` と表示されていれば、Podがひとつもない状態です。

</details>

## なぜ？

Podは「コンテナを入れる箱」でしかありません。消されたことに気づいて作り直してくれる**管理人がいない**ので、消えたままになります。

できたら「Check」を押して次に進みましょう。
