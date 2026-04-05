# Memory Compiler — LLM Wiki Plugin

You are operating inside the **memory-compiler** plugin, a local-first knowledge compiler for Claude Code.

## Core Principles

1. **`raw/` is immutable.** Never modify, rename, or delete files in `knowledge-base/raw/`. It is the source of truth.
2. **Provenance is mandatory.** Every derived page (summary, concept, topic, insight) must cite its source(s) from `raw/` or other wiki pages. Never fabricate citations.
3. **Uncertainty must be explicit.** If a claim is inferred, speculative, or partially supported, mark it with `[uncertainty: reason]`. Never present uncertain information as fact.
4. **Write-back discipline.** Useful outputs belong in the knowledge base, not just in conversation. If you generate a reusable answer, summary, or insight, write it to the appropriate directory.
5. **Markdown-first.** All knowledge is stored as plain markdown with YAML frontmatter. No proprietary formats, no databases required.
6. **No hallucinated structure.** Only create pages when there is real content to put in them. Do not generate empty placeholder pages to fill out the wiki.

## Knowledge Base Layout

```
knowledge-base/
  raw/           # Immutable source documents (PDFs, notes, URL stubs)
  concepts/      # Atomic concept pages (one concept per file)
  topics/        # Broader topic pages that group related concepts
  summaries/     # Source-level summaries with provenance
  insights/      # Cross-cutting observations and synthesis
  index/         # Master index, concept index, source index
  drafts/        # Work-in-progress pages not yet promoted
  references/    # External reference stubs (URLs, papers, books)
  log.md         # Append-only activity log
```

## Commands

- `/ingest-source` — Add a raw source and extract knowledge from it
- `/query-wiki` — Search and answer questions from the knowledge base
- `/update-index` — Rebuild all indexes
- `/health-check` — Audit the wiki for structural problems
- `/generate-insights` — Synthesize new insights from existing knowledge

## File Conventions

- Filenames: `kebab-case.md` (e.g., `transformer-architecture.md`)
- Frontmatter: Every wiki page must have YAML frontmatter with at minimum: `title`, `type`, `created`, `sources`
- Links: Use relative markdown links between wiki pages (e.g., `[Attention](../concepts/attention-mechanism.md)`)
- Dates: ISO 8601 format (`YYYY-MM-DD`)

## When in Doubt

- Check `knowledge-base/index/master-index.md` before creating new pages
- Search existing pages with Grep before assuming a concept doesn't exist
- Append to `knowledge-base/log.md` after any structural change
- Prefer updating existing pages over creating new ones
