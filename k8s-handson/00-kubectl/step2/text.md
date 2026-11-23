# クラスタの中をのぞいてみる

kubectlでよく使うのは `kubectl get <見たいもの>` です。いろいろなものを見てみましょう。

## やること1：ノードを見る

**ノード**は、コンテナが実際に動くマシンのことです。

```
kubectl get nodes
```{{exec}}

`STATUS` が `Ready` なら、このノードでコンテナを動かす準備ができています。この環境のノードは1台です。

## やること2：Podを見る

**Pod**は、Kubernetesでコンテナを動かすときの一番小さな単位です（シナリオ①でくわしく扱います）。

```
kubectl get pods
```{{exec}}

`No resources found in default namespace.` と表示されたはずです。まだ何もデプロイしていないので、Podはひとつもありません。

## やること3：Kubernetes自身のPodを見る

`-A` をつけると、Kubernetesが自分のために動かしているPodも含めて、すべてのPodを表示します。

```
kubectl get pods -A
```{{exec}}

たくさんのPodが動いていますね。実は**Kubernetes自身も、Podとして動いている**部分があります。

> これらのPodは、このあとのハンズオンでは触りません。こわさないように気をつけましょう。

確認できたら「Next」を押して次に進みましょう。
