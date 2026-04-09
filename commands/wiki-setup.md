---
name: wiki-setup
description: Set up your wiki — choose your project size and get started
---

# Setup Wiki

Guide the user through initial wiki configuration. This determines the search strategy and tooling.

## Procedure

### Step 1: Ask about project size

Present this to the user:

```
Welcome to wiki-knowledge-compiler setup.

How large is (or will be) the knowledge base you're building?

1. **Small** (<100 pages)
   - Personal notes, a handful of papers, one project's worth of knowledge
   - Search: built-in index files + Grep (no extra tools needed)

2. **Medium** (100–500 pages)
   - Multiple projects, a research area, a team knowledge base
   - Search: qmd CLI recommended — hybrid BM25/vector search, all local
   - Install: https://github.com/tobi/qmd

3. **Large** (500+ pages)
   - Comprehensive knowledge base, many sources, cross-domain
   - Search: qmd MCP server recommended — native tool integration, re-ranking
   - Install: https://github.com/tobi/qmd (MCP mode)

Enter 1, 2, or 3:
```

### Step 2: Configure based on choice

**If Small (1):**
1. Set `wiki.config.md` → `size: small`, `backend: grep`
2. No additional tools needed
3. Tell the user:
   ```
   Configured for small project. Search uses built-in Grep + index files.
   This works well up to ~100 pages. Run /wiki-setup again if you outgrow it.
   ```

**If Medium (2) or Large (3) — auto-install qmd:**
1. Check if qmd is installed: `which qmd` (or `where qmd` on Windows). If found, skip to step 6.
2. Check for JS runtime: `which bun`, then `which npm`. If found, skip to step 5.
3. No JS runtime — detect OS via `uname -s` and install Node.js:
   - **macOS:** check `which brew` — if missing, install Homebrew first. Then `brew install node`.
   - **Linux:** detect package manager (`apt`/`dnf`/`yum`/`pacman`/`zypper`/`apk`) and install nodejs+npm. If none found, install via nvm.
   - **Windows:** check `where winget` — if missing, try to install it. Then `winget install OpenJS.NodeJS.LTS`. If winget unavailable, check `where choco` — if missing, install Chocolatey first. Then `choco install nodejs-lts -y`. If all fail, fall back to Grep.
4. Verify: `which npm` (or `where npm`). If still not found, fall back to Grep.
5. Install qmd: `npm install -g @tobilu/qmd` (or bun equivalent). Verify with `qmd --version`.
6. Configure: `qmd collection add knowledge-base/ --name wiki` + `qmd context add qmd://wiki "Knowledge base wiki pages"` + `qmd embed`
7. If Medium: set `wiki.config.md` → `size: medium`, `backend: qmd-cli`
8. If Large: set `wiki.config.md` → `size: large`, `backend: qmd-mcp`. Then configure MCP:
   - Resolve qmd full path: `which qmd` (macOS/Linux) or `where qmd` (Windows)
   - Locate settings: `~/.claude/settings.json` (macOS/Linux) or `%USERPROFILE%\.claude\settings.json` (Windows)
   - Create the directory if missing, read existing settings, merge `qmd` MCP server entry (using full binary path), write back without overwriting other settings

### Step 3: Initialize knowledge base structure

1. Check if `knowledge-base/` exists with expected subdirectories
2. If not, run `scripts/init-kb.sh`
3. If it exists, verify structure is intact

### Step 4: Run initial index build

1. Run `/wiki-update` to ensure indexes are current
2. If qmd backend is active, run `qmd embed` to ensure embeddings are current

### Step 5: Log the setup

Append to `knowledge-base/log.md`:

```
## [DATE] Wiki setup
- Project size: [small/medium/large]
- Search backend: [grep/qmd-cli/qmd-mcp]
- qmd installed: [yes/no/n/a]
- Knowledge base initialized: [yes/already existed]
```

### Step 6: Show next steps

```
Setup complete. Here's what to do next:

1. Add your first document:    /wiki-ingest <file, URL, or paste text>
2. Ask a question:             /wiki-query <question>
3. Find connections:           /wiki-insights
4. Check for problems:         /wiki-health
5. Refresh indexes:            /wiki-update

Tip: The wiki gets more useful with every source you add.
     Start with 2-3 sources on a topic you care about.
```
