<!-- このファイルは scripts/gen-codespaces-docs.py で生成しています。直接編集しないでください -->
# ② Deploymentをこわす

> **Codespacesで進める場合の読み替え**
>
> - 画面の配置がKillercodaとは違います。手順はこのページを、ターミナルはCodespacesの画面下を使ってください
> - コマンドはクリックでは実行できません。コピーしてターミナルに貼り付けて実行してください
> - 「Check」を押すところでは、かわりに書かれている `check` コマンドを実行してください
> - 「START」「Next」のボタンはありません。そのまま読み進めてください

| シナリオ | こわすもの |
|---|---|
| ① | Pod |
| **②（いまここ）** | **Deployment** |
| ③ | Service |

①では、Podを消すと消えたままでした。今度は **Deployment**（デプロイメント）を使います。

Deploymentは、「Podを3つ動かしておいてほしい」のように**あるべき状態**を宣言しておくリソースです。

## Codespacesでの準備

Killercodaでは自動で準備される部分です。はじめる前に、次のコマンドを実行してください。

```
kubectl apply -f ~/manifests/03-service/service.yaml
```

## Deploymentを作る

### 準備：ターミナルをもう1つ開く

ターミナルの上にあるタブの「**+**」を押して、2つ目のターミナル（Tab 2）を開いてください。Tab 2では、Podの様子をずっと表示させておきます。

```
kubectl get pods -w
```

`-w` は「変化があるたびに表示する」オプションです。このコマンドは止めずに、そのまま流しておきます。

ここからは **Tab 1** に戻ってコマンドを実行してください。

### やること

```
kubectl apply -f ~/manifests/02-deployment/deployment.yaml
```

### 観察する

Tab 2を見てください。Podが**3つ**作られていくはずです。

3つとも `Running` になったら、ブラウザでアプリを開いてみましょう。

**アプリを開く**（「ポート」タブの `30080` の行にある地球儀のアイコンを押して開きます）

何回かリロードしてみてください。表示されるPod名が変わるのがわかります。

<details><summary>ヒント：アプリが開けないときは</summary>

Podが3つとも `Running` になっているか確認してから、もう一度開いてみてください。

```
kubectl get pods
```

</details>

確認できたら「Check」を押して次に進みましょう。

> **確認**：次のコマンドを実行してください。
>
> ```
> check 02-deployment 1
> ```

## Podを1つ消す

①と同じように、Podを1つ消してみます。

### やること

```
kubectl delete pod $(kubectl get pods -l app=hello -o jsonpath='{.items[0].metadata.name}')
```

> 長いコマンドですが、「`app=hello` というラベルがついたPodのうち、1つ目のPodを消す」という意味です。

### 観察する

Tab 2を見てください。何が起きましたか？ ①と比べてみましょう。

<details><summary>ヒント</summary>

消したPodが `Terminating` になるのと同時に、**新しい名前のPod**が作られているはずです。

```
kubectl get pods
```

</details>

### なぜ？

Deploymentは「Podが3つある」というあるべき状態を守ってくれます。1つ減ったことに気づいて、**Kubernetesが自動で**作り直してくれました。

確認できたら「Check」を押して次に進みましょう。

> **確認**：次のコマンドを実行してください。
>
> ```
> check 02-deployment 2
> ```

## アップデートに失敗する

アプリを新しいバージョンに更新してみます。……ただし、このYAMLにはミスがあります。

### やること

```
kubectl apply -f ~/manifests/02-deployment/deployment-broken.yaml
```

### 観察する

Tab 2と、ブラウザのアプリを見てみましょう。

- 新しいPodはどんな状態になっていますか？
- アプリはまだ開けますか？ バージョンはいくつですか？

**アプリを開く**（「ポート」タブの `30080` の行にある地球儀のアイコンを押して開きます）

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
```

イメージのタグ（`:` の後ろ）が、存在しない `v2-typo` になっています。

</details>

### なぜ？

Deploymentは、Podを**少しずつ**入れ替えます（ローリングアップデート）。新しいPodが動かないあいだは古いPodを消さないので、更新に失敗しても**アプリは止まりません**。

確認できたら「Check」を押して次に進みましょう。

> **確認**：次のコマンドを実行してください。
>
> ```
> check 02-deployment 3
> ```

## 元に戻す

Deploymentは、ひとつ前の状態を覚えています。元に戻してみましょう。

### やること

```
kubectl rollout undo deployment/hello
```

### 観察する

Tab 2で、`ImagePullBackOff` のPodが消えていくのを確認してください。

```
kubectl get pods
```

確認できたら、Tab 2のコマンドは `Ctrl + C` で止めてかまいません。

「Check」を押しましょう。

> **確認**：次のコマンドを実行してください。
>
> ```
> check 02-deployment 4
> ```

## ふりかえり：誰が直した？

| こわしたもの | どうなった？ | 誰が直した？ |
|---|---|---|
| ① Pod | 消えたまま戻らなかった。人間がもう一度作るしかなかった | **誰も直さない** |
| ② Deployment | 消しても自動で作り直された。更新に失敗してもアプリは止まらなかった | **Kubernetesが直した** |

「あるべき状態」を宣言しておくと、Kubernetesがその状態を守ってくれます。

では、Kubernetesでも直せない壊れ方はあるのでしょうか？ 次は **③ Serviceをこわす** に進みましょう。
