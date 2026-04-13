---
name: retention-decay
description: Skill for applying time-based confidence decay to wiki pages — knowledge fades unless reinforced, at rates that vary by page type
type: rigid
---

# Retention Decay Skill

Knowledge that isn't accessed or reinforced becomes less reliable over time. This skill implements Ebbinghaus-style forgetting curves adapted to a knowledge base. Follow it exactly.

## Core principle

Every page's `confidence` decays over time based on how long it has been since `verified`. Each access (query read, source confirmation, manual review) resets the clock. The decay rate varies by page type — architectural decisions age slowly, transient observations age fast.

## Decay curves by page type

| Page type | Half-life | Rationale |
|-----------|-----------|-----------|
| `concept` | 180 days | Core ideas are stable; they rarely become wrong, just incomplete |
| `topic` | 120 days | Overviews drift as the field evolves |
| `summary` | 90 days | Source summaries are fixed, but relevance fades |
| `insight` | 60 days | Cross-cutting observations are the most speculative |
| `entity` | 90 days | People change roles, projects end, technologies get replaced |
| `reference` | 60 days | URLs go dead, external resources move |
| `draft` | 30 days | Drafts that linger are probably abandoned |

**Half-life** = the number of days after which an unverified page drops one confidence level.

## Decay rules

### How decay works

1. Calculate `days_since_verified` = today − `verified` date (or `updated` if no `verified`).
2. Look up the half-life for the page's `type`.
3. Apply:

| Days since verified | Current confidence → Decayed confidence |
|--------------------|-----------------------------------------|
| < half-life | No change |
| ≥ half-life, < 2× half-life | `high` → `medium`, others unchanged |
| ≥ 2× half-life | `high` → `low`, `medium` → `low` |
| ≥ 3× half-life | All → `low`, page flagged as **stale** |

### What resets the clock (reinforcement)

These actions reset `verified` to today and may boost confidence:

| Action | Resets verified | Boosts confidence |
|--------|----------------|-------------------|
| `/wiki` reads the page and uses it in an answer | Yes | No |
| `/wiki-ingest` adds a new source that cites the same concept | Yes | Yes — if 2+ sources now support it, raise to `high` |
| `/wiki-audit` reviews and confirms the page is accurate | Yes | No |
| User manually edits the page | Yes | No |
| `/wiki-insights` references the page in a new insight | Yes | No |

### What does NOT reset the clock

- Being listed in an index file
- Being linked from another page (without being read)
- Existing in a Glob result

## When to apply decay

Decay is applied during:

1. **`/wiki-update`** — after rebuilding indexes, scan all pages and apply decay. Update `confidence` in frontmatter for any pages that have decayed. Log changes.

2. **`/wiki-audit`** — during the stale content check (Step 6), use decay curves to compute current effective confidence. Report pages whose confidence has decayed.

3. **`/wiki` queries** — when presenting results, note if a page's confidence has effectively decayed even if frontmatter hasn't been updated yet. Mention it: `[note: this page hasn't been verified in [N] days — confidence may be lower than stated]`.

## Decay is non-destructive

- Never delete pages due to decay
- Never remove content — only lower confidence
- Always preserve the original `verified` date so the user can see when it was last checked
- Decayed pages are still searchable and linkable
- The user can reinforce any page at any time by reading and confirming it

## Reporting format

When reporting decay during `/wiki-update` or `/wiki-audit`:

```
Retention decay applied:
  - [page] — confidence: high → medium (last verified 95 days ago, half-life 90)
  - [page] — confidence: medium → low (last verified 200 days ago, half-life 90)
  - [page] — flagged stale (last verified 300 days ago)
```

## Edge cases

- **No `verified` date:** Use `updated`, then `created`. If none exist, treat as stale immediately.
- **Superseded pages:** Do not apply decay — they're already marked as replaced. Their confidence is frozen at whatever it was when superseded.
- **Draft pages:** Apply decay aggressively (30-day half-life). Drafts older than 90 days should be flagged for deletion or promotion.
- **Pages with `visibility: private`:** Apply decay normally — privacy doesn't affect freshness.
