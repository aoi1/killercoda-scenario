# 予備環境（GitHub Codespaces）で進める

Killercodaが使えないときは、GitHub Codespacesで同じハンズオンを進められます。ハンズオンのあとに、家で続きをやるときにも使えます。

GitHubのアカウントが必要です。個人のアカウントには毎月の無料枠があるので、このハンズオンだけなら料金はかかりません。

## 1. Codespacesを起動する

次のリンクを開いて、「Create codespace」を押してください。

**https://codespaces.new/aoi1/killercoda-scenario?quickstart=1**

ブラウザの中にエディタが開きます。準備が終わるまで、**数分**かかります。

## 2. 準備ができたか確認する

画面の下にあるターミナルで、次のコマンドを実行してください。

```
kubectl version
```

`Server Version` が表示されれば準備完了です。

<details><summary>ターミナルが見つからないときは</summary>

画面左上のメニュー（≡）から「ターミナル」→「新しいターミナル」を選んでください。

</details>

<details><summary>エラーが表示されるときは</summary>

まだ準備中です。1分ほど待ってから、もう一度実行してください。

</details>

## 3. 手順を進める

順番に進めてください。Killercodaとの違いは、各ページの最初に書いてあります。

1. [⓪ kubectlを使ってみる](00-kubectl.md)
2. [① Podをこわす](01-pod.md)
3. [② Deploymentをこわす](02-deployment.md)
4. [③ Serviceをこわす](03-service.md)

### Killercodaとの違い

| やりたいこと | Codespacesでのやり方 |
|---|---|
| コマンドを実行する | コピーして、画面下のターミナルに貼り付ける |
| 「Check」を押す | 手順に書いてある `check` コマンドを実行する |
| アプリを開く | 画面下の「**ポート**」タブを開き、`30080` の行にある地球儀のアイコンを押す |

## 4. 終わったら

Codespacesは、起動しているあいだ無料枠を使います。使い終わったら止めておきましょう。

- https://github.com/codespaces を開き、使ったCodespaceの「…」から「Stop codespace」を押す
- もう使わない場合は「Delete」で消してかまいません

## 手元のマシンで進めたいときは

[手元のマシンで進める](../local/README.md) を見てください。
