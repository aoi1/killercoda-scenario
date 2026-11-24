<!-- このファイルは scripts/gen-codespaces-docs.py で生成しています。直接編集しないでください -->
# ③ Serviceをこわす

> **Codespacesで進める場合の読み替え**
>
> - 画面の配置がKillercodaとは違います。手順はこのページを、ターミナルはCodespacesの画面下を使ってください
> - コマンドはクリックでは実行できません。コピーしてターミナルに貼り付けて実行してください
> - 「Check」を押すところでは、かわりに書かれている `check` コマンドを実行してください
> - 「START」「Next」のボタンはありません。そのまま読み進めてください

| シナリオ | こわすもの |
|---|---|
| ① | Pod |
| ② | Deployment |
| **③（いまここ）** | **Service** |

**Service**（サービス）は、Podたちの**入り口**です。②でブラウザからアプリを開けていたのは、このServiceのおかげです。

このシナリオは、②が終わった状態（Deploymentで3つのPodが動いていて、Serviceでつながっている状態）から始まります。

## Codespacesでの準備

Killercodaでは自動で準備される部分です。はじめる前に、次のコマンドを実行してください。

```
kubectl apply -f ~/manifests/02-deployment/deployment.yaml
kubectl apply -f ~/manifests/03-service/service.yaml
kubectl rollout status deployment/hello --timeout=300s
```

## Serviceを見てみる

まずは、アプリが開けることを確認しましょう。何回かリロードすると、表示されるPod名が変わります。

**アプリを開く**（「ポート」タブの `30080` の行にある地球儀のアイコンを押して開きます）

### やること

Serviceを見てみましょう。

```
kubectl get service hello
```

Serviceが「どのPodにつなぐか」は、**ラベル**で決まっています。Podについているラベルを見てみましょう。`LABELS` の列に `app=hello` とあるはずです。

```
kubectl get pods --show-labels
```

Serviceが実際にどのPodにつないでいるか（接続先）も見てみましょう。`ENDPOINTS` に、PodのIPアドレスが3つ並んでいるはずです。

```
kubectl get endpointslices
```

確認できたら「Next」を押して次に進みましょう。

## Serviceをこわす

### やること

```
kubectl apply -f ~/manifests/03-service/service-broken.yaml
```

### 観察する

ブラウザでアプリをリロードしてみてください。

**アプリを開く**（「ポート」タブの `30080` の行にある地球儀のアイコンを押して開きます）

Podの状態も見てみましょう。

```
kubectl get pods
```

Podはすべて `Running` なのに、アプリが開けません。なぜでしょう？

<details><summary>ヒント1：接続先を見てみよう</summary>

もう一度、Serviceの接続先を見てみましょう。さっきと何が違いますか？

```
kubectl get endpointslices
```

</details>

<details><summary>ヒント2：元のファイルと何が違う？</summary>

```
diff ~/manifests/03-service/service.yaml ~/manifests/03-service/service-broken.yaml
```

`selector`（どのラベルのPodにつなぐか）が `helo` になっています。でも、Podのラベルは `hello` です。

</details>

### なぜ？

Serviceは、`selector` に書かれたラベルを持つPodを探してつなぎます。ラベルが1文字ずれただけで、つなぐ相手が**ひとつも見つからなく**なりました。

Podは元気なので、Kubernetesから見ると「何も壊れていない」状態です。だから、Kubernetesは直してくれません。

確認できたら「Check」を押して次に進みましょう。

> **確認**：次のコマンドを実行してください。
>
> ```
> check 03-service 2
> ```

## 直す

Kubernetesは直してくれないので、**人間が**直しましょう。正しいラベルを書いたファイルをapplyします。

### やること

```
kubectl apply -f ~/manifests/03-service/service-fixed.yaml
```

### 観察する

接続先が戻ったことを確認しましょう。

```
kubectl get endpointslices
```

ブラウザでもう一度アプリを開いてみてください。

**アプリを開く**（「ポート」タブの `30080` の行にある地球儀のアイコンを押して開きます）

開けたら「Check」を押しましょう。

> **確認**：次のコマンドを実行してください。
>
> ```
> check 03-service 3
> ```

## ふりかえり：誰が直した？

おつかれさまでした！ 3つのリソースをこわしてみました。

| こわしたもの | どうなった？ | 誰が直した？ |
|---|---|---|
| ① Pod | 消えたまま戻らなかった。人間がもう一度作るしかなかった | **誰も直さない** |
| ② Deployment | 消しても自動で作り直された。更新に失敗してもアプリは止まらなかった | **Kubernetesが直した** |
| ③ Service | Podは元気なのにつながらなかった | **人間が直した** |

- **Pod**：コンテナを入れる箱。それだけでは誰も面倒を見てくれない
- **Deployment**：「あるべき状態」を宣言しておくと、Kubernetesがその状態を守ってくれる
- **Service**：ラベルで相手を探す入り口。ラベルがずれると、Kubernetesにも気づけない

### おまけ（時間が余った人向け）

#### おまけ1：Podを5つに増やす

```
kubectl scale deployment hello --replicas=5
```

```
kubectl get pods
```

ブラウザで何回かリロードしてみましょう。表示されるPod名の種類は増えましたか？

**アプリを開く**（「ポート」タブの `30080` の行にある地球儀のアイコンを押して開きます）

#### おまけ2：本当にv2に更新する

今度は正しいタグ（`v2`）のファイルです。

```
kubectl apply -f ~/manifests/04-bonus/deployment-v2.yaml
```

```
kubectl get pods -w
```

更新が終わったら（`Ctrl + C` で止めてください）、ブラウザでリロードしてみましょう。画面の色とバージョンが変わるはずです。

<details><summary>ヒント</summary>

`deployment-v2.yaml` の `replicas` は3です。おまけ1で5つに増やしていた場合は、3つに戻ります。YAMLに書いた状態が「あるべき状態」になるからです。

</details>
