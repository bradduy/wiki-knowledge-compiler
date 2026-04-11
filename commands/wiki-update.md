---
name: wiki-update
description: Sync your wiki — ingest new files in raw/ and refresh indexes
---

# Wiki Update

You are the **wiki-librarian**. Your job is to sync everything: ingest any new files in `raw/`, then rebuild all indexes.

## Procedure

### Step 1: Check for unprocessed files in raw/

1. Scan `raw/` for all files.
2. Check which ones already have a matching summary in `.data/summaries/`.
3. If there are **unprocessed files** (files in `raw/` with no matching summary):
   - Tell the user:
     ```
     Found [N] new document(s) in raw/. Ingesting...
     ```
   - Run the ingestion workflow (same as `/wiki-ingest`) for each file, one at a time. Show progress:
     ```
     [1/N] Ingesting: filename1.md ...
       ✓ Summary created, 3 concepts extracted

     [2/N] Ingesting: filename2.pdf ...
       ✓ Summary created, 5 concepts extracted
     ```
   - After all files: `✓ Ingested [N] new documents.`
4. If no new files, tell the user: `No new files in raw/.`

### Step 2: Scan all directories

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

### Step 3: Rebuild source-index.md

Write `.data/index/source-index.md`:

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

### Step 4: Rebuild concept-index.md

Write `.data/index/concept-index.md`:

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

### Step 5: Rebuild master-index.md

Write `.data/index/master-index.md` with:
- Total counts (sources, concepts, topics, summaries, insights, drafts)
- Recent additions (last 10 entries from `.data/log.md`)
- Quick links to all index files
- A simple table of contents for each directory

### Step 6: Update wiki/index.md

Update `wiki/index.md` — the user-facing landing page — to reflect current wiki contents:
- List all topic pages with links (grouped by theme if possible)
- List recent additions
- Show total counts (sources, pages)
- Keep the Quick Commands section at the bottom

If `wiki/index.md` doesn't exist, create it.

### Step 7: Log the rebuild

Append to `.data/log.md`:

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

  1. 📥 Add more documents                         → /wiki-ingest
  2. 🔍 Ask a question                             → /wiki
  3. ✨ Generate insights                           → /wiki-insights
  4. 📅 Schedule automatic updates                  → /wiki-schedule
  5. 🔄 Sync again                                  → /wiki-update
  6. ✅ I'm done for now

Recommended: 1 if you have more sources, 2 if you want to explore

Enter 1-6:
```

Run the command the user picks. If they choose 6, end the session.
