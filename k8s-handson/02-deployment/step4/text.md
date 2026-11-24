# 元に戻す

Deploymentは、ひとつ前の状態を覚えています。元に戻してみましょう。

## やること

```
kubectl rollout undo deployment/hello
```{{exec}}

## 観察する

`ImagePullBackOff` のPodが消えていくのを確認してください。何回か実行してみましょう。

```
kubectl get pods
```{{exec}}

「Check」を押しましょう。
