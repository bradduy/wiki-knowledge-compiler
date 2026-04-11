---
name: search-strategy
description: Skill governing how to search the knowledge base based on the configured project size and search backend
type: rigid
---

# Search Strategy Skill

The search approach depends on the project size configured in `wiki.config.md`. **Always read `wiki.config.md` before searching** to determine the active backend.

## Search tiers

### Tier 1: Grep (small projects, <100 pages)

**Backend value:** `grep`
**When:** Default for new projects and small knowledge bases.

**How to search:**

1. **Start with the index.** Read `knowledge-base/index/master-index.md` to understand scope.
2. **Keyword search.** Use Grep across `knowledge-base/` for exact and partial keyword matches.
3. **Follow links.** When you find a relevant page, follow its markdown links to related pages.
4. **Scan directories.** If Grep misses something, use Glob to list files in relevant directories and read promising filenames.

**Strengths:** Zero setup, works immediately, no external tools.
**Limits:** No semantic search, no ranking. At 100+ pages, keyword searches return too many results and miss synonym matches.

**When to upgrade:** If searches regularly return 20+ results, or you find yourself missing pages that use different terminology than your query, suggest the user run `/wiki-setup` to upgrade to qmd.

---

### Tier 2: qmd CLI (medium projects, 100–500 pages)

**Backend value:** `qmd-cli`
**When:** User has installed [qmd](https://github.com/tobi/qmd) and configured it via `/wiki-setup`.

**How to search:**

1. **Primary search — qmd CLI.** Shell out to qmd for ranked results:
   ```bash
   qmd search "your query here"
   ```
   For semantic/vector search:
   ```bash
   qmd vsearch "natural language query"
   ```
   For hybrid search with re-ranking:
   ```bash
   qmd query "your query here"
   ```

2. **Fallback — Grep.** If qmd is unavailable (not installed, index stale), fall back to Tier 1 Grep search. Note the fallback in your response.

3. **Re-index after changes.** After ingesting new sources or creating pages, run:
   ```bash
   qmd embed
   ```

4. **Follow-up reads.** qmd returns file paths and snippets. Read the full pages for context before answering.

**Strengths:** Semantic understanding, handles synonyms, ranked results, hybrid search.
**Limits:** Requires qmd installation. CLI shell-out adds slight latency.

**When to upgrade:** If the wiki exceeds 500 pages or search latency becomes noticeable during complex queries, suggest upgrading to qmd MCP mode.

---

### Tier 3: qmd MCP Server (large projects, 500+ pages)

**Backend value:** `qmd-mcp`
**When:** User has qmd running as an MCP server, configured in Claude Code's MCP settings.

**How to search:**

1. **Primary search — MCP tool.** Use the qmd MCP tool directly (no shell-out needed):
   - The tool appears as `qmd_search` or similar in your available tools
   - Supports natural language queries
   - Returns ranked results with relevance scores
   - Supports LLM re-ranking for highest quality results

2. **Combine with index files.** Even with MCP search, skim `master-index.md` for structural orientation — it shows what categories and topics exist, which helps you interpret search results.

3. **Fallback chain:** qmd MCP → qmd CLI → Grep. Always degrade gracefully.

4. **Re-index.** The MCP server may auto-index, but after bulk ingestion, explicitly request re-indexing.

**Strengths:** Native tool integration (no shell-out), fastest for large wikis, LLM re-ranking, best semantic understanding.
**Limits:** Requires MCP configuration, more complex setup.

---

### Tier 4: Custom search (advanced users)

**Backend value:** `custom`
**When:** User has provided their own search script at `scripts/search.sh`.

**How to search:**

1. Run the custom script:
   ```bash
   bash scripts/search.sh "query" knowledge-base/
   ```
2. Expect output as one file path per line, ranked by relevance.
3. Fall back to Grep if the script fails or is missing.

---

## Choosing a search approach per query

Not every query needs the full search backend:

| Query type | Best approach |
|------------|---------------|
| "What do we have about X?" | Index files first, then search |
| "Find the page about X" | Grep/Glob for filename, then index |
| "How does X relate to Y?" | Full search backend — needs semantic matching |
| "What sources mention X?" | Grep with source-index cross-reference |
| "Summarize everything about X" | Full search backend + follow all links |

## Detecting when search is insufficient

Watch for these signals that the current tier isn't enough:

- **Too many results:** Grep returns 20+ matches and you can't easily identify the best ones
- **Missed synonyms:** You find relevant pages by browsing that keyword search missed
- **Slow exploration:** You're reading 10+ files to find 2-3 relevant ones
- **User frustration:** User says "I know we have something about X" but search can't find it

When you notice these, suggest upgrading:
```
Note: This search returned many results and may have missed some relevant pages.
Your wiki has grown beyond what simple keyword search handles well.
Consider running /wiki-setup to upgrade to qmd for better search quality.
```

## Re-indexing discipline

After any of these events, re-index:
- `/wiki-ingest` completes (new pages created)
- `/wiki-update` applies fixes (pages modified)
- Manual page creation or editing
- `/wiki-update` runs (file index rebuilt)

For qmd backends:
```bash
qmd embed
```

For Grep backend: no action needed (Grep is always live).
