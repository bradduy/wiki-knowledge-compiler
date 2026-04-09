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

# 🇨🇳 简体中文

## 📖 这是什么？

一个 [Claude Code](https://docs.anthropic.com/en/docs/claude-code) 插件，能将你的文档转化为有组织、可搜索的知识库。

你可以输入任何内容——文章、笔记、PDF、整个文件夹——它会：

1. **保存**你的原始文件（绝不修改）
2. **总结**每个来源
3. **提取**关键概念，生成独立页面
4. **关联**你所添加的所有内容中的相关概念
5. **回答**你的问题，并附上来源链接

所有内容以纯文本文件保存在你的电脑上。无需云端，无需数据库，不会被锁定。

---

## 🚀 快速开始

三个步骤。一切自动安装——你无需手动配置任何东西。

**第 1 步——安装插件：**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
然后进入 `/plugin` → 选择 **wiki-knowledge-compiler** 市场 → 选择该插件 → **启用 scope**。此步骤授权插件在你的机器上运行——启用后 `/wiki-` 命令将会出现。

**第 2 步——运行设置：**
```
/wiki-setup
```
选择你的项目规模（小型、中型或大型）。插件会处理剩下的一切——安装所需工具、创建 wiki 文件夹，还可以帮你配置 [Obsidian](https://obsidian.md)，让你以可视化方式浏览知识库。

**第 3 步——添加你的第一个文档：**
```
/wiki-ingest ~/Documents/my-article.md
```

完成。你的知识库已上线。

---

## 🎯 你可以做什么

每个命令都会提示你下一步该做什么，你始终知道接下来的操作。

| 命令 | 功能 |
|---------|-------------|
| `/wiki-setup` | 一次性设置（自动安装所有依赖） |
| `/wiki-ingest` | 添加文档——单个文件、整个文件夹或 URL |
| `/wiki-query` | 提问并获得附带来源的回答 |
| `/wiki-insights` | 发现来源之间的模式和关联 |
| `/wiki-health` | 查找并修复问题（重复项、失效链接） |
| `/wiki-update` | 刷新目录 |

**推荐顺序：** `/wiki-setup` → `/wiki-ingest` → `/wiki-query` → `/wiki-insights` → `/wiki-health` → `/wiki-update`

---

## 📥 添加文档

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

---

## 🧪 示例：从文档到知识

假设你添加了一篇关于气候变化的文章：

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

插件会创建：

| 内容 | 说明 |
|------|------------|
| **摘要** | 文章的单页概览 |
| **概念** | 关键概念的独立页面，如"碳预算"和"临界点" |
| **主题页** | 一个"气候科学"页面，将所有内容串联起来 |

现在添加第二篇关于能源政策的文章。插件会发现两个来源都讨论了碳预算，并自动建立关联。

当你提问：
```
/wiki-query How do carbon budgets affect energy policy?
```

你会得到一个综合**两个**来源的回答，并附有每个事实的精确出处链接。

---

## 🔮 用 Obsidian 浏览你的知识库

在设置过程中，你会被问到是否需要 [Obsidian](https://obsidian.md)——一个免费的知识库可视化浏览工具。如果你选择安装，它会自动完成。

在 Obsidian 中打开你的 `knowledge-base/` 文件夹，你会获得：

- **图谱视图** — 所有页面及其关联的可视化地图
- **反向链接** — 点击任意页面查看所有链接到它的内容
- **搜索** — 在整个知识库中查找任何内容
- **实时同步** — 通过 `/wiki-ingest` 新增的页面会立即出现在 Obsidian 中

这是可选的。仅使用命令行，你的知识库也能完美运行。

---

## 📁 创建的内容结构

```
knowledge-base/
  raw/           你的原始文档（从不修改）
  summaries/     每个来源的单页摘要
  concepts/      关键概念，每个概念一页
  topics/        更宏观的主题页，归类相关概念
  insights/      跨来源发现的关联
  index/         目录（自动生成）
  references/    外部资源链接
  log.md         所有操作的记录
```

所有文件均为纯 Markdown 格式。可以用任意文本编辑器、Obsidian 或 VS Code 打开。

---

## 💡 使用建议

- **从小处开始。** 先添加 2–3 个来源，试试 `/wiki-query`，然后再添加更多。
- **提问要具体。** "来源 X 关于 Y 说了什么？"比模糊的问题效果更好。
- **定期运行 `/wiki-health`。** 随着知识库增长，它能帮你保持整洁。
- **添加多个同主题来源后试试 `/wiki-insights`** ——它能发现你可能忽略的模式。
- **你的原始文件是安全的。** 插件绝不会修改你的原始文件。

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
然后进入 `/plugin` → 选择 **wiki-knowledge-compiler** 市场 → 选择该插件 → **启用 scope**。此步骤授权插件在你的机器上运行——启用后 `/wiki-` 命令将会出现。

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
cp /tmp/wkc/wiki.config.md your-project/wiki.config.md
bash /tmp/wkc/scripts/init-kb.sh your-project/knowledge-base
rm -rf /tmp/wkc
```

然后运行 `/wiki-setup`。

---

## 📌 其他须知

- **支持离线使用。** 所有内容都在你的电脑上。
- **纯文本文件。** 无需数据库或特殊软件即可阅读你的知识库。
- **支持 PDF。** 复杂排版（表格、多栏）可能无法完美提取。
- **为个人使用设计。** 单用户。
- **想要版本历史？** 在知识库文件夹中运行 `git init`。

---

## 🤝 参与贡献

想改进这个插件？请参阅[贡献指南](.github/CONTRIBUTING.md)或提交 issue。

## 📄 许可证

MIT

---
