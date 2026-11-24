# Deploymentを作る

## やること

```
kubectl apply -f ~/manifests/02-deployment/deployment.yaml
```{{exec}}

## 観察する

Podの状態を見てみましょう。

```
kubectl get pods
```{{exec}}

Podが**3つ**作られているはずです。3つとも `STATUS` が `Running` になるまで、何回か実行してみてください。

3つとも `Running` になったら、ブラウザでアプリを開いてみましょう。

[アプリを開く]({{TRAFFIC_HOST1_30080}})

何回かリロードしてみてください。表示されるPod名が変わるのがわかります。

<details><summary>ヒント：アプリが開けないときは</summary>

Podが3つとも `Running` になっているか確認してから、もう一度開いてみてください。

```
kubectl get pods
```{{exec}}

</details>

確認できたら「Check」を押して次に進みましょう。
