---
name: wiki-audit
description: Check wiki health — find broken links, stale content, contradictions, and auto-fix what it can
---

# Wiki Audit

You are the **wiki-auditor**. Your job is to check the health of the knowledge base, find problems, fix what you can, and report the rest.

## Procedure

### Step 1: Ensure directories exist

```bash
mkdir -p raw wiki .data/index .data/summaries .data/concepts .data/topics .data/insights .data/entities .data/references .data/drafts
```

### Step 2: Scan all pages

Use Glob to list all `.md` files across:
- `wiki/*.md`
- `.data/concepts/*.md`
- `.data/topics/*.md`
- `.data/summaries/*.md`
- `.data/insights/*.md`
- `.data/entities/*.md`
- `.data/references/*.md`
- `.data/drafts/*.md`

For each file, read its frontmatter and record: `title`, `type`, `created`, `updated`, `verified`, `confidence`, `sources`, `related`, `entities`, `supersedes`, `superseded_by`.

### Step 3: Check for broken links

For every markdown link `[text](path)` in every page:
1. Resolve the relative path to an absolute path.
2. Check if the target file exists.
3. If it doesn't exist: **record as broken link**.

**Auto-fix:** If a broken link target has been moved (e.g., from `index/` to `.data/index/`), update the link automatically.

### Step 4: Check for orphan pages

A page is orphaned if:
- No other page links to it
- It has no entries in any index file
- It is not a raw source or an index file itself

**Auto-fix:** For orphaned concepts/topics, add them to the relevant index file. For orphaned entities, check if any concept/summary should reference them and add the link.

### Step 5: Check for missing frontmatter

Every page must have at minimum: `title`, `type`, `created`, `sources`.

Since v0.2.0, pages should also have: `confidence`, `verified`.

For each page missing required fields:
- **Auto-fix `confidence`:** Set to `medium` if the page has 1 source, `high` if 2+, `low` if 0.
- **Auto-fix `verified`:** Set to the page's `updated` or `created` date.
- **Flag** pages missing `title`, `type`, or `sources` — these need human review.

### Step 6: Check for stale content

A page is stale if its `verified` date is more than 90 days ago (or if it has no `verified` date and `updated` is more than 90 days ago).

For each stale page:
1. Record the page path, title, and how many days since last verification.
2. Do NOT auto-fix — just report. The user decides whether to re-verify or archive.

### Step 7: Check for citation mismatches

For each page:
1. Read the `sources` frontmatter field.
2. Scan the page body for inline citations (links to `raw/` files).
3. If a source is listed in frontmatter but never cited in the body, or cited in the body but missing from frontmatter: **record as mismatch**.

**Auto-fix:** Add missing sources to frontmatter if they appear as inline citations.

### Step 8: Detect contradictions

Follow the `skills/contradiction-resolution.md` skill.

1. Read all concept pages and their `related` fields.
2. Look for existing `contradicts` relationships.
3. For each pair of concepts that share the same topic or entity:
   - Compare their definitions and key claims.
   - If they make incompatible claims about the same thing, record as a **contradiction**.
4. For each contradiction found:
   - If both pages already have a `contradicts` relationship, skip.
   - If not: **auto-fix** by adding `contradicts` relationships to both pages' `related` fields.
   - Propose which claim is more likely correct based on source recency, authority, and evidence count.

### Step 9: Check entity graph health

1. Verify all entity `relationships` point to existing files.
2. Check for entities with no relationships (isolated nodes) — suggest connections.
3. Check for duplicate entities (same name or alias under different filenames).

**Auto-fix:** Merge duplicate entities into one page, updating all references.

### Step 10: Rebuild indexes

After all fixes, rebuild:
1. `.data/index/source-index.md`
2. `.data/index/concept-index.md`
3. `.data/index/master-index.md`

### Step 11: Log and report

Append to `.data/log.md`:

```
## [DATE] Wiki audit
- Pages scanned: [count]
- Broken links found: [count] (auto-fixed: [count])
- Orphan pages found: [count] (auto-fixed: [count])
- Missing frontmatter: [count] (auto-fixed: [count])
- Stale pages: [count]
- Citation mismatches: [count] (auto-fixed: [count])
- Contradictions found: [count] (auto-fixed: [count])
- Entity issues: [count] (auto-fixed: [count])
```

Present the report to the user:

```markdown
## Wiki Audit Report

### ✅ Auto-fixed
- [N] broken links repaired
- [N] missing frontmatter fields added
- [N] orphan pages linked
- [N] citation mismatches resolved
- [N] contradiction relationships added
- [N] duplicate entities merged

### ⚠️ Needs attention
- [N] stale pages (not verified in 90+ days)
  - [page] — last verified [date] ([N] days ago)
  - ...
- [N] pages missing required fields (title/type/sources)
  - [page] — missing: [fields]
  - ...
- [N] contradictions detected
  - [concept A] vs [concept B] — [brief description]
    Recommended: keep [A/B] based on [reason]
  - ...

### 📊 Health summary
- Total pages: [count]
- Pages with confidence high: [count]
- Pages with confidence medium: [count]
- Pages with confidence low: [count]
- Average age since last verification: [N] days
- Entity graph: [N] entities, [N] relationships
```

### Step 12: Next step menu

```
What would you like to do next?

  1. 🔧 Fix a specific issue from the report      → tell me which one
  2. 🔍 Ask a question                             → /wiki
  3. 📥 Add more documents                         → /wiki-ingest
  4. ✨ Generate insights                           → /wiki-insights
  5. 🔄 Run another audit                           → /wiki-audit
  6. ✅ I'm done for now

Enter 1-6:
```

Run the command the user picks. If they choose 6, end the session.
