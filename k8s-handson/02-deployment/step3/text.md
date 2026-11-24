# アップデートに失敗する

アプリを新しいバージョンに更新してみます。……ただし、このYAMLにはミスがあります。

## やること

```
kubectl apply -f ~/manifests/02-deployment/deployment-broken.yaml
```{{exec}}

## 観察する

Podの状態と、ブラウザのアプリを見てみましょう。

```
kubectl get pods
```{{exec}}

少し時間がかかることがあるので、何回か実行してみてください。

- 新しいPodはどんな状態になっていますか？
- アプリはまだ開けますか？ バージョンはいくつですか？

[アプリを開く]({{TRAFFIC_HOST1_30080}})

<details><summary>ヒント1：新しいPodはなぜ動かない？</summary>

状態が `ImagePullBackOff` のPodがあるはずです。そのPodの名前を使って、詳しい情報を表示してみましょう。**一番下の `Events` の部分**に原因が書いてあります。

```
kubectl describe pod <Pod名>
```

</details>

<details><summary>ヒント2：元のファイルと何が違う？</summary>

2つのファイルを比べてみましょう。

```
diff ~/manifests/02-deployment/deployment.yaml ~/manifests/02-deployment/deployment-broken.yaml
```{{exec}}

イメージのタグ（`:` の後ろ）が、存在しない `v2-typo` になっています。

</details>

## なぜ？

Deploymentは、Podを**少しずつ**入れ替えます（ローリングアップデート）。新しいPodが動かないあいだは古いPodを消さないので、更新に失敗しても**アプリは止まりません**。

確認できたら「Check」を押して次に進みましょう。
