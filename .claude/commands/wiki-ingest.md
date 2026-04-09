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
- A folder path (e.g. `~/Documents/research/`) — ingest all supported files inside
- Multiple files (e.g. `~/notes/a.md ~/notes/b.md ~/notes/c.pdf`)
- A glob pattern (e.g. `~/papers/*.pdf`)
- A URL to create a reference stub
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

2. **If it's multiple files or a glob pattern:**
   - Resolve all paths / expand the glob
   - Verify each file exists
   - Tell the user: `Ingesting [N] documents...`

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

### Step 1: Validate and store the raw source

1. If it's a file path, copy the file into `knowledge-base/raw/` with a kebab-case filename. **Never modify the original.**
2. If it's a URL, create a reference stub in `knowledge-base/references/` using the source-stub template.
3. If it's pasted content, save it as a new `.md` file in `knowledge-base/raw/` with an appropriate name.
4. Record the source metadata: filename, date ingested, original location.

### Step 2: Read and understand the source

1. Read the full source content.
2. Identify the key claims, concepts, arguments, and structure.
3. Note any uncertainty, caveats, or limitations stated by the author.

### Step 3: Create or update the summary

1. Check if a summary already exists in `knowledge-base/summaries/` for this source.
2. If not, create one using the summary template from `templates/summary.md`.
3. The summary must:
   - Cite the raw source by relative path
   - Preserve the author's stated uncertainty
   - Not introduce claims not in the source
   - Include a "Key Takeaways" section

### Step 4: Extract and write concepts

1. Identify 3-10 atomic concepts from the source.
2. For each concept, check `knowledge-base/concepts/` and `knowledge-base/index/concept-index.md` to see if it already exists.
3. If it exists: update the existing page with new information and add a source citation.
4. If it's new: create a concept page using `templates/concept.md`.
5. Each concept page must have a clear one-paragraph definition and at least one source citation.

### Step 5: Update topic pages

1. Identify which broader topics this source relates to.
2. Check `knowledge-base/topics/` for existing topic pages.
3. Update existing topics with references to the new summary and concepts.
4. Only create a new topic page if the source clearly introduces a new domain not covered by existing topics.

### Step 6: Update indexes

1. Add the source to `knowledge-base/index/source-index.md`.
2. Add new concepts to `knowledge-base/index/concept-index.md`.
3. Update `knowledge-base/index/master-index.md` with any new pages created.

### Step 7: Log the ingestion

Append to `knowledge-base/log.md`:

```
## [DATE] Ingested: [source name]
- Source: `raw/[filename]`
- Summary: `summaries/[filename]`
- Concepts created: [list]
- Concepts updated: [list]
- Topics updated: [list]
```

## Success criteria

- Raw source stored immutably
- Summary written with provenance
- Concepts extracted and deduplicated
- Topics updated
- Indexes current
- Log entry appended

## Failure modes

- **Source already exists**: Check `raw/` first. If a file with the same name exists, ask the user before overwriting. Consider it might be an update to an existing source.
- **Empty source**: If the source has no extractable content, log it but do not create empty wiki pages.
- **Ambiguous concepts**: If a concept is too vague to define atomically, place it in `drafts/` with a `[needs-refinement]` tag.

## Next step

After the ingestion report, show this:

```
Done! Your document has been added to the wiki.

→ Next step — try asking a question about it:
  /wiki-query <your question>

You can also:
  • Add another document:     /wiki-ingest <file, URL, or paste text>
  • Find connections:          /wiki-insights
```
