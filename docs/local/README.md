# 手元のマシンで進める

ハンズオンは、手元のマシンでも進められます。方法は2つあります。

| 方法 | 向いている人 | 必要なもの |
|---|---|---|
| A. VS CodeのDev Containers | Codespacesと同じ環境で進めたい人 | Docker、VS Code、Dev Containers拡張機能 |
| B. kindとkubectlだけ | VS Codeを使わない人、すでにkindを使っている人 | Docker、kind、kubectl |

どちらも、Docker Desktopなどで**Dockerが起動している**必要があります。

## A. VS CodeのDev Containersで進める

Codespacesと同じ設定（`.devcontainer/`）を、手元のDockerで動かします。

1. このリポジトリをcloneして、VS Codeで開く

   ```
   git clone https://github.com/aoi1/killercoda-scenario.git
   code killercoda-scenario
   ```

2. 右下に表示される「コンテナーで再度開く（Reopen in Container）」を押す
   - 表示されないときは、コマンドパレット（`Ctrl + Shift + P`、Macは `Cmd + Shift + P`）で「Dev Containers: Reopen in Container」を実行してください
3. 準備が終わるまで数分待つ

あとは [Codespacesの手順](../codespaces/README.md) の「2. 準備ができたか確認する」から同じように進められます。アプリは、VS Codeの「ポート」タブから開くか、ブラウザで http://localhost:30080 を開いてください。

## B. kindとkubectlだけで進める

### 1. ツールをインストールする

- Docker：[Docker Desktop](https://www.docker.com/products/docker-desktop/) など
- kind：https://kind.sigs.k8s.io/docs/user/quick-start/#installation
- kubectl：https://kubernetes.io/ja/docs/tasks/tools/

Macで [Homebrew](https://brew.sh/ja/) を使っている場合は、次のコマンドでkindとkubectlをインストールできます。

```
brew install kind kubectl
```

### 2. 環境を準備する

リポジトリをcloneして、準備用のスクリプトを実行します。

```
git clone https://github.com/aoi1/killercoda-scenario.git
cd killercoda-scenario
bash scripts/local-up.sh
```

`準備ができました！` と表示されれば完了です。スクリプトは次のことをします。

- `handson` という名前のkindのクラスタを作る（アプリ用に30080番ポートを開ける）
- kubectlの接続先を、このクラスタに切り替える
- Killercodaと同じコマンドで進められるように、`~/manifests` にリポジトリの `manifests/` へのリンクを作る
- ハンズオンで使うイメージを、事前にクラスタに読み込む

<details><summary>「30080番ポートが使えない設定です」と表示されたときは</summary>

以前に別の設定で `handson` という名前のクラスタを作っていると、このメッセージが出ます。表示されたコマンドでクラスタを消してから、もう一度スクリプトを実行してください。

</details>

### 3. 手順を進める

[Codespacesの手順ページ](../codespaces/README.md#3-手順を進める) を見ながら進めてください。Codespacesとの違いは次のとおりです。

| やりたいこと | 手元のマシンでのやり方 |
|---|---|
| アプリを開く | ブラウザで http://localhost:30080 を開く |
| 「Check」の代わりに確かめる | リポジトリのディレクトリで `./.devcontainer/check.sh 01-pod 2` のように実行する（`check` の部分を読み替える） |

### 4. 終わったら

クラスタを消しておきましょう。

```
kind delete cluster --name handson
```

`~/manifests` のリンクも不要なら消してかまいません。

```
rm ~/manifests
```
