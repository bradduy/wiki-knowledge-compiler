<h1 align="center">Wiki Knowledge Compiler</h1>

<p align="center">
  <em>将你的文档转化为个人知识库 — 由 AI 驱动，以简单文件存储。</em>
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

## 目录

- [最新更新](#-最新更新)
- [功能特性](#-功能特性)
- [多语言版本](#-多语言版本)
- [快速开始](#-快速开始)
- [使用方法](#-使用方法)
  - [添加文档](#-添加文档)
  - [示例：从文档到知识](#-示例从文档到知识)
- [知识图谱](#-知识图谱)
- [可信度与智能追踪](#-可信度与智能追踪)
- [用 Obsidian 浏览你的知识库](#-用-obsidian-浏览你的知识库)
- [设置工作原理](#%EF%B8%8F-设置工作原理)
- [其他安装方式](#-其他安装方式)
- [参与贡献](#-参与贡献)
- [许可证](#-许可证)

---

## 🆕 最新更新

### v2.0.0 — 知识图谱、可信度评分和类型化关系
- 🧠 **知识图谱** — 每次导入都会提取命名实体（人物、项目、技术、决策），并在 `.data/entities/` 中用类型化关系连接它们。
- 🔗 **类型化关系** — 概念之间的链接具有语义含义：`extends`、`contradicts`、`supersedes`、`depends-on`、`generalizes`、`component-of`。
- 📊 **可信度评分** — 每个页面都带有 `confidence` 等级（`high`/`medium`/`low`）、`verified` 日期，摘要追踪来源 `authority`（`primary`/`secondary`/`commentary`）。
- 🔄 **替代机制** — 当新信息替代旧信息时，页面通过 `supersedes`/`superseded_by` 链接——不删除任何内容，历史可追溯。
- 🕸️ **图谱感知查询** — `/wiki` 现在在关键词/语义搜索的同时遍历实体关系，发现文本搜索无法找到的联系。
- ⚡ **矛盾检测** — 当来源不一致时，双方被自动标记和链接。

### v1.x — 基础版本
- 📅 **计划更新** — `/wiki-schedule` 通过远程代理按 cron 计划自动运行 `/wiki-update`。
- 🔀 **混合导入** — `/wiki-ingest` 在单个命令中同时接受文件和 URL。
- 🔄 **更新时自动导入** — `/wiki-update` 检测并导入 `raw/` 中的新文件。
- 📝 **更简单的命令** — `/wiki-query` 重命名为 `/wiki`。
- 📁 **扁平结构** — 移除 `knowledge-base/` 包装文件夹；`raw/` 和 `wiki/` 直接位于项目根目录。
- 📥 **批量导入** — 支持文件夹、多文件和 glob 模式。
- 🔍 **搜索层级** — 小型项目用 Grep，中型/大型用 qmd。
- 🔮 **Obsidian 集成** — 在 `/wiki-setup` 期间自动安装和配置。
- ⚙️ **跨平台自动安装** — Node.js、qmd、Obsidian 支持 macOS、Linux 和 Windows。

---

## ✨ 功能特性

| 功能 | 说明 |
|------|------|
| **知识图谱** | 提取人物、项目、技术、决策为连接的实体 |
| **类型化关系** | 概念和实体通过语义含义链接（`extends`、`contradicts`、`depends-on`） |
| **可信度追踪** | 每个页面评级为 `high`/`medium`/`low`，附带验证日期 |
| **来源权威性** | 摘要标记为 `primary`、`secondary` 或 `commentary` |
| **矛盾检测** | 冲突的声明被自动标记和链接 |
| **替代机制** | 旧声明链接到替代内容，不会被悄悄删除 |
| **图谱感知查询** | `/wiki` 遍历实体关系，不只是关键词 |
| **多格式导入** | 文件、文件夹、URL、glob 模式、粘贴文本 |
| **自动摘要** | 每个来源一页摘要，包含关键要点 |
| **概念提取** | 每个来源 3-10 个原子概念，自动去重 |
| **智能搜索** | Grep（小型）、qmd 混合搜索（中型）、qmd MCP（大型） |
| **计划更新** | 通过远程代理的 cron 定时自动导入 |
| **Obsidian 集成** | 可视化图谱浏览、反向链接、实时同步 |
| **100% 离线** | 纯 Markdown 文件，无云端，无数据库 |
| **跨平台** | macOS、Linux、Windows，自动安装 |

---

## 🌐 多语言版本

<p align="center">
  <a href="./README.md">🇬🇧 English</a> &nbsp;·&nbsp;
  <a href="./README_VN.md">🇻🇳 Tiếng Việt</a> &nbsp;·&nbsp;
  🇨🇳 <strong>简体中文</strong> &nbsp;·&nbsp;
  <a href="./README_KR.md">🇰🇷 한국어</a> &nbsp;·&nbsp;
  <a href="./README_JP.md">🇯🇵 日本語</a> &nbsp;·&nbsp;
  <a href="./README_DE.md">🇩🇪 Deutsch</a> &nbsp;·&nbsp;
  <a href="./README_FR.md">🇫🇷 Français</a> &nbsp;·&nbsp;
  <a href="./README_RU.md">🇷🇺 Русский</a>
</p>

---

## 🚀 快速开始

三个步骤。一切自动安装——你无需手动配置任何东西。

**第 1 步——安装插件：**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
添加后，在市场中进行配置：
1. 运行 `/plugin` → 选择 **Marketplace** 标签页
2. 找到 **wiki-knowledge-compiler** 并打开
3. 点击 **Enable** 并选择 scope —— 选择你想放置 wiki 的项目文件夹
4. 确认 —— 此步骤授权插件在该文件夹中创建文件和运行命令

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Scope 设置" width="100%" />
</p>

**第 2 步——运行设置：**
```
/wiki-setup
```
选择你的项目规模（小型、中型或大型）。插件会处理剩下的一切——安装所需工具、创建 wiki 文件夹，还可以帮你配置 [Obsidian](https://obsidian.md)，让你以可视化方式浏览知识库。

<p align="center">
  <img src="./assets/obisidian.gif" alt="使用 Obsidian 浏览 wiki" width="100%" />
</p>

**第 3 步——添加你的第一个文档：**
```
/wiki-ingest ~/Documents/my-article.md
```

完成。你的知识库已上线。

---

## 🎯 使用方法

每个命令都会提示你下一步该做什么，你始终知道接下来的操作。

| 命令 | 功能 |
|---------|-------------|
| `/wiki-setup` | ⚙️ 一次性设置（自动安装所有依赖） |
| `/wiki-ingest` | 📥 添加文档——单个文件、整个文件夹或 URL |
| `/wiki` | 🔍 提问并获得附带来源的回答 |
| `/wiki-insights` | ✨ 发现来源之间的模式和关联 |
| `/wiki-update` | 🔄 同步 wiki（导入 raw/ 中的新文件 + 刷新索引） |
| `/wiki-schedule` | 📅 计划自动运行 /wiki-update |

**推荐顺序：** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update` → `/wiki-schedule`

### 📥 添加文档

你可以通过多种方式添加文档：

```bash
# 单个文件
/wiki-ingest ~/Documents/article.md

# 整个文件夹（扫描其中所有内容）
/wiki-ingest ~/Documents/research/

# 同时添加多个文件
/wiki-ingest ~/notes/meeting1.md ~/notes/meeting2.md

# 文件夹中的所有 PDF
/wiki-ingest ~/papers/*.pdf

# 一个 URL
/wiki-ingest https://example.com/interesting-article

# 或者直接在命令后粘贴文本
```

对于文件夹和多个文件，插件会显示逐个处理的进度。

### 🧪 示例：从文档到知识

假设你添加了一篇关于气候变化的文章：

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

插件会创建：

| 内容 | 说明 |
|------|------------|
| **摘要** | 文章的单页概览，附带可信度评级 |
| **概念** | 关键概念的独立页面，如"碳预算"和"临界点" |
| **实体** | 具体事物的节点——"IPCC"、"巴黎协定"、"Smith 博士" |
| **主题页** | 一个"气候科学"页面，将所有内容串联起来 |

添加第二篇关于能源政策的文章。插件会发现两个来源都讨论了碳预算，并自动建立关联——概念之间有类型化关系（`extends`、`contradicts`、`depends-on`），实体跨来源连接。

当你提问：
```
/wiki How do carbon budgets affect energy policy?
```

插件不只是按关键词搜索。它遍历**知识图谱**——从"碳预算"概念出发，沿着关系找到相关实体和主题——发现关键词搜索无法找到的联系。你获得一个融合**两个**来源的答案，并附有每条事实出处的链接。

---

## 🧠 知识图谱

你添加的每份文档不仅创建页面——还构建**知识图谱**。插件提取命名实体（人物、项目、技术、决策）并用类型化关系连接它们。

```
Redis ──uses──→ Auth Service ──maintained-by──→ Sarah
  │                                              │
  └──depends-on──→ PostgreSQL           owns ←───┘
                        │                Auth Migration
                        └──replaces──→ MySQL
```

当你问"升级 Redis 有什么影响？"时，插件从 Redis 节点出发，沿 `uses`、`depends-on`、`maintained-by` 边向外走——找到每个相关的服务、人员和决策。不只是搜索提到"Redis"的页面。

**自动提取的内容：**

| 实体类型 | 示例 |
|-------------|---------|
| 人物 | "Sarah Chen"、"Andrej Karpathy" |
| 项目 | "Auth Migration"、"API Redesign" |
| 技术 | "Redis"、"PostgreSQL"、"Kubernetes" |
| 库 | "React"、"PyTorch"、"Express" |
| 决策 | "切换到 PostgreSQL"、"使用微服务" |
| 组织 | "Platform Team"、"Anthropic" |

---

## 📊 可信度与智能追踪

不是所有知识都同等可靠。wiki 中的每个页面都携带元数据帮你判断：

- **可信度** — `high`、`medium` 或 `low`，基于支持来源数量
- **验证日期** — 内容最后一次被确认准确的时间
- **权威性** — 来源是 `primary`（原始研究）、`secondary`（综述）还是 `commentary`（评论）
- **类型化关系** — 概念之间的连接有含义：`extends`、`contradicts`、`supersedes`、`depends-on`

当两个来源冲突时，插件标记**矛盾**并链接双方。当新信息替代旧信息时，旧页面被标记为 **superseded** 并链接到替代内容。

---

## 🔮 用 Obsidian 浏览你的知识库

在设置过程中，你会被问到是否需要 [Obsidian](https://obsidian.md)——一个免费的知识库可视化浏览工具。如果你选择安装，它会自动完成。

在 Obsidian 中打开你的项目文件夹，你会获得：

- 🕸️ **图谱视图** — 所有页面及其关联的可视化地图
- 🔙 **反向链接** — 点击任意页面查看所有链接到它的内容
- 🔍 **搜索** — 在整个知识库中查找任何内容
- ⚡ **实时同步** — 通过 `/wiki-ingest` 新增的页面会立即出现在 Obsidian 中

这是可选的。仅使用命令行，你的知识库也能完美运行。

---

## 📁 创建的内容结构

```
your-project/
  📄 raw/           你的原始文档（从不修改）
  📚 wiki/          所有生成的页面（摘要、概念、主题、洞察）
  .data/            内部工作数据（隐藏）
```

没有包装文件夹。`raw/` 和 `wiki/` 直接在你的项目中。如果 `raw/` 已经存在，设置只会在旁边添加 `wiki/`。

所有文件均为纯 Markdown 格式。可以用任意文本编辑器、Obsidian 或 VS Code 打开。

---

## 💡 使用建议

- 🌱 **从小处开始。** 先添加 2–3 个来源，试试 `/wiki`，然后再添加更多。
- 🎯 **提问要具体。** "来源 X 关于 Y 说了什么？"比模糊的问题效果更好。
- ✨ **添加多个同主题来源后试试 `/wiki-insights`** ——它能发现你可能忽略的模式。
- 🔒 **你的原始文件是安全的。** 插件绝不会修改你的原始文件。

---

## ⚙️ 设置工作原理

`/wiki-setup` 会根据你的项目规模自动处理所有配置：

| 规模 | 搜索方式 | 安装内容 |
|------|--------|-------------------|
| **小型** | 内置搜索 | 无需额外安装 |
| **中型** | 智能搜索（[qmd](https://github.com/tobi/qmd)） | Node.js + qmd（自动安装） |
| **大型** | 最快搜索 | Node.js + qmd + MCP 服务器（自动安装和配置） |

插件会检测你的操作系统（macOS、Linux、Windows），并使用适合你机器的方式安装所有依赖。如果安装失败，会自动回退到内置搜索——你永远不会卡住。

---

## 📦 其他安装方式

### 从 Claude Code 市场安装（最简单）

```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
添加后，在市场中进行配置：
1. 运行 `/plugin` → 选择 **Marketplace** 标签页
2. 找到 **wiki-knowledge-compiler** 并打开
3. 点击 **Enable** 并选择 scope —— 选择你想放置 wiki 的项目文件夹
4. 确认 —— 此步骤授权插件在该文件夹中创建文件和运行命令

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Scope 设置" width="100%" />
</p>

### 克隆为独立项目

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

在 Claude Code 中打开并运行 `/wiki-setup`。

### 添加到现有项目

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

然后运行 `/wiki-setup`。

---

## 📌 其他须知

- 📡 **支持离线使用。** 所有内容都在你的电脑上。
- 📄 **纯文本文件。** 无需数据库或特殊软件即可阅读你的知识库。
- 📑 **支持 PDF。** 复杂排版（表格、多栏）可能无法完美提取。
- 👤 **为个人使用设计。** 单用户。
- 🕐 **想要版本历史？** 在知识库文件夹中运行 `git init`。

---

## 🤝 参与贡献

想改进这个插件？请参阅[贡献指南](.github/CONTRIBUTING.md)或提交 issue。

## 📄 许可证

MIT
