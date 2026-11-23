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

少し待ってから、もう一度実行してみてください。Podはどうなりましたか？

<details><summary>ヒント</summary>

`No resources found in default namespace.` と表示されていれば、Podがひとつもない状態です。

Podがいなくなったまま、戻ってきません。大変です。壊れてしまいました。

</details>

確認できたら「Check」を押しましょう。
