# Podを1つ消す

①と同じように、Podを1つ消してみます。

## やること

```
kubectl delete pod $(kubectl get pods -l app=hello -o jsonpath='{.items[0].metadata.name}')
```{{exec}}

> 長いコマンドですが、「`app=hello` というラベルがついたPodのうち、1つ目のPodを消す」という意味です。

## 観察する

Tab 2を見てください。何が起きましたか？ ①と比べてみましょう。

<details><summary>ヒント</summary>

消したPodが `Terminating` になるのと同時に、**新しい名前のPod**が作られているはずです。

```
kubectl get pods
```{{exec}}

</details>

## なぜ？

Deploymentは「Podが3つある」というあるべき状態を守ってくれます。1つ減ったことに気づいて、**Kubernetesが自動で**作り直してくれました。

確認できたら「Check」を押して次に進みましょう。
