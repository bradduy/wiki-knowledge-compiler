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
.data/           # Hidden internal working data:
  index/         #   Master index, concept index, source index
  log.md         #   Append-only activity log
  summaries/     #   Per-source summaries with provenance
  concepts/      #   Atomic concept pages
  topics/        #   Broader topic groupings
  insights/      #   Cross-cutting observations
  entities/      #   Knowledge graph — people, projects, technologies, decisions
  references/    #   External reference stubs
  drafts/        #   Work-in-progress pages
```

## Knowledge Graph

The wiki maintains a knowledge graph as typed markdown pages in `.data/entities/`. During ingestion, named entities (people, projects, libraries, technologies, decisions) are extracted and connected with typed relationships.

- **Entity types:** person, project, library, technology, decision, organization, file
- **Relationship types:** uses, used-by, depends-on, maintained-by, owns, created-by, part-of, replaces, contradicts, implements, relates-to, defined-in
- **Concept relationship types:** extends, contradicts, supersedes, depends-on, generalizes, component-of

Every page (concept, topic, insight, summary) links to relevant entities via the `entities` frontmatter field. Queries use graph traversal (walking entity relationships) alongside keyword/semantic search to find connections.

## Confidence & Lifecycle

Every page carries lifecycle metadata:

- **`confidence: high/medium/low`** — how well-supported the content is by sources
- **`verified: YYYY-MM-DD`** — when the content was last confirmed accurate
- **`authority: primary/secondary/commentary`** — source reliability tier (summaries only)
- **`supersedes` / `superseded_by`** — explicit version chain when content is replaced

## Commands

- `/wiki-setup` — Set up your wiki (run this first)
- `/wiki-ingest` — Add a document to your wiki
- `/wiki` — Ask a question, get an answer with sources
- `/wiki-insights` — Discover connections across your sources
- `/wiki-update` — Sync your wiki (ingest new raw files + refresh indexes)
- `/wiki-schedule` — Schedule /wiki-update to run automatically

## File Conventions

- Filenames: `kebab-case.md` (e.g., `transformer-architecture.md`)
- Frontmatter: Every wiki page must have YAML frontmatter with at minimum: `title`, `type`, `created`, `sources`
- Links: Use relative markdown links between wiki pages (e.g., `[Attention](../concepts/attention-mechanism.md)`)
- Dates: ISO 8601 format (`YYYY-MM-DD`)

## Search Configuration

The wiki supports multiple search backends based on project size. Configuration lives in `.data/wiki.config.md` at the project root.

| Size | Pages | Backend | Setup |
|------|-------|---------|-------|
| Small | <100 | Grep + index files | None (default) |
| Medium | 100–500 | [qmd](https://github.com/tobi/qmd) CLI | Auto-installed by `/wiki-setup` via npm/bun |
| Large | 500+ | qmd MCP server | Auto-installed by `/wiki-setup` + MCP config |

Run `/wiki-setup` to configure. The search skill (`skills/search-strategy.md`) governs which backend to use. **Always read `.data/wiki.config.md` before performing search** to use the correct tier.

## When in Doubt

- Read `.data/wiki.config.md` to know the active search backend
- Check `.data/index/master-index.md` before creating new pages
- Search existing pages with the configured backend before assuming a concept doesn't exist
- Append to `.data/log.md` after any structural change
- Prefer updating existing pages over creating new ones
- If search results feel inadequate, suggest `/wiki-setup` to upgrade the search tier
