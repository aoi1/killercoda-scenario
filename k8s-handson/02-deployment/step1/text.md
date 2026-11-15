# Deploymentを作る

## 準備：ターミナルをもう1つ開く

ターミナルの上にあるタブの「**+**」を押して、2つ目のターミナル（Tab 2）を開いてください。Tab 2では、Podの様子をずっと表示させておきます。

```
kubectl get pods -w
```{{exec}}

`-w` は「変化があるたびに表示する」オプションです。このコマンドは止めずに、そのまま流しておきます。

ここからは **Tab 1** に戻ってコマンドを実行してください。

## やること

```
kubectl apply -f ~/manifests/02-deployment/deployment.yaml
```{{exec}}

## 観察する

Tab 2を見てください。Podが**3つ**作られていくはずです。

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
