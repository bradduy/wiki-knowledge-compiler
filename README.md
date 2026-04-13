<h1 align="center">Wiki Knowledge Compiler</h1>

<p align="center">
  <em>Turn your documents into a personal knowledge base — powered by AI, stored as simple files.</em>
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

<p align="center">
  🇬🇧 <strong>English</strong> &nbsp;·&nbsp;
  <a href="./README_VN.md">🇻🇳 Tiếng Việt</a> &nbsp;·&nbsp;
  <a href="./README_CN.md">🇨🇳 简体中文</a> &nbsp;·&nbsp;
  <a href="./README_KR.md">🇰🇷 한국어</a> &nbsp;·&nbsp;
  <a href="./README_JP.md">🇯🇵 日本語</a> &nbsp;·&nbsp;
  <a href="./README_DE.md">🇩🇪 Deutsch</a> &nbsp;·&nbsp;
  <a href="./README_FR.md">🇫🇷 Français</a> &nbsp;·&nbsp;
  <a href="./README_RU.md">🇷🇺 Русский</a>
</p>

---

## 📖 What is this?

A plugin for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that turns your documents into an organized, searchable knowledge base.

Give it anything — articles, notes, PDFs, a whole folder — and it will:

1. 💾 **Save** your originals (they're never changed)
2. 📝 **Summarize** each source
3. 💡 **Extract** key ideas into their own pages
4. 🔗 **Connect** related ideas across everything you've added
5. 💬 **Answer** your questions with links back to the sources

Everything stays on your computer as plain text files. No cloud. No database. No lock-in.

---

## 🚀 Quick Start

Three steps. Everything installs automatically — you don't need to set up anything yourself.

**Step 1 — Install the plugin:**
```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
After adding, configure it in the marketplace:
1. Run `/plugin` → select **Marketplace** tab
2. Find **wiki-knowledge-compiler** and open it
3. Click **Enable** and choose the scope — pick the project folder where you want your wiki to live
4. Confirm — this grants the plugin permission to create files and run commands in that folder

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Enable scope setting" width="100%" />
</p>

**Step 2 — Run setup:**
```
/wiki-setup
```
Pick your project size (small, medium, or large). The plugin handles the rest — it installs any tools you need, builds your wiki folder, and even offers to set up [Obsidian](https://obsidian.md) so you can browse your wiki visually.

<p align="center">
  <img src="./assets/obisidian.gif" alt="Obsidian visual browsing" width="100%" />
</p>

**Step 3 — Add your first document:**
```
/wiki-ingest ~/Documents/my-article.md
```

Done. Your wiki is live.

---

## 🎯 What You Can Do

Each command tells you what to try next, so you always know the next step.

| Command | What it does |
|---------|-------------|
| `/wiki-setup` | ⚙️ One-time setup (installs everything for you) |
| `/wiki-ingest` | 📥 Add documents — one file, a whole folder, or a URL |
| `/wiki` | 🔍 Ask a question, get an answer with sources |
| `/wiki-insights` | ✨ Find patterns and connections across your sources |
| `/wiki-update` | 🔄 Sync wiki (ingest new raw files + refresh indexes) |
| `/wiki-schedule` | 📅 Schedule /wiki-update to run automatically |

**Recommended order:** `/wiki-setup` → `/wiki-ingest` → `/wiki` → `/wiki-insights` → `/wiki-update` → `/wiki-schedule`

---

## 📥 Adding Documents

You can add documents in many ways:

```bash
# One file
/wiki-ingest ~/Documents/article.md

# A whole folder (scans everything inside)
/wiki-ingest ~/Documents/research/

# Multiple files at once
/wiki-ingest ~/notes/meeting1.md ~/notes/meeting2.md

# All PDFs in a folder
/wiki-ingest ~/papers/*.pdf

# A URL
/wiki-ingest https://example.com/interesting-article

# Or just paste text directly after the command
```

For folders and multiple files, the plugin shows progress as it works through each one.

---

## 🧪 Example: From Document to Knowledge

Say you add an article about climate change:

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

The plugin creates:

| What | Description |
|------|------------|
| **Summary** | A one-page overview of the article with confidence rating |
| **Concepts** | Pages for key ideas like "carbon budget" and "tipping points" |
| **Entities** | Nodes for real things — "IPCC", "Paris Agreement", "Dr. Smith" |
| **Topic page** | A "climate science" page linking everything together |

Now add a second article about energy policy. The plugin notices both sources discuss carbon budgets and links them automatically — concepts get typed relationships (`extends`, `contradicts`, `depends-on`), and entities connect across sources.

When you ask:
```
/wiki How do carbon budgets affect energy policy?
```

The plugin doesn't just search by keywords. It walks the **knowledge graph** — starting from the "carbon budget" concept, following its relationships to connected entities and topics — and finds connections that keyword search would miss. You get an answer that draws from **both** sources, with links to exactly where each fact came from.

---

## 🧠 Knowledge Graph

Every document you add doesn't just create pages — it builds a **knowledge graph**. The plugin extracts named entities (people, projects, technologies, decisions) and connects them with typed relationships.

```
Redis ──uses──→ Auth Service ──maintained-by──→ Sarah
  │                                              │
  └──depends-on──→ PostgreSQL           owns ←───┘
                        │                Auth Migration
                        └──replaces──→ MySQL
```

This means when you ask "what's the impact of upgrading Redis?", the plugin walks outward from Redis through `uses`, `depends-on`, and `maintained-by` edges — finding every connected service, person, and decision. Not just pages that mention "Redis" by name.

**What gets extracted automatically:**

| Entity type | Examples |
|-------------|---------|
| People | "Sarah Chen", "Andrej Karpathy" |
| Projects | "Auth Migration", "API Redesign" |
| Technologies | "Redis", "PostgreSQL", "Kubernetes" |
| Libraries | "React", "PyTorch", "Express" |
| Decisions | "Switch to PostgreSQL", "Use microservices" |
| Organizations | "Platform Team", "Anthropic" |

---

## 📊 Confidence & Smart Tracking

Not all knowledge is equally reliable. Every page in your wiki carries metadata that helps you trust it:

- **Confidence** — `high`, `medium`, or `low` based on how many sources support it
- **Verified date** — when the content was last confirmed accurate
- **Authority** — whether a source is `primary` (original research), `secondary` (review), or `commentary` (opinion)
- **Typed relationships** — connections between concepts aren't just links, they have meaning: `extends`, `contradicts`, `supersedes`, `depends-on`

When two sources disagree, the plugin flags the **contradiction** and links both sides — so you see the conflict instead of getting silently wrong answers.

When newer information replaces older claims, the old page is marked as **superseded** with a link to what replaced it. Nothing is deleted — you can always trace the history.

---

## 🔮 Browse Your Wiki with Obsidian

During setup, you'll be asked if you want [Obsidian](https://obsidian.md) — a free app for browsing your wiki visually. It's installed automatically if you say yes.

Open your project folder in Obsidian and you get:

- 🕸️ **Graph View** — a visual map of all your pages and how they connect
- 🔙 **Backlinks** — click any page to see everything that links to it
- 🔍 **Search** — find anything across your entire wiki
- ⚡ **Live sync** — new pages from `/wiki-ingest` appear in Obsidian right away

This is optional. Your wiki works perfectly with just the commands.

---

## 📁 What Gets Created

```
your-project/
  📄 raw/           Your original documents (never modified)
  📚 wiki/          All generated pages (summaries, concepts, topics, insights)
  .data/            Internal working data (hidden)
```

No wrapper folder. `raw/` and `wiki/` live right in your project. If `raw/` already exists, setup just adds `wiki/` next to it.

All files are plain Markdown. Open them with any text editor, Obsidian, or VS Code.

---

## 💡 Tips

- 🌱 **Start small.** Add 2–3 sources and try `/wiki` before adding more.
- 🎯 **Be specific.** "What does source X say about Y?" works better than vague questions.
- ✨ **Try `/wiki-insights`** after adding several sources on a topic — it finds patterns you might miss.
- 🔒 **Your sources are safe.** The plugin never changes your original files.

---

## ⚙️ How Setup Works

`/wiki-setup` handles everything automatically based on your project size:

| Size | Search | What gets installed |
|------|--------|-------------------|
| **Small** | Built-in | Nothing extra needed |
| **Medium** | Smart search ([qmd](https://github.com/tobi/qmd)) | Node.js + qmd (auto-installed) |
| **Large** | Fastest search | Node.js + qmd + MCP server (auto-installed and configured) |

The plugin detects your operating system (macOS, Linux, Windows) and installs everything using the right method for your machine. If anything fails, it falls back to built-in search — you're never stuck.

---

## 📦 Other Ways to Install

### From the Claude Code Marketplace (easiest)

```
/plugin marketplace add bradduy/wiki-knowledge-compiler
```
After adding, configure it in the marketplace:
1. Run `/plugin` → select **Marketplace** tab
2. Find **wiki-knowledge-compiler** and open it
3. Click **Enable** and choose the scope — pick the project folder where you want your wiki to live
4. Confirm — this grants the plugin permission to create files and run commands in that folder

<p align="center">
  <img src="./assets/user_scope_setting.png" alt="Enable scope setting" width="100%" />
</p>

### Clone as a standalone project

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

Open in Claude Code and run `/wiki-setup`.

### Add to an existing project

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

Then run `/wiki-setup`.

---

## 📌 Good to Know

- 📡 **Works offline.** Everything is on your computer.
- 📄 **Plain text files.** No database or special software needed to read your wiki.
- 📑 **PDFs supported.** Complex layouts (tables, multi-column) may not extract perfectly.
- 👤 **Designed for personal use.** Single user.
- 🕐 **Want version history?** Run `git init` in your knowledge base folder.

---

## 🤝 Contributing

Want to improve the plugin? See the [contributing guide](.github/CONTRIBUTING.md) or open an issue.

## 📄 License

MIT
