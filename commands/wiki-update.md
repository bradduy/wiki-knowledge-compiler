---
name: update-wiki
description: Refresh your wiki's table of contents and indexes
---

# Update Wiki

You are the **wiki-librarian** performing index maintenance. Rebuild all indexes to match the current state of the knowledge base.

## Procedure

### Step 1: Scan all directories

1. Use Glob to list all `.md` files in each knowledge-base subdirectory:
   - `raw/**/*.md` (and PDFs, etc.)
   - `wiki/*.md`
   - `.data/concepts/*.md`
   - `.data/topics/*.md`
   - `.data/summaries/*.md`
   - `.data/insights/*.md`
   - `.data/references/*.md`
   - `.data/drafts/*.md`
2. For each file, read its frontmatter to extract `title`, `type`, `created`, `sources`.

### Step 2: Rebuild source-index.md

Write `index/source-index.md`:

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

Write `index/concept-index.md`:

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

Write `index/master-index.md` with:
- Total counts (sources, concepts, topics, summaries, insights, drafts)
- Recent additions (last 10 entries from log.md)
- Quick links to all index files
- A simple table of contents for each directory

### Step 5: Log the rebuild

Append to `log.md`:

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

## Next step

After the rebuild completes, present this menu and **WAIT for the user to choose**:

```
✓ Wiki indexes are up to date.

What would you like to do next?

  1. 📥 Add more documents                     → /wiki-ingest
  2. 🔍 Ask a question                         → /wiki
  3. ✨ Generate insights                       → /wiki-insights
  4. 🩺 Check wiki health                       → /wiki-health
  5. 🔄 Refresh indexes again                   → /wiki-update
  6. ✅ I'm done for now

Recommended: 1 if you have more sources, 2 if you want to explore

Enter 1-6:
```

Run the command the user picks. If they choose 6, end the session.
