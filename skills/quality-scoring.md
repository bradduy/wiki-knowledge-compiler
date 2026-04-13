---
name: quality-scoring
description: Skill for computing a quality score per wiki page — structural completeness, citation health, freshness, and relationship richness
type: rigid
---

# Quality Scoring Skill

Every page in the wiki can be scored on how well-formed, well-sourced, and well-maintained it is. Quality scores surface pages that need attention and help prioritize search results.

## Score components

Each page is scored on 5 dimensions, each worth 0–20 points. Total: 0–100.

### 1. Frontmatter completeness (0–20)

| Field | Points | Notes |
|-------|--------|-------|
| `title` | 4 | Required |
| `type` | 4 | Required |
| `created` | 2 | Required |
| `sources` (at least 1) | 4 | Required — 0 if empty |
| `confidence` | 2 | v0.2.0 field |
| `verified` | 2 | v0.2.0 field |
| `visibility` | 1 | v0.2.0 field |
| `entities` (at least 1) | 1 | v0.2.0 field |

### 2. Citation health (0–20)

| Check | Points | Notes |
|-------|--------|-------|
| Has at least 1 inline citation (link to raw/ or another wiki page) | 8 | Core provenance requirement |
| All `sources` in frontmatter are cited in body | 6 | No phantom sources |
| All inline citations exist as files | 6 | No broken citation links |

### 3. Freshness (0–20)

Based on `verified` date (or `updated` if no `verified`):

| Age | Points |
|-----|--------|
| < 30 days | 20 |
| 30–60 days | 15 |
| 60–90 days | 10 |
| 90–180 days | 5 |
| > 180 days | 0 |

### 4. Relationship richness (0–20)

| Check | Points | Notes |
|-------|--------|-------|
| Has `related` field with at least 1 entry | 6 | Connected to the graph |
| Related entries have `type` annotations | 6 | v0.2.0 typed relationships |
| Has `entities` field with at least 1 entry | 4 | Connected to knowledge graph |
| Related/entity targets exist as files | 4 | No broken relationship links |

### 5. Content quality (0–20)

| Check | Points | Notes |
|-------|--------|-------|
| Body is non-empty (>100 characters excluding frontmatter) | 6 | Not a stub |
| Has section headings (`##`) | 4 | Structured content |
| No `[uncertainty: ...]` markers without resolution | 4 | Uncertainties acknowledged |
| No `[REDACTED: ...]` markers (cleaned content) | 2 | Privacy filter worked |
| Follows the template structure for its type | 4 | Matches `templates/*.md` |

## Score grades

| Score | Grade | Meaning |
|-------|-------|---------|
| 80–100 | **A** | Excellent — well-sourced, fresh, connected |
| 60–79 | **B** | Good — minor gaps |
| 40–59 | **C** | Needs attention — missing fields, stale, or poorly connected |
| 20–39 | **D** | Poor — significant issues |
| 0–19 | **F** | Broken — missing critical fields, no citations |

## When to compute scores

1. **`/wiki-update`** — after rebuilding indexes and applying retention decay, compute quality scores for all pages. Store in `.data/index/master-index.md` alongside page listings.

2. **`/wiki-audit`** — include quality scores in the health report. Flag all C/D/F pages.

3. **`/wiki` queries** — when multiple pages are relevant, prefer higher-scoring pages. Mention low scores: `[note: this page scores [N]/100 — some fields may be incomplete]`.

## Score storage

Scores are NOT stored in individual page frontmatter (to avoid constant rewrites). Instead, scores are computed on demand and summarized in `.data/index/master-index.md`:

```markdown
## Quality Summary

| Grade | Count | Percentage |
|-------|-------|------------|
| A (80-100) | [N] | [%] |
| B (60-79) | [N] | [%] |
| C (40-59) | [N] | [%] |
| D (20-39) | [N] | [%] |
| F (0-19) | [N] | [%] |

Average score: [N]/100

### Pages needing attention (score < 60)

| Page | Score | Grade | Top issues |
|------|-------|-------|------------|
| [path] | [N] | [grade] | [missing confidence, no citations, stale] |
```

## Improving scores

When a page scores low, the most impactful fixes are:

| Issue | Impact | Fix |
|-------|--------|-----|
| Missing `sources` | −4 frontmatter, −8 citations | Add source citations |
| No `verified` date | −2 frontmatter, −20 freshness | Set verified to today if content is accurate |
| No `related` entries | −6 relationships | Link to related concepts/entities |
| No typed relationships | −6 relationships | Add `type` to related entries |
| Broken links | −6 citations, −4 relationships | Fix or remove dead links |
| Empty body | −6 content | Add real content or move to drafts |
