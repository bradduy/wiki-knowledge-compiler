<p align="center">
  <a href="./README.md">🇬🇧 English</a> &nbsp;·&nbsp;
  <a href="./README_VN.md">🇻🇳 Tiếng Việt</a> &nbsp;·&nbsp;
  <a href="./README_CN.md">🇨🇳 简体中文</a> &nbsp;·&nbsp;
  <a href="./README_KR.md">🇰🇷 한국어</a> &nbsp;·&nbsp;
  🇯🇵 <strong>日本語</strong> &nbsp;·&nbsp;
  <a href="./README_DE.md">🇩🇪 Deutsch</a> &nbsp;·&nbsp;
  <a href="./README_FR.md">🇫🇷 Français</a> &nbsp;·&nbsp;
  <a href="./README_RU.md">🇷🇺 Русский</a>
</p>

<h1 align="center">Wiki Knowledge Compiler</h1>

<p align="center">
  <em>ドキュメントをパーソナルナレッジベースに — AI搭載、シンプルなファイルで保存。</em>
</p>

<p align="center">
  <a href="https://github.com/bradduy/wiki-knowledge-compiler/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License" /></a>
  <a href="https://github.com/bradduy/wiki-knowledge-compiler"><img src="https://img.shields.io/badge/platform-Claude%20Code-blueviolet.svg" alt="Claude Code" /></a>
  <a href="https://obsidian.md"><img src="https://img.shields.io/badge/works%20with-Obsidian-7C3AED.svg" alt="Works with Obsidian" /></a>
  <img src="https://img.shields.io/badge/offline-100%25-brightgreen.svg" alt="100% Offline" />
</p>

<p align="center">
  <img src="./assets/demo.gif" alt="Wiki Knowledge Compiler Demo" width="100%" />
</p>

<p align="center">
  <img src="./assets/logo.png" alt="Wiki Knowledge Compiler Logo" width="100%" />
</p>

---

# 🇯🇵 日本語

## 📖 これは何ですか？

