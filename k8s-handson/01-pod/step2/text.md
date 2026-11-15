# Podを消す

作ったPodを、わざと**消して**みます。

## やること

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

確認できたら「Check」を押しましょう。
