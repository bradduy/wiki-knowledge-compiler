<p align="center">
  <img src="./assets/logo.png" alt="Wiki Knowledge Compiler Logo" width="100%" />
</p>

<h1 align="center">Wiki Knowledge Compiler</h1>

<p align="center">
  Turn your documents into a personal knowledge base — powered by AI, stored as simple files.
</p>

---

## What is this?

Wiki Knowledge Compiler is a plugin for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that helps you **collect, organize, and search your knowledge**.

Give it any document — an article, notes, a PDF — and it will:

1. **Save** the original (your sources are never changed)
2. **Summarize** the key points
3. **Extract** the important ideas into their own pages
4. **Connect** related ideas across all your sources
5. **Answer** your questions using only what's in your knowledge base

Everything is saved as plain text files on your computer. No cloud. No database. No lock-in.

---

## Quick Start

### 1. Install the plugin

Open Claude Code and run:

```
/install bradduy/wiki-knowledge-compiler
```

### 2. Set up your wiki

```
/wiki-setup
```

This creates your knowledge base folder and walks you through a few simple choices. The defaults work great for most people.

### 3. Add your first source

```
/wiki-ingest ~/Documents/my-article.md
```

That's it! The plugin reads your document and builds out your wiki automatically.

---

## Your First 5 Minutes

Here's what a typical session looks like:

**Add a source:**
```
/wiki-ingest ~/Notes/meeting-notes-april.md
```

The plugin saves your file, writes a summary, pulls out key ideas, and links everything together. You'll see a report of what was created.

**Ask a question:**
```
/wiki-query What decisions were made about the project timeline?
```

The plugin searches your wiki and gives you an answer with links back to the original sources. If the answer is useful, it saves it for next time.

**Check on your wiki:**
```
/wiki-health
```

Finds any problems — like pages that aren't linked to anything, or duplicates — and offers to fix them.

---

## All Commands

| Command | What it does |
|---------|-------------|
| `/wiki-setup` | Set up your wiki (run this first) |
| `/wiki-ingest <file>` | Add a document to your wiki |
| `/wiki-query <question>` | Ask a question about your knowledge |
| `/wiki-insights` | Discover connections across your sources |
| `/wiki-health` | Find and fix problems in your wiki |
| `/wiki-update` | Refresh the table of contents |

> **Tip:** You can give `/wiki-ingest` a file path, a URL, or just paste text directly.

---

## What Gets Created

When you add a source, the plugin creates a set of files:

```
knowledge-base/
  raw/           Your original documents (never modified)
  summaries/     One-page summaries of each source
  concepts/      Key ideas, one per page
  topics/        Bigger-picture pages grouping related ideas
  insights/      Connections discovered across sources
  index/         Table of contents (auto-generated)
  references/    Links to external resources
  log.md         A record of everything that happened
```

All files are plain Markdown — you can open, read, and edit them with any text editor.

---

## Example: From Document to Knowledge

Say you add an article about climate change:

```
/wiki-ingest ~/Articles/ipcc-summary-2023.md
```

Here's what the plugin creates:

| File | What it contains |
|------|-----------------|
| `raw/ipcc-summary-2023.md` | Your original article (untouched) |
| `summaries/ipcc-summary-2023.md` | A summary with the key takeaways |
| `concepts/carbon-budget.md` | A page explaining the "carbon budget" idea |
| `concepts/climate-tipping-points.md` | A page on tipping points |
| `topics/climate-science.md` | A topic page linking related concepts |

Later, you add a second article about energy policy. The plugin notices connections — for example, both sources discuss carbon budgets — and links them together automatically.

Now when you ask:
```
/wiki-query How do carbon budgets affect energy policy?
```

You get an answer that draws from **both** sources, with links to exactly where each fact came from.

---

## Tips for Getting the Most Out of It

- **Start small.** Add 2-3 sources and try querying before adding more.
- **Ask specific questions.** "What does source X say about Y?" works better than vague questions.
- **Run `/wiki-health` occasionally.** It keeps your wiki tidy as it grows.
- **Use `/wiki-insights`** after adding several sources on a topic — it finds patterns you might miss.
- **Your sources are safe.** The `raw/` folder is read-only. The plugin will never change your originals.

---

## Install

Three ways to install, from easiest to most flexible:

### From the Claude Code Marketplace (easiest)

```
/install bradduy/wiki-knowledge-compiler
```

Then run `/wiki-setup` to get started.

### As a standalone project

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

Open this folder in Claude Code. Everything is ready to go — just run `/wiki-setup`.

### Inside an existing project

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

Then open your project in Claude Code and run `/wiki-setup`.

---

## How It Works (The Short Version)

The plugin uses four AI agents behind the scenes:

| Agent | Job |
|-------|-----|
| **Ingestor** | Reads your documents and creates wiki pages |
| **Librarian** | Searches your wiki and answers questions |
| **Synthesizer** | Finds connections and patterns across sources |
| **Auditor** | Checks for problems and keeps things tidy |

You don't need to interact with these directly — the commands above handle everything.

---

## As Your Wiki Grows

The plugin adapts to your wiki's size:

| Wiki size | What happens | You need to do |
|-----------|-------------|----------------|
| **Under 100 pages** | Built-in search | Nothing (default) |
| **100 – 500 pages** | Smarter search with [qmd](https://github.com/tobi/qmd) | Installed automatically |
| **500+ pages** | Fastest search mode | Installed automatically |

When you choose Medium or Large during `/wiki-setup`, qmd is installed automatically. The plugin always works — larger wikis just search faster with the upgrade.

---

## Browse Your Wiki with Obsidian (Optional)

During `/wiki-setup`, you'll be asked if you want to install [Obsidian](https://obsidian.md) — a free app that lets you **see your wiki visually**.

Once installed, just open your `knowledge-base/` folder in Obsidian and you get:

- **Graph View** — an interactive map showing every page and how they connect
- **Backlinks** — click any page and see everything that links to it
- **Full-text search** — find anything across your entire wiki instantly
- **Live sync** — add documents with `/wiki-ingest`, and they appear in Obsidian right away

Obsidian is completely optional. Your wiki works perfectly fine with just the `/wiki-` commands. But if you're a visual thinker, it's the best way to explore your knowledge.

---

## Good to Know

- **Works offline.** Everything is on your computer.
- **Plain text files.** No database, no special software needed to read your wiki.
- **PDFs are supported** but complex layouts (tables, multi-column) may not extract perfectly.
- **Single user.** Designed for personal use.
- **Use git for history.** Run `git init` in your knowledge base folder if you want to track changes over time.

---

## Contributing

Want to add a command or improve the plugin? See the [contributing guide](.github/CONTRIBUTING.md) or open an issue.

## License

MIT
