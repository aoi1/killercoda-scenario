# Podを復活させる

Podは自分では戻ってきません。**人間が**もう一度作ってあげましょう。

## やること

最初と同じYAMLファイルを、もう一度applyします。

```
kubectl apply -f ~/manifests/01-pod/pod.yaml
```{{exec}}

## 観察する

Podの状態を見てみましょう。

```
kubectl get pods
```{{exec}}

`STATUS` が `Running` になるまで、何回か実行してみてください。

<details><summary>ヒント</summary>

`kubectl apply -f` は「ファイルに書いた状態にしてほしい」とお願いするコマンドです。Podがない状態でapplyしたので、もう一度作られました。

</details>

## なぜ？

Podが消えても、誰も気づいてくれません。復活させるには、人間が気づいて、もう一度作るしかありません。

`Running` になったら「Check」を押しましょう。
