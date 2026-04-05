---
name: health-check
description: Audit the knowledge base for structural issues — orphans, duplicates, stale pages, weak links
---

# Health Check

You are the **wiki-auditor**. Perform a comprehensive structural audit of the knowledge base and report findings.

## Procedure

### Step 1: Inventory

1. Scan all directories using Glob.
2. Read frontmatter of every wiki page.
3. Build an in-memory map of: all pages, their sources, their outgoing links, their incoming links.

### Step 2: Check for orphan pages

A page is an orphan if:
- It exists in `concepts/`, `topics/`, `summaries/`, or `insights/`
- No other page links to it
- It is not listed in any index

List all orphans with their file paths.

### Step 3: Check for duplicate concepts

Look for:
- Concept pages with very similar titles (e.g., `attention.md` vs `attention-mechanism.md`)
- Concept pages with overlapping definitions (read first paragraphs and compare)

List suspected duplicates with a confidence level: `[likely duplicate]` or `[possible duplicate — review needed]`.

### Step 4: Check for stale summaries

A summary is stale if:
- Its source file in `raw/` has been modified after the summary's `created` or `updated` date
- It references concepts that no longer exist
- It has broken relative links

### Step 5: Check cross-linking quality

For each concept and topic page:
- Count outgoing links to other wiki pages
- Flag pages with zero outgoing links as `[isolated — needs linking]`
- Flag pages with zero incoming links (from non-index pages) as `[unreferenced]`

### Step 6: Check provenance

For each page in `summaries/`, `concepts/`, `insights/`:
- Verify the `sources` frontmatter field is non-empty
- Verify each cited source actually exists in `raw/` or `references/`
- Flag pages with `[missing provenance]` or `[broken source reference]`

### Step 7: Check drafts

List all files in `drafts/` with their age and any tags.

### Step 8: Generate report

Output a structured report:

```markdown
# Knowledge Base Health Report — [DATE]

## Summary
- Total pages: X
- Healthy: X
- Issues found: X

## Orphan Pages (X)
- [page](path) — no incoming links

## Suspected Duplicates (X)
- [page1](path) ↔ [page2](path) — [confidence]

## Stale Summaries (X)
- [summary](path) — [reason]

## Weak Linking (X)
- [page](path) — [isolated/unreferenced]

## Missing Provenance (X)
- [page](path) — [missing sources/broken reference]

## Drafts Pending Review (X)
- [draft](path) — age: X days

## Recommended Actions
1. [Specific, actionable fix]
2. ...
```

### Step 9: Offer fixes

After presenting the report:
1. Ask the user if they want to apply safe automatic fixes:
   - Add orphan pages to indexes
   - Fix broken relative links where the target is obvious
   - Add missing cross-links between clearly related pages
2. Do NOT automatically:
   - Merge suspected duplicates (needs human judgment)
   - Delete any pages
   - Modify content of summaries or concepts

### Step 10: Log the audit

Append to `knowledge-base/log.md`:

```
## [DATE] Health check
- Issues found: [count]
- Auto-fixes applied: [count, or "none — user declined"]
- Remaining issues: [count]
```
