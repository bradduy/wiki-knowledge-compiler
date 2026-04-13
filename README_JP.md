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

## 目次

- [最新アップデート](#-最新アップデート)
- [機能一覧](#-機能一覧)
- [多言語対応](#-多言語対応)
- [クイックスタート](#-クイックスタート)
- [使い方](#-使い方)
  - [ドキュメントの追加](#-ドキュメントの追加)
  - [例：ドキュメントからナレッジへ](#-例ドキュメントからナレッジへ)
- [ナレッジグラフ](#-ナレッジグラフ)
- [信頼度とスマートトラッキング](#-信頼度とスマートトラッキング)
- [Obsidian で wiki を閲覧](#-obsidian-で-wiki-を閲覧)
- [セットアップの仕組み](#%EF%B8%8F-セットアップの仕組み)
- [その他のインストール方法](#-その他のインストール方法)
- [コントリビュート](#-コントリビュート)
- [ライセンス](#-ライセンス)

---

## 🆕 最新アップデート

### v0.4.0 — リテンション減衰、結晶化、品質スコアリング
- 📉 **リテンション減衰** — ページがアクセスまたは強化されない限り、信頼度は時間とともに減衰します。各ページタイプには独自の半減期があります（コンセプト：180日、インサイト：60日、ドラフト：30日）。`/wiki` でページを読むとタイマーがリセットされます。
- 💎 **結晶化** — `/wiki` が3つ以上のソースを統合すると、質問、回答、ソース、主要な接続、教訓をキャプチャした**ダイジェストページ**を自動生成します — リサーチを永久的な wiki ページに変換します。
- 📊 **品質スコアリング** — すべてのページが5つの次元（フロントマター、引用、鮮度、関係、コンテンツ）で0–100のスコアで評価されます。グレードA–F。60未満のページは `/wiki-update` と `/wiki-audit` でフラグ付けされます。

### v0.3.0 — Wiki 監査、プライバシーフィルター、矛盾解決
- 🔍 **`/wiki-audit`** — wiki の健全性をチェックする新コマンド：リンク切れ、孤立ページ、古いコンテンツ、フロントマターの欠落、引用の不一致、矛盾、エンティティグラフの問題。修正可能なものは自動修正し、残りを品質スコアサマリーとともに報告します。
- 🔒 **プライバシーフィルター** — インジェスト時に派生コンテンツからAPIキー、トークン、パスワード、個人情報を自動除去。元のソースは変更されません。ページに `visibility: public/private/internal` のタグが付きます。
- ⚖️ **矛盾解決** — ソースが一致しない場合、両方が新しさ、権威性、証拠数でスコア付けされます。強い主張が弱い主張に取って代わり、僅差の場合は人間のレビュー用にフラグ付けされます。

### v0.2.0 — ナレッジグラフ、信頼度スコアリング、型付き関係
- 🧠 **ナレッジグラフ** — インジェストごとに名前付きエンティティ（人物、プロジェクト、テクノロジー、意思決定）を抽出し、`.data/entities/` で型付き関係で接続します。
- 🔗 **型付き関係** — コンセプト同士が意味を持ってリンク：`extends`、`contradicts`、`supersedes`、`depends-on`、`generalizes`、`component-of`。
- 📊 **信頼度スコアリング** — 各ページに `confidence` レベル（`high`/`medium`/`low`）、`verified` 日付が付与され、サマリーはソースの `authority`（`primary`/`secondary`/`commentary`）を追跡。
- 🔄 **置換** — 新しい情報が古い情報を置き換える際、ページは `supersedes`/`superseded_by` でリンク — 削除されず、履歴を追跡可能。
- 🕸️ **グラフ対応クエリ** — `/wiki` がキーワード/セマンティック検索と並行してエンティティ関係を辿り、テキスト検索では見つからない接続を発見。
- ⚡ **矛盾検出** — ソースが一致しない場合、両方が自動的にフラグ付けされリンクされます。

> **v0.0.x からのアップグレード？** `/wiki-setup` を再実行して新しい `.data/entities/` ディレクトリを初期化してください。既存の wiki ページはそのまま動作します — 新しいフィールド（`confidence`、`verified`、`entities`、型付き `related`）は、新しいドキュメントのインジェストや `/wiki-update` の実行時に段階的に追加されます。マイグレーション不要です。

### v0.0.x — 基盤
- 📅 **スケジュール更新** — `/wiki-schedule` がリモートエージェント経由で cron スケジュールに基づき `/wiki-update` を自動実行。
- 🔀 **混合インジェスト** — `/wiki-ingest` が1つのコマンドでファイル + URL を受け付け。
- 🔄 **更新時の自動インジェスト** — `/wiki-update` が `raw/` の新規ファイルを検出してインジェスト。
- 📝 **シンプルなコマンド** — `/wiki-query` を `/wiki` にリネーム。
- 📁 **フラット構造** — `knowledge-base/` ラッパーを削除；`raw/` と `wiki/` がプロジェクトルートに配置。
- 📥 **バッチインジェスト** — フォルダ、複数ファイル、glob パターン対応。
- 🔍 **検索ティア** — 小規模は Grep、中規模/大規模は qmd。
- 🔮 **Obsidian 統合** — `/wiki-setup` 時に自動インストールとセットアップ。
- ⚙️ **クロスプラットフォーム自動インストール** — Node.js、qmd、Obsidian を macOS、Linux、Windows で対応。

---

## ✨ 機能一覧

| 機能 | 説明 |
|------|------|
| **ナレッジグラフ** | 人物、プロジェクト、テクノロジー、意思決定を接続されたエンティティとして抽出 |
| **型付き関係** | コンセプトとエンティティがセマンティックな意味でリンク（`extends`、`contradicts`、`depends-on`） |
| **信頼度トラッキング** | 各ページを `high`/`medium`/`low` で評価、検証日付付き |
| **リテンション減衰** | 強化されない限り信頼度は時間とともに減衰 — ページタイプごとに独自の半減期 |
| **品質スコアリング** | すべてのページが5次元で0–100のスコア、グレードA–F |
| **結晶化** | 複数ソースの回答が再利用可能なダイジェストページに自動蒸留 |
| **Wiki 監査** | `/wiki-audit` がリンク切れ、古いコンテンツ、矛盾を検出し自動修正 |
| **プライバシーフィルター** | APIキー、トークン、パスワード、個人情報を派生コンテンツから自動除去 |
| **矛盾解決** | 矛盾する主張が新しさ/権威性/証拠でスコア付けされ、解決またはフラグ付け |
| **置換** | 古い主張を新しい内容にリンク、無断削除なし |
| **グラフ対応クエリ** | `/wiki` がエンティティ関係を辿り、キーワードだけでなく探索 |
| **マルチフォーマットインジェスト** | ファイル、フォルダ、URL、glob パターン、貼り付けテキスト |
| **自動要約** | ソースごとに1ページの要約とキーポイント |
| **コンセプト抽出** | ソースごとに3-10の原子的コンセプト、自動重複排除 |
| **スマート検索** | Grep（小規模）、qmd ハイブリッド検索（中規模）、qmd MCP（大規模） |
| **スケジュール更新** | リモートエージェント経由の cron ベース自動インジェスト |
| **Obsidian 統合** | ビジュアルグラフブラウジング、バックリンク、ライブ同期 |
| **100% オフライン** | プレーン Markdown ファイル、クラウドなし、データベースなし |
| **クロスプラットフォーム** | macOS、Linux、Windows で自動インストール |

---

## 🌐 多言語対応

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

---

## 🚀 クイックスタート

3ステップ。すべて自動でインストールされます — 手動での設定は不要です。

**ステップ 1 — プラグインをインストール：**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
追加後、マーケットプレイスで設定します：
1. `/plugin` を実行 → **Marketplace** タブを選択
2. **wiki-knowledge-compiler** を見つけて開く
3. **Enable** をクリックし、scope を選択 — wiki を配置したいプロジェクトフォルダを選びます
4. 確認 — これにより、プラグインがそのフォルダでファイル作成やコマンド実行を行う権限が付与されます

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Scope 設定" width="100%" />
</p>

**ステップ 2 — セットアップを実行：**
```
/wiki-setup
```
プロジェクトの規模を選択します（小・中・大）。プラグインが残りをすべて処理します — 必要なツールのインストール、wiki フォルダの作成、さらに [Obsidian](https://obsidian.md) のセットアップも提案します。

<p align="center">
  <img src="./assets/obisidian.gif" alt="Obsidian で wiki を閲覧" width="100%" />
</p>

**ステップ 3 — 最初のドキュメントを追加：**
```
/wiki-ingest ~/Documents/my-article.md
```

完了。wiki が稼働しました。

---

## 🎯 使い方

各コマンドは次に試すべきことを教えてくれるので、常に次のステップがわかります。

| コマンド | 機能 |
|---------|-------------|
| `/wiki-setup` | ⚙️ 初回セットアップ（すべて自動インストール） |
| `/wiki-ingest` | 📥 ドキュメントを追加 — ファイル1つ、フォルダ丸ごと、または URL |
| `/wiki` | 🔍 質問してソース付きの回答を取得 |
| `/wiki-insights` | ✨ ソース間のパターンとつながりを発見 |
| `/wiki-update` | 🔄 wiki を同期（raw/ の新規ファイルをインジェスト + インデックス更新） |
| `/wiki-schedule` | 📅 /wiki-update を自動実行するスケジュール設定 |
| `/wiki-audit` | 🩺 wiki の健全性チェック — リンク切れの修正、矛盾の検出、品質スコアリング |

**推奨順序：** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update` → `/wiki-audit` → `/wiki-schedule`

### 📥 ドキュメントの追加

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

### 🧪 例：ドキュメントからナレッジへ

気候変動に関する記事を追加するとします：

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

プラグインが作成するもの：

| 項目 | 説明 |
|------|------------|
| **要約** | 記事の1ページ概要（信頼度評価付き） |
| **コンセプト** | 「炭素バジェット」や「ティッピングポイント」などのキーアイデアのページ |
| **エンティティ** | 具体的なもののノード — "IPCC"、"パリ協定"、"Smith博士" |
| **トピックページ** | すべてをまとめる「気候科学」ページ |

エネルギー政策の記事を追加すると、プラグインは両方のソースが炭素バジェットについて言及していることを検知し自動リンクします — コンセプトには型付き関係（`extends`、`contradicts`、`depends-on`）が設定され、エンティティはソース間で接続されます。

質問すると：
```
/wiki How do carbon budgets affect energy policy?
```

プラグインはキーワード検索だけではありません。**ナレッジグラフ**を辿ります — 「炭素バジェット」コンセプトから始まり、関連エンティティやトピックへの関係を辿って、キーワード検索では見つからない接続を発見します。**両方**のソースから情報を引き出し、各事実の出典へのリンク付きで回答します。

---

## 🧠 ナレッジグラフ

追加するすべてのドキュメントはページを作成するだけでなく、**ナレッジグラフ**を構築します。プラグインは名前付きエンティティ（人物、プロジェクト、テクノロジー、意思決定）を抽出し、型付き関係で接続します。

```
Redis ──uses──→ Auth Service ──maintained-by──→ Brad
  │                                              │
  └──depends-on──→ PostgreSQL           owns ←───┘
                        │                Auth Migration
                        └──replaces──→ MySQL
```

「Redisのアップグレードの影響は？」と質問すると、Redisノードから `uses`、`depends-on`、`maintained-by` エッジを辿り、関連するすべてのサービス、人物、意思決定を見つけます。「Redis」という名前が記載されたページだけを検索するのではありません。

**自動抽出されるもの：**

| エンティティ種別 | 例 |
|-------------|---------|
| 人物 | "Brad Duy"、"Andrej Karpathy" |
| プロジェクト | "Auth Migration"、"API Redesign" |
| テクノロジー | "Redis"、"PostgreSQL"、"Kubernetes" |
| ライブラリ | "React"、"PyTorch"、"Express" |
| 意思決定 | "PostgreSQLに切り替え"、"マイクロサービスを採用" |
| 組織 | "Platform Team"、"Anthropic" |

---

## 📊 信頼度とスマートトラッキング

すべての知識が同等に信頼できるわけではありません。wikiの各ページにはメタデータが付与されています：

- **信頼度** — ソース数に基づく `high`、`medium`、`low`
- **検証日** — コンテンツが最後に正確と確認された日付
- **権威性** — ソースが `primary`（原著研究）、`secondary`（レビュー）、`commentary`（意見）のいずれか
- **型付き関係** — コンセプト間の接続に意味がある：`extends`、`contradicts`、`supersedes`、`depends-on`

2つのソースが矛盾する場合、プラグインは**矛盾**をフラグ付けし両方をリンクします。新しい情報が古い情報を置き換える場合、古いページは**superseded**とマークされ置き換え先へのリンクが付きます。

---

## 🔮 Obsidian で wiki を閲覧

セットアップ中に [Obsidian](https://obsidian.md) をインストールするか聞かれます — wiki をビジュアルに閲覧できる無料アプリです。同意すると自動でインストールされます。

Obsidian でプロジェクトフォルダを開くと：

- 🕸️ **グラフビュー** — すべてのページとその接続関係のビジュアルマップ
- 🔙 **バックリンク** — 任意のページをクリックして、リンクしているものをすべて確認
- 🔍 **検索** — wiki 全体から何でも検索
- ⚡ **リアルタイム同期** — `/wiki-ingest` で追加した新しいページが Obsidian にすぐ表示

オプションです。コマンドだけでも wiki は問題なく機能します。

---

## 📁 作成される構造

```
your-project/
  📄 raw/           元のドキュメント（変更されることはありません）
  📚 wiki/          すべての生成ページ（要約、コンセプト、トピック、インサイト）
  .data/            内部データ（非表示）
```

ラッパーフォルダはありません。`raw/` と `wiki/` はプロジェクト直下にあります。`raw/` が既に存在する場合、セットアップは隣に `wiki/` を追加するだけです。

すべてのファイルはプレーン Markdown 形式です。任意のテキストエディタ、Obsidian、または VS Code で開けます。

---

## 💡 ヒント

- 🌱 **小さく始めましょう。** 2〜3個のソースを追加し、`/wiki` を試してから追加してください。
- 🎯 **具体的に質問しましょう。** 「ソース X は Y について何と言っていますか？」の方が曖昧な質問より効果的です。
- ✨ **複数のソースを追加した後に `/wiki-insights` を試しましょう** — 見落としがちなパターンを発見してくれます。
- 🔒 **原本は安全です。** プラグインは元のファイルを決して変更しません。

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
追加後、マーケットプレイスで設定します：
1. `/plugin` を実行 → **Marketplace** タブを選択
2. **wiki-knowledge-compiler** を見つけて開く
3. **Enable** をクリックし、scope を選択 — wiki を配置したいプロジェクトフォルダを選びます
4. 確認 — これにより、プラグインがそのフォルダでファイル作成やコマンド実行を行う権限が付与されます

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Scope 設定" width="100%" />
</p>

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

- 📡 **オフラインで動作。** すべてがコンピュータ上にあります。
- 📄 **プレーンテキスト。** データベースや特別なソフトウェアは不要です。
- 📑 **PDF 対応。** 複雑なレイアウト（表、マルチカラム）は完全に抽出できない場合があります。
- 👤 **個人利用向け。** シングルユーザーです。
- 🕐 **バージョン履歴が欲しい？** `git init` を実行してください。

---

## 🤝 コントリビュート

プラグインを改善したいですか？ [コントリビュートガイド](.github/CONTRIBUTING.md)を参照するか、Issue を作成してください。

## 📄 ライセンス

MIT
