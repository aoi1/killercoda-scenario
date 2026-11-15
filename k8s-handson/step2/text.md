# ② Deploymentをこわす

**Deployment**（デプロイメント）は、「Podを3つ動かしておいてほしい」のように**あるべき状態**を宣言しておくリソースです。

## 準備：ターミナルをもう1つ開く

ターミナルの上にあるタブの「**+**」を押して、2つ目のターミナル（Tab 2）を開いてください。Tab 2では、Podの様子をずっと表示させておきます。

```
kubectl get pods -w
```{{exec}}

`-w` は「変化があるたびに表示する」オプションです。このコマンドは止めずに、そのまま流しておきます。

ここからは **Tab 1** に戻ってコマンドを実行してください。

## やること1：Deploymentを作る

```
kubectl apply -f ~/manifests/02-deployment/deployment.yaml
```{{exec}}

Tab 2を見てください。Podが**3つ**作られていくはずです。

3つとも `Running` になったら、ブラウザでアプリを開いてみましょう。

[アプリを開く]({{TRAFFIC_HOST1_30080}})

何回かリロードしてみてください。表示されるPod名が変わるのがわかります。

> ブラウザから開けるように、入り口（Service）はこちらで用意しておきました。Serviceについてはステップ③で扱います。

## やること2：Podを1つ消す

ステップ①と同じように、Podを1つ消してみます。

```
kubectl delete pod $(kubectl get pods -l app=hello -o jsonpath='{.items[0].metadata.name}')
```{{exec}}

> 長いコマンドですが、「`app=hello` というラベルがついたPodのうち、1つ目のPodを消す」という意味です。

### 観察する

Tab 2を見てください。何が起きましたか？ ステップ①と比べてみましょう。

<details><summary>ヒント</summary>

消したPodが `Terminating` になるのと同時に、**新しい名前のPod**が作られているはずです。

```
kubectl get pods
```{{exec}}

</details>

### なぜ？

Deploymentは「Podが3つある」というあるべき状態を守ってくれます。1つ減ったことに気づいて、**Kubernetesが自動で**作り直してくれました。

## やること3：アップデートに失敗する

アプリを新しいバージョンに更新してみます。……ただし、このYAMLにはミスがあります。

```
kubectl apply -f ~/manifests/02-deployment/deployment-broken.yaml
```{{exec}}

### 観察する

Tab 2と、ブラウザのアプリを見てみましょう。

- 新しいPodはどんな状態になっていますか？
- アプリはまだ開けますか？ バージョンはいくつですか？

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

### なぜ？

Deploymentは、Podを**少しずつ**入れ替えます（ローリングアップデート）。新しいPodが動かないあいだは古いPodを消さないので、更新に失敗しても**アプリは止まりません**。

## やること4：元に戻す

Deploymentは、ひとつ前の状態を覚えています。元に戻してみましょう。

```
kubectl rollout undo deployment/hello
```{{exec}}

Tab 2で、`ImagePullBackOff` のPodが消えていくのを確認してください。

確認できたら、Tab 2のコマンドは `Ctrl + C` で止めてかまいません。

「Check」を押して次に進みましょう。
