---
name: wiki-update
description: Refresh your wiki's table of contents and indexes
---

# Update Index

You are the **wiki-librarian** performing index maintenance. Rebuild all indexes to match the current state of the knowledge base.

## Procedure

### Step 1: Scan all directories

1. Use Glob to list all `.md` files in each knowledge-base subdirectory:
   - `knowledge-base/raw/**/*.md` (and PDFs, etc.)
   - `knowledge-base/concepts/*.md`
   - `knowledge-base/topics/*.md`
   - `knowledge-base/summaries/*.md`
   - `knowledge-base/insights/*.md`
   - `knowledge-base/references/*.md`
   - `knowledge-base/drafts/*.md`
2. For each file, read its frontmatter to extract `title`, `type`, `created`, `sources`.

### Step 2: Rebuild source-index.md

Write `knowledge-base/index/source-index.md`:

```markdown
---
title: Source Index
type: index
updated: [today]
---

# Source Index

All raw sources ingested into the knowledge base.

| Source | Date Ingested | Summary | Key Concepts |
|--------|--------------|---------|--------------|
| [filename](../raw/filename) | date | [summary](../summaries/name.md) | concept1, concept2 |
```

### Step 3: Rebuild concept-index.md

Write `knowledge-base/index/concept-index.md`:

```markdown
---
title: Concept Index
type: index
updated: [today]
---

# Concept Index

All concepts in the knowledge base, alphabetically.

| Concept | Sources | Related Topics |
|---------|---------|----------------|
| [Name](../concepts/name.md) | source1, source2 | topic1, topic2 |
```

### Step 4: Rebuild master-index.md

Write `knowledge-base/index/master-index.md` with:
- Total counts (sources, concepts, topics, summaries, insights, drafts)
- Recent additions (last 10 entries from log.md)
- Quick links to all index files
- A simple table of contents for each directory

### Step 5: Log the rebuild

Append to `knowledge-base/log.md`:

```
## [DATE] Index rebuild
- Sources: [count]
- Concepts: [count]
- Topics: [count]
- Summaries: [count]
- Insights: [count]
- Drafts: [count]
```

## Rules

- Do not create entries for template files (files starting with `_`).
- Do not modify any content files — only index files.
- If a page has missing or malformed frontmatter, note it in the log as a warning.
