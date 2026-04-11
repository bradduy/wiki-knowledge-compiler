---
name: source-ingestion
description: Skill for ingesting raw sources into the knowledge base with proper storage, metadata, and provenance tracking
type: rigid
---

# Source Ingestion Skill

This skill governs how raw sources are added to the knowledge base. Follow it exactly.

## Pre-ingestion checklist

Before ingesting any source:

- [ ] Determine source type: file (PDF, markdown, text), URL, or pasted content
- [ ] Generate a kebab-case filename from the source title
- [ ] Check if `knowledge-base/raw/` already contains a file with the same or similar name
- [ ] Check if `knowledge-base/.data/index/source-index.md` already lists this source

## Storage rules

### File sources
```bash
# Copy to raw/ — NEVER move, always copy
cp "original/path/source.pdf" "knowledge-base/raw/source-title.pdf"
```

### URL sources
Create a reference stub in `knowledge-base/references/`:
```markdown
---
title: [Article/Paper Title]
type: reference
url: [full URL]
accessed: [today's date]
created: [today's date]
author: [if known, else "unknown"]
---

# [Title]

**URL:** [full URL]
**Accessed:** [date]
**Status:** [active/archived/dead]

## Notes
[Brief description of what this URL contains and why it was added]
```

### Pasted content
Save to `knowledge-base/raw/` as a `.md` file:
```markdown
---
title: [descriptive title]
type: raw-note
created: [today's date]
origin: user-provided
---

[pasted content verbatim — do not edit]
```

## Metadata requirements

Every raw source must be tracked in `knowledge-base/.data/index/source-index.md` with:
- Filename and path
- Date ingested
- Original location (file path, URL, or "user-provided")
- Ingestion status: `complete`, `partial`, or `pending`

## Filename conventions

| Source type | Pattern | Example |
|-------------|---------|---------|
| Academic paper | `author-year-short-title.pdf` | `vaswani-2017-attention-is-all-you-need.pdf` |
| Blog post | `source-short-title.md` | `karpathy-llm-os.md` |
| Book chapter | `book-title-ch-N.md` | `deep-learning-ch-10.md` |
| Personal note | `note-topic-date.md` | `note-rl-ideas-2024-01-15.md` |
| URL reference | `ref-short-title.md` | `ref-pytorch-docs-autograd.md` |

## Deduplication

If a source with a similar name exists:
1. Read the existing source's first 500 characters
2. Compare with the new source's first 500 characters
3. If they match: **abort** and inform the user the source is already ingested
4. If they differ: ask the user to confirm — it may be an updated version
5. If it's an update: store with a versioned name (`source-v2.md`) and update the summary
