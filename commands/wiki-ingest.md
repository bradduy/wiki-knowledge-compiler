---
name: wiki-ingest
description: Add a document to your wiki — creates summaries, extracts key ideas, and connects everything
arguments:
  - name: source
    description: A file path, folder path, multiple files, glob pattern, URL, or pasted text
    required: true
---

# Wiki Ingest

You are the **wiki-ingestor**. Your job is to add a new source to the knowledge base and extract all useful knowledge from it.

## Input

The user provides: `$ARGUMENTS`

This may be:
- A single file path (e.g. `~/Documents/article.md`)
- Multiple files (e.g. `abc.pdf a.md c.docx`)
- A mix of files and URLs (e.g. `abc.pdf https://example.com/article a.md`)
- A folder path (e.g. `~/Documents/research/`) — ingest all supported files inside
- A glob pattern (e.g. `~/papers/*.pdf`)
- A URL to create a reference stub (e.g. `https://example.com/article`)
- Pasted text content to save as a raw source

## Procedure

Follow these steps **in order**. Do not skip steps.

### Step 0: Detect input type and build a file list

1. **If it's a folder path** (path exists and is a directory):
   - Scan the folder for supported files: `.md`, `.txt`, `.pdf`, `.doc`, `.docx`, `.html`
   - Include subfolders recursively
   - Exclude hidden files (starting with `.`) and common non-content files (`node_modules/`, `.git/`, etc.)
   - Build a list of all found files
   - Tell the user:
     ```
     Found [N] document(s) in [folder path]:
       - filename1.md
       - filename2.pdf
       - ...

     Ingest all of them? (yes / let me pick / cancel)
     ```
   - If "yes": proceed with the full list
   - If "let me pick": let the user select which files to ingest
   - If "cancel": stop

2. **If it's multiple items (files, URLs, or a mix):**
   - Split the input by spaces
   - For each item, detect if it's a file path (exists on disk), a URL (starts with `http`), or a glob pattern (contains `*` or `?`)
   - Expand any glob patterns
   - Verify each file path exists; warn and skip any that don't
   - Tell the user: `Ingesting [N] items...`

3. **If it's a single file, URL, or pasted text:** proceed directly to Step 1 with one item.

**For multiple files:** run Steps 1–7 for each file, one at a time. Show progress:
```
[1/N] Ingesting: filename1.md ...
  ✓ Summary created, 4 concepts extracted

[2/N] Ingesting: filename2.pdf ...
  ✓ Summary created, 2 concepts extracted, 1 concept updated
```

After all files are processed, show a combined report:
```
Done! [N] documents added to the wiki.

Created:
  - [X] summaries
  - [Y] new concepts
  - [Z] topic pages updated

Updated:
  - [W] existing concepts (new sources added)
```

Then skip to the **Next step** section at the bottom.

### Step 1: Ensure directories exist

Before writing any files, create the directories you'll need. Run:
```bash
mkdir -p raw wiki .data/index .data/summaries .data/concepts .data/topics .data/insights .data/references .data/drafts .data/entities
```
This is safe to run every time — `mkdir -p` does nothing if the folder already exists.

**Directory layout:**
- `raw/` — user-facing: original documents (immutable)
- `wiki/` — user-facing: final polished pages the user reads and browses
- `.data/index/` — hidden: table of contents (auto-generated)
- `.data/summaries/` — hidden: per-source summaries with provenance
- `.data/concepts/` — hidden: atomic concept pages
- `.data/topics/` — hidden: broader topic groupings
- `.data/insights/` — hidden: cross-cutting observations
- `.data/references/` — hidden: external URL stubs
- `.data/entities/` — hidden: knowledge graph entities (people, projects, technologies)
- `.data/drafts/` — hidden: work-in-progress pages

### Step 2: Validate and store the raw source

1. If it's a file path, copy the file into `raw/` with a kebab-case filename. **Never modify the original.**
2. If it's a URL, create a reference stub in `.data/references/` using the source-stub template.
3. If it's pasted content, save it as a new `.md` file in `raw/` with an appropriate name.
4. Record the source metadata: filename, date ingested, original location.

### Step 3: Read and understand the source

1. Read the full source content.
2. Identify the key claims, concepts, arguments, and structure.
3. Note any uncertainty, caveats, or limitations stated by the author.

### Step 4: Create or update the summary

