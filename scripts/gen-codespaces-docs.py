#!/usr/bin/env python3
"""Killercodaのシナリオから、予備環境（Codespaces）用の手順ページを生成する。

シナリオの文章を直したら、リポジトリのルートで次を実行して生成し直すこと。
    python3 scripts/gen-codespaces-docs.py
"""
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
COURSE = ROOT / "k8s-handson"
OUT = ROOT / "docs" / "codespaces"

APP_LINK = "（「ポート」タブの `30080` の行にある地球儀のアイコンを押して開きます）"

NOTE = """> **Codespacesで進める場合の読み替え**
>
> - 画面の配置がKillercodaとは違います。手順はこのページを、ターミナルはCodespacesの画面下を使ってください
> - コマンドはクリックでは実行できません。コピーしてターミナルに貼り付けて実行してください
> - 「Check」を押すところでは、かわりに書かれている `check` コマンドを実行してください
> - 「START」「Next」のボタンはありません。そのまま読み進めてください
"""


def convert(text, demote=True):
    """Killercoda専用の記法を、GitHubで読める形に置き換える"""
    # ```{{exec}} や `cmd`{{exec}} などの実行用の記法を外す
    text = re.sub(r"```\{\{[^}]*\}\}", "```", text)
    text = re.sub(r"`([^`\n]+)`\{\{[^}]*\}\}", r"`\1`", text)
    # ブラウザでアプリを開くリンクを、Codespacesでの開き方に置き換える
    text = re.sub(r"\[([^\]]+)\]\(\{\{TRAFFIC_HOST1_30080\}\}\)", r"**\1**" + APP_LINK, text)
    # 見出しを1段下げる（ページのタイトルを # にするため）
    if demote:
        text = re.sub(r"^(#+) ", r"#\1 ", text, flags=re.MULTILINE)
    return text.strip() + "\n"


def setup_commands(scenario_dir, details):
    """Killercodaの初期化スクリプトのうち、クラスタを準備しているkubectlの行を取り出す"""
    background = details["intro"].get("background")
    if not background:
        return []
    lines = (scenario_dir / background).read_text().splitlines()
    return [
        line.replace("/root/manifests", "~/manifests")
        for line in lines
        if line.startswith("kubectl ") and not line.startswith("kubectl get")
    ]


def generate(name):
    scenario_dir = COURSE / name
    index = json.loads((scenario_dir / "index.json").read_text())
    details = index["details"]

    # introの1行目（# タイトル）をページのタイトルにする。
    # 「## 準備」の節はKillercodaの起動待ちの説明なので、Codespacesでは使わない
    intro = convert((scenario_dir / details["intro"]["text"]).read_text(), demote=False)
    intro = re.sub(r"^## 準備\n.*?(?=^#|\Z)", "", intro, flags=re.MULTILINE | re.DOTALL)
    title, _, intro_body = intro.partition("\n")

    parts = [
        "<!-- このファイルは scripts/gen-codespaces-docs.py で生成しています。直接編集しないでください -->",
        title + "\n",
        NOTE,
        intro_body.strip() + "\n",
    ]

    commands = setup_commands(scenario_dir, details)
    if commands:
        parts.append(
            "## Codespacesでの準備\n\n"
            "Killercodaでは自動で準備される部分です。はじめる前に、次のコマンドを実行してください。\n\n"
            "```\n" + "\n".join(commands) + "\n```\n"
        )

    for number, step in enumerate(details["steps"], start=1):
        parts.append(convert((scenario_dir / step["text"]).read_text()))
        if "verify" in step:
            parts.append(f"> **確認**：次のコマンドを実行してください。\n>\n> ```\n> check {name} {number}\n> ```\n")

    if "finish" in details:
        parts.append(convert((scenario_dir / details["finish"]["text"]).read_text()))

    (OUT / f"{name}.md").write_text("\n".join(parts))


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    structure = json.loads((COURSE / "structure.json").read_text())
    for item in structure["items"]:
        generate(item["path"])
        print(f"generated docs/codespaces/{item['path']}.md")


if __name__ == "__main__":
    main()