[Claude Code](https://docs.anthropic.com/en/docs/claude-code) 用のプラグインで、ドキュメントを整理された検索可能なナレッジベースに変換します。

何でも入力できます — 記事、メモ、PDF、フォルダ丸ごと — プラグインが以下を行います：

1. **保存** 原本を保管します（変更は一切加えません）
2. **要約** 各ソースを要約します
3. **抽出** キーアイデアを個別のページにします
4. **接続** 追加したすべての資料から関連するアイデアを結びつけます
5. **回答** ソースへのリンク付きで質問に答えます

すべてがプレーンテキストファイルとしてコンピュータに保存されます。クラウド不要。データベース不要。ロックイン不要。

---

## 🚀 クイックスタート

3ステップ。すべて自動でインストールされます — 手動での設定は不要です。

**ステップ 1 — プラグインをインストール：**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
その後 `/plugin` → **wiki-knowledge-compiler** マーケットプレイスを選択 → プラグインを選択 → **scope を有効化**。このステップでプラグインに実行権限を付与します — 有効化後に `/wiki-` コマンドが表示されます。

**ステップ 2 — セットアップを実行：**
```
/wiki-setup
```
プロジェクトの規模を選択します（小・中・大）。プラグインが残りをすべて処理します — 必要なツールのインストール、wiki フォルダの作成、さらに [Obsidian](https://obsidian.md) のセットアップも提案します。

**ステップ 3 — 最初のドキュメントを追加：**
```
/wiki-ingest ~/Documents/my-article.md
```

完了。wiki が稼働しました。

---

## 🎯 できること

各コマンドは次に試すべきことを教えてくれるので、常に次のステップがわかります。

| コマンド | 機能 |
|---------|-------------|
| `/wiki-setup` | 初回セットアップ（すべて自動インストール） |
| `/wiki-ingest` | ドキュメントを追加 — ファイル1つ、フォルダ丸ごと、または URL |
| `/wiki` | 質問してソース付きの回答を取得 |
| `/wiki-insights` | ソース間のパターンとつながりを発見 |
| `/wiki-update` | 目次を更新 |

**推奨順序：** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update`

---

## 📥 ドキュメントの追加

さまざまな方法でドキュメントを追加できます：

```bash
# ファイル1つ
/wiki-ingest ~/Documents/article.md

# フォルダ丸ごと（中身をすべてスキャン）
/wiki-ingest ~/Documents/research/

# 複数ファイルを一度に
/wiki-ingest ~/notes/meeting1.md ~/notes/meeting2.md

# フォルダ内のすべての PDF
/wiki-ingest ~/papers/*.pdf

# URL
/wiki-ingest https://example.com/interesting-article

# またはコマンドの後にテキストを直接貼り付け
```

フォルダや複数ファイルの場合、プラグインは各ファイルの処理進捗を表示します。

---

## 🧪 例：ドキュメントからナレッジへ

気候変動に関する記事を追加するとします：

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

プラグインが作成するもの：

| 項目 | 説明 |
|------|------------|
| **要約** | 記事の1ページ概要 |
| **コンセプト** | 「炭素バジェット」や「ティッピングポイント」などのキーアイデアのページ |
| **トピックページ** | すべてをまとめる「気候科学」ページ |

エネルギー政策に関する2つ目の記事を追加すると、プラグインは両方のソースが炭素バジェットについて言及していることを検知し、自動的にリンクします。

質問すると：
```
/wiki How do carbon budgets affect energy policy?
```

**両方**のソースから情報を引き出した回答が得られ、各事実の正確な出典リンクが含まれます。

---

## 🔮 Obsidian で wiki を閲覧

セットアップ中に [Obsidian](https://obsidian.md) をインストールするか聞かれます — wiki をビジュアルに閲覧できる無料アプリです。同意すると自動でインストールされます。

Obsidian で `knowledge-base/` フォルダを開くと：

- **グラフビュー** — すべてのページとその接続関係のビジュアルマップ
- **バックリンク** — 任意のページをクリックして、リンクしているものをすべて確認
- **検索** — wiki 全体から何でも検索
- **リアルタイム同期** — `/wiki-ingest` で追加した新しいページが Obsidian にすぐ表示

オプションです。コマンドだけでも wiki は問題なく機能します。

---

## 📁 作成される構造

```
knowledge-base/
  raw/           元のドキュメント（変更されることはありません）
  summaries/     各ソースの1ページ要約
  concepts/      キーアイデア（1つにつき1ページ）
  topics/        関連アイデアをまとめた上位トピックページ
  insights/      ソース間で発見されたつながり
  index/         目次（自動生成）
  references/    外部リソースへのリンク
  log.md         すべての操作の記録
```

すべてのファイルはプレーン Markdown 形式です。任意のテキストエディタ、Obsidian、または VS Code で開けます。

---

## 💡 ヒント

- **小さく始めましょう。** 2〜3個のソースを追加し、`/wiki` を試してから追加してください。
- **具体的に質問しましょう。** 「ソース X は Y について何と言っていますか？」の方が曖昧な質問より効果的です。
- **複数のソースを追加した後に `/wiki-insights` を試しましょう** — 見落としがちなパターンを発見してくれます。
- **原本は安全です。** プラグインは元のファイルを決して変更しません。

---

## ⚙️ セットアップの仕組み

`/wiki-setup` はプロジェクトの規模に応じてすべてを自動的に処理します：

| 規模 | 検索方法 | インストール内容 |
|------|--------|-------------------|
| **小** | 内蔵検索 | 追加インストール不要 |
| **中** | スマート検索（[qmd](https://github.com/tobi/qmd)） | Node.js + qmd（自動インストール） |
| **大** | 最速検索 | Node.js + qmd + MCP サーバー（自動インストール・設定） |

お使いの OS（macOS、Linux、Windows）を検出し、適切な方法ですべてをインストールします。失敗した場合は内蔵検索に自動フォールバック — 行き詰まることはありません。

---

## 📦 その他のインストール方法

### Claude Code マーケットプレイスから（最も簡単）

```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
その後 `/plugin` → **wiki-knowledge-compiler** マーケットプレイスを選択 → プラグインを選択 → **scope を有効化**。このステップでプラグインに実行権限を付与します — 有効化後に `/wiki-` コマンドが表示されます。

### スタンドアロンプロジェクトとしてクローン

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

Claude Code で開いて `/wiki-setup` を実行してください。

### 既存のプロジェクトに追加

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git /tmp/wkc
cp -r /tmp/wkc/.claude/ your-project/.claude/
cp -r /tmp/wkc/.claude-plugin/ your-project/.claude-plugin/
cp -r /tmp/wkc/{agents,skills,templates} your-project/
cp /tmp/wkc/CLAUDE.md your-project/CLAUDE.md
cp /tmp/wkc/.data/wiki.config.md your-project/.data/wiki.config.md
bash /tmp/wkc/scripts/init-kb.sh your-project/knowledge-base
rm -rf /tmp/wkc
```

その後 `/wiki-setup` を実行してください。

---

## 📌 知っておくと便利なこと

- **オフラインで動作。** すべてがコンピュータ上にあります。
- **プレーンテキスト。** データベースや特別なソフトウェアは不要です。
- **PDF 対応。** 複雑なレイアウト（表、マルチカラム）は完全に抽出できない場合があります。
- **個人利用向け。** シングルユーザーです。
- **バージョン履歴が欲しい？** `git init` を実行してください。

---

## 🤝 コントリビュート

プラグインを改善したいですか？ [コントリビュートガイド](.github/CONTRIBUTING.md)を参照するか、Issue を作成してください。

## 📄 ライセンス

MIT

---
