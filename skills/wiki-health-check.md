---
name: wiki-health-check
description: Skill for auditing and maintaining the structural health of the knowledge base
type: rigid
---

# Wiki Health Check Skill

This skill defines the checks performed during a knowledge base audit. Follow the checklist exactly.

## Health dimensions

### 1. Structural integrity

| Check | Severity | Detection |
|-------|----------|-----------|
| Missing directories | Error | Glob for expected dirs under knowledge-base/ |
| Files in wrong directory | Warning | Read frontmatter `type` field, verify it matches the directory |
| Missing frontmatter | Error | Read first lines, check for `---` YAML block |
| Missing required fields | Warning | Check for `title`, `type`, `created`, `sources` |

### 2. Provenance chain

Every derived page must trace back to a raw source:

```
insight → references concepts/summaries → references raw/
concept → references raw/ or references/
summary → references raw/
topic → references concepts + summaries → references raw/
```

**Check:** For each page in concepts/, summaries/, topics/, insights/:
- `sources` field is non-empty
- Each source path resolves to an existing file
- The chain eventually reaches `raw/` or `references/`

**Severity:** Missing provenance = Error. Broken source path = Error.

### 3. Orphan detection

**Definition:** A page is orphaned if no other non-index page links to it.

**Check:**
1. Build a set of all relative link targets across all pages
2. Build a set of all page paths
3. Pages in the second set but not the first (excluding index files and templates) are orphans

**Severity:** Warning.

### 4. Duplicate detection

**Check for near-duplicate filenames:**
- Normalize filenames: lowercase, remove hyphens/underscores
- Flag pairs with Levenshtein distance ≤ 2

**Check for semantic duplicates:**
- Read the `title` field of all concept pages
- Flag pairs with identical or near-identical titles
- Read the first paragraph of flagged pairs to confirm

**Severity:** Warning (require human judgment to resolve).

### 5. Staleness

**A page is stale if:**
- Its `updated` date is >90 days ago AND new sources have been added to related topics since
- It contains broken links to deleted/renamed pages
- A source it summarizes has been replaced by a newer version

**Severity:** Info (stale by age), Warning (broken links).

### 6. Cross-link quality

| Metric | Threshold | Severity |
|--------|-----------|----------|
| Outgoing links from a concept page | < 1 | Warning: isolated |
| Incoming links to a concept page | 0 (from non-index) | Warning: unreferenced |
| Concept links from a topic page | < 2 | Info: thin topic |
| Source links from a summary | < 1 raw source | Error: ungrounded |

### 7. Index accuracy

- Every page in concepts/, topics/, summaries/, insights/ should appear in the master index
- Every raw source should appear in the source index
- Every concept should appear in the concept index
- Flag pages missing from their expected index

**Severity:** Warning.

## Report template

```markdown
# Knowledge Base Health Report — [DATE]

## Summary
- Total pages: [count]
- Errors: [count]
- Warnings: [count]
- Info: [count]

## Errors
[list with file paths and specific issue]

## Warnings
[list with file paths and specific issue]

## Info
[list with file paths and specific issue]

## Recommended Actions
[ordered by impact, with specific instructions]
```

## Safe auto-fixes

These can be applied without user confirmation:
- Adding orphan pages to indexes
- Updating the `updated` field when a page is modified
- Fixing relative link paths when a file was renamed (if the new name is unambiguous)

These require user confirmation:
- Merging duplicate pages
- Deleting orphan pages
- Rewriting stale summaries