1. Check if a summary already exists in `.data/summaries/` for this source.
2. If not, create one using the summary template from `templates/summary.md`.
3. The summary must:
   - Cite the raw source by relative path
   - Preserve the author's stated uncertainty
   - Not introduce claims not in the source
   - Include a "Key Takeaways" section
   - Set `confidence` based on source quality (peer-reviewed = high, blog = medium, etc.)
   - Set `authority` to `primary` (original research/docs), `secondary` (review/analysis), or `commentary` (opinion/blog)
   - Set `verified` to today's date

### Step 5: Extract and write concepts

1. Identify 3-10 atomic concepts from the source.
2. For each concept, check `.data/concepts/` and `.data/index/concept-index.md` to see if it already exists.
3. If it exists: update the existing page with new information, add a source citation, update `confidence` and `verified`.
4. If it's new: create a concept page using `templates/concept.md` in `.data/concepts/`.
5. Each concept page must have a clear one-paragraph definition and at least one source citation.
6. Use **typed relationships** in the `related` field — each entry needs a `page` and a `type` (extends, contradicts, supersedes, depends-on, generalizes, component-of).
7. If a new concept contradicts an existing one, add `contradicts` relationships on both pages and note the conflict.

### Step 6: Update topic pages

1. Identify which broader topics this source relates to.
2. Check `.data/topics/` for existing topic pages.
3. Update existing topics with references to the new summary and concepts.
4. Only create a new topic page if the source clearly introduces a new domain not covered by existing topics.

### Step 7: Extract entities

Follow the `skills/entity-extraction.md` skill.

1. Identify named entities in the source: people, projects, libraries, technologies, decisions, organizations, files.
2. For each entity, check `.data/entities/` to see if it already exists.
3. If it exists: update with new relationships, sources, and attributes.
4. If it's new: create an entity page using `templates/entity.md` in `.data/entities/`.
5. Link entities to the concepts and summary created in earlier steps (add to their `entities` frontmatter).
6. Set `confidence` based on how clearly the source identifies the entity.
7. Extract typed relationships between entities (uses, depends-on, maintained-by, etc.).

### Step 8: Publish to wiki/

After creating summaries, concepts, and topics in `.data/`, publish the **user-facing pages** to `wiki/`:

1. For each new or updated concept, create or update a clean page in `wiki/` with the same filename.
2. For each new summary, create a readable version in `wiki/`.
3. For topic pages, create or update them in `wiki/`.
4. Pages in `wiki/` should be polished, well-linked, and easy to read — this is what the user sees in Obsidian and their editor.

### Step 9: Update indexes

1. Add the source to `.data/index/source-index.md`.
2. Add new concepts to `.data/index/concept-index.md`.
3. Update `.data/index/master-index.md` with any new pages created.

### Step 10: Log the ingestion

Append to `.data/log.md`:

```
## [DATE] Ingested: [source name]
- Source: `raw/[filename]`
- Summary: `summaries/[filename]`
- Concepts created: [list]
- Concepts updated: [list]
- Topics updated: [list]
- Entities created: [list]
- Entities updated: [list]
```

## Success criteria

- Raw source stored immutably
- Summary written with provenance, confidence, and authority
- Concepts extracted and deduplicated with typed relationships
- Entities extracted and connected
- Topics updated
- Indexes current
- Log entry appended

## Failure modes

- **Source already exists**: Check `raw/` first. If a file with the same name exists, ask the user before overwriting. Consider it might be an update to an existing source.
- **Empty source**: If the source has no extractable content, log it but do not create empty wiki pages.
- **Ambiguous concepts**: If a concept is too vague to define atomically, place it in `drafts/` with a `[needs-refinement]` tag.

## Next step

After the ingestion report, present this menu and **WAIT for the user to choose**:

```
✓ Done! Your document has been added to the wiki.

What would you like to do next?

  1. 🔍 Ask a question about what you just added     → /wiki
  2. 📥 Add another document                          → /wiki-ingest
  3. ✨ Find connections across your sources           → /wiki-insights
  4. 🔄 Sync wiki (ingest new raw files + reindex)    → /wiki-update
  5. 📅 Schedule automatic updates                     → /wiki-schedule
  6. ✅ I'm done for now

Recommended: 1 (ask a question about what you just added)

Enter 1-6:
```

Run the command the user picks. If they choose 6, end the session.
