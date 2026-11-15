# 元に戻す

Deploymentは、ひとつ前の状態を覚えています。元に戻してみましょう。

## やること

```
kubectl rollout undo deployment/hello
```{{exec}}

## 観察する

Tab 2で、`ImagePullBackOff` のPodが消えていくのを確認してください。

```
kubectl get pods
```{{exec}}

確認できたら、Tab 2のコマンドは `Ctrl + C` で止めてかまいません。

「Check」を押しましょう。
