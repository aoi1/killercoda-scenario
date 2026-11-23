# ふりかえり：誰が直した？

おつかれさまでした！ 3つのリソースをこわしてみました。

| こわしたもの | どうなった？ | 誰が直した？ |
|---|---|---|
| ① Pod | 消えたまま戻らなかった。人間がもう一度作るしかなかった | **誰も直さない** |
| ② Deployment | 消しても自動で作り直された。更新に失敗してもアプリは止まらなかった | **Kubernetesが直した** |
| ③ Service | Podは元気なのにつながらなかった | **人間が直した** |

- **Pod**：コンテナを入れる箱。それだけでは誰も面倒を見てくれない
- **Deployment**：「あるべき状態」を宣言しておくと、Kubernetesがその状態を守ってくれる
- **Service**：ラベルで相手を探す入り口。ラベルがずれると、Kubernetesにも気づけない

## おまけ（時間が余った人向け）

### おまけ1：Podを5つに増やす

```
kubectl scale deployment hello --replicas=5
```{{exec}}

```
kubectl get pods
```{{exec}}

ブラウザで何回かリロードしてみましょう。表示されるPod名の種類は増えましたか？

[アプリを開く]({{TRAFFIC_HOST1_30080}})

### おまけ2：本当にv2に更新する

今度は正しいタグ（`v2`）のファイルです。

```
kubectl apply -f ~/manifests/04-bonus/deployment-v2.yaml
```{{exec}}

```
kubectl get pods -w
```{{exec}}

更新が終わったら（`Ctrl + C` で止めてください）、ブラウザでリロードしてみましょう。画面の色とバージョンが変わるはずです。

<details><summary>ヒント</summary>

`deployment-v2.yaml` の `replicas` は3です。おまけ1で5つに増やしていた場合は、3つに戻ります。YAMLに書いた状態が「あるべき状態」になるからです。

</details>
