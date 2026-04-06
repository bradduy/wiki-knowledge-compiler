---
name: setup-wiki
description: Interactive setup — configures the wiki based on your project size, installs search backend if needed
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
   This works well up to ~100 pages. Run /setup-wiki again if you outgrow it.
   ```

**If Medium (2):**
1. Set `wiki.config.md` → `size: medium`, `backend: qmd-cli`
2. Check if qmd is installed: run `which qmd` or `qmd --version`
3. If installed:
   ```
   qmd detected. Configured for medium project with qmd CLI search.
   Building initial search index...
   ```
   Run: `qmd index knowledge-base/`
4. If not installed:
   ```
   qmd is not installed yet. To install:
     brew install tobi/tap/qmd    # macOS
     # or build from source: https://github.com/tobi/qmd

   For now, falling back to Grep search. Run /setup-wiki again after installing qmd.
   ```
   Set `backend: grep` as fallback, keep `size: medium`

**If Large (3):**
1. Set `wiki.config.md` → `size: large`, `backend: qmd-mcp`
2. Check if qmd is installed
3. If installed:
   ```
   qmd detected. Configured for large project with qmd MCP server.

   To enable MCP integration, add to your Claude Code MCP config:
   {
     "mcpServers": {
       "qmd": {
         "command": "qmd",
         "args": ["mcp", "--root", "knowledge-base/"]
       }
     }
   }
   ```
4. If not installed: same fallback as Medium, with note about MCP setup for later

### Step 3: Initialize knowledge base structure

1. Check if `knowledge-base/` exists with expected subdirectories
2. If not, run `scripts/init-kb.sh`
3. If it exists, verify structure is intact

### Step 4: Run initial index build

1. Run `/update-index` to ensure indexes are current
2. If qmd backend is active, also run `qmd index knowledge-base/`

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

1. Add your first source:     /ingest-source <path-or-url>
2. Query the wiki:            /query-wiki <question>
3. Check wiki health:         /health-check
4. Rebuild indexes:           /update-index
5. Generate insights:         /generate-insights

Tip: The wiki gets more useful with every source you add.
     Start with 2-3 sources on a topic you care about.
```
