# Podを1つ消す

①と同じように、Podを1つ消してみます。

## やること

消す前に、いまのPodの名前を見ておきましょう。

```
kubectl get pods
```{{exec}}

Podを1つ消します。

```
kubectl delete pod $(kubectl get pods -l app=hello -o jsonpath='{.items[0].metadata.name}')
```{{exec}}

> 長いコマンドですが、「`app=hello` というラベルがついたPodのうち、1つ目のPodを消す」という意味です。

## 観察する

もう一度、Podの状態を見てみましょう。

```
kubectl get pods
```{{exec}}

消す前と比べて、何が変わりましたか？ ①と比べてみましょう。

<details><summary>ヒント</summary>

- Podの数は3つのままです
- 消したPodの名前がなくなり、**新しい名前のPod**が1つ増えています
- 新しいPodは、`AGE`（作られてからの時間）がほかのPodより短くなっています

</details>

## なぜ？

Deploymentは「Podが3つある」というあるべき状態を守ってくれます。1つ減ったことに気づいて、**Kubernetesが自動で**作り直してくれました。

確認できたら「Check」を押して次に進みましょう。
