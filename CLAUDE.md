# Wiki Knowledge Compiler — LLM Wiki Plugin

You are operating inside the **wiki-knowledge-compiler** plugin, a local-first knowledge compiler for Claude Code.

## Core Principles

1. **`raw/` is immutable.** Never modify, rename, or delete files in `raw/`. It is the source of truth.
2. **Provenance is mandatory.** Every derived page (summary, concept, topic, insight) must cite its source(s) from `raw/` or other wiki pages. Never fabricate citations.
3. **Uncertainty must be explicit.** If a claim is inferred, speculative, or partially supported, mark it with `[uncertainty: reason]`. Never present uncertain information as fact.
4. **Write-back discipline.** Useful outputs belong in the knowledge base, not just in conversation. If you generate a reusable answer, summary, or insight, write it to the appropriate directory.
5. **Markdown-first.** All knowledge is stored as plain markdown with YAML frontmatter. No proprietary formats, no databases required.
6. **No hallucinated structure.** Only create pages when there is real content to put in them. Do not generate empty placeholder pages to fill out the wiki.

## Knowledge Base Layout

```
raw/             # Immutable source documents (PDFs, notes, URL stubs)
wiki/            # All generated pages the user reads and browses
index/           # Master index, concept index, source index
log.md           # Append-only activity log
.data/           # Hidden internal working data:
  summaries/     #   Per-source summaries with provenance
  concepts/      #   Atomic concept pages
  topics/        #   Broader topic groupings
  insights/      #   Cross-cutting observations
  references/    #   External reference stubs
  drafts/        #   Work-in-progress pages
```

## Commands

- `/wiki-setup` — Set up your wiki (run this first)
- `/wiki-ingest` — Add a document to your wiki
- `/wiki` — Ask a question, get an answer with sources
- `/wiki-insights` — Discover connections across your sources
- `/wiki-health` — Find and fix problems in your wiki
- `/wiki-update` — Refresh the table of contents and indexes

## File Conventions

- Filenames: `kebab-case.md` (e.g., `transformer-architecture.md`)
- Frontmatter: Every wiki page must have YAML frontmatter with at minimum: `title`, `type`, `created`, `sources`
- Links: Use relative markdown links between wiki pages (e.g., `[Attention](../concepts/attention-mechanism.md)`)
- Dates: ISO 8601 format (`YYYY-MM-DD`)

## Search Configuration

The wiki supports multiple search backends based on project size. Configuration lives in `wiki.config.md` at the project root.

| Size | Pages | Backend | Setup |
|------|-------|---------|-------|
| Small | <100 | Grep + index files | None (default) |
| Medium | 100–500 | [qmd](https://github.com/tobi/qmd) CLI | Auto-installed by `/wiki-setup` via npm/bun |
| Large | 500+ | qmd MCP server | Auto-installed by `/wiki-setup` + MCP config |

Run `/wiki-setup` to configure. The search skill (`skills/search-strategy.md`) governs which backend to use. **Always read `wiki.config.md` before performing search** to use the correct tier.

## When in Doubt

- Read `wiki.config.md` to know the active search backend
- Check `index/master-index.md` before creating new pages
- Search existing pages with the configured backend before assuming a concept doesn't exist
- Append to `log.md` after any structural change
- Prefer updating existing pages over creating new ones
- If search results feel inadequate, suggest `/wiki-setup` to upgrade the search tier
