---
name: crystallization
description: Skill for distilling completed research chains into structured wiki pages — explorations become first-class knowledge
type: flexible
---

# Crystallization Skill

When a `/wiki` query synthesizes 3+ sources to answer a question, the result is often more valuable than any single page in the wiki. Crystallization captures that synthesis as a permanent wiki page, so the work compounds instead of evaporating with the conversation.

## When to crystallize

Crystallize when ALL of these are true:

1. The answer drew from **3 or more** distinct wiki pages (concepts, summaries, topics, or entities)
2. The synthesis is **novel** — it connects ideas that weren't already connected in an existing insight or topic page
3. The answer would be **useful again** — it's not too narrow or too conversation-specific

Do NOT crystallize:
- Simple lookups ("what is X?" answered by one page)
- Navigation queries ("what pages do we have about X?")
- Debugging/troubleshooting for the plugin itself
- Answers that just restate existing insights

## Crystallization procedure

### 1. Recognize the opportunity

After constructing a `/wiki` answer, check:
- How many pages were consulted? (need 3+)
- Does an existing insight or topic already capture this synthesis?
- Would someone else (or future you) ask this same question?

If yes to first and third, and no to second → crystallize.

### 2. Create the digest page

Write to `.data/insights/` using `templates/insight.md` with these specifics:

**Frontmatter:**
```yaml
title: "Digest: [short description of the question/finding]"
type: insight
created: "[today]"
updated: "[today]"
verified: "[today]"
confidence: "[based on source quality]"
visibility: "public"
sources:
  - "[every page consulted]"
entities:
  - "[relevant entities]"
tags:
  - "crystallization"
  - "[pattern/connection/gap as appropriate]"
supersedes: ""
superseded_by: ""
```

**Body structure:**

```markdown
# Digest: [Title]

## Question

[The original question or research thread that prompted this]

## Answer

[The synthesized answer, with inline citations to every source used]

## Sources Consulted

| Page | Type | Relevance |
|------|------|-----------|
| [Page 1](path) | concept | [what it contributed] |
| [Page 2](path) | summary | [what it contributed] |
| [Page 3](path) | entity | [what it contributed] |

## Key Connections Discovered

- [Connection 1] — [page A] + [page B] together reveal [insight]
- [Connection 2] — ...

## Lessons

[What did this synthesis teach us that individual pages don't capture?]
- [Lesson 1]
- [Lesson 2]

## Open Questions

[What couldn't be answered? What would make this stronger?]
- [Gap 1] — would benefit from: [what source or research]
```

### 3. Publish to wiki/

Create a readable version in `wiki/` with the same filename. This is what the user sees in Obsidian.

### 4. Update connections

- Add the digest to `.data/index/master-index.md`
- Link the digest from each source page it references (add to their `related` fields if appropriate)
- If the digest reveals a new entity connection, update the entity page

### 5. Log

Append to `.data/log.md`:
```
## [DATE] Crystallization: [title]
- Question: [the question]
- Sources synthesized: [count]
- Pages consulted: [list]
- Key finding: [one sentence]
```

## Quality bar

A crystallized digest must meet ALL of:
- [ ] Answers a specific question or research thread
- [ ] Cites 3+ sources with inline links
- [ ] The synthesis is not already captured elsewhere
- [ ] Tagged with `crystallization` in frontmatter
- [ ] Sources Consulted table is complete
- [ ] At least one Key Connection that doesn't exist in any individual source
- [ ] Open Questions section identifies gaps (even if empty: "None identified")

## How crystallization compounds

Over time, digest pages become sources themselves:
- A future `/wiki` query might consult a digest alongside original sources
- `/wiki-insights` can identify patterns across digests
- Digests that get reinforced (re-read, cited) have their confidence maintained via retention decay
- Digests that are never accessed again naturally fade via retention decay — this is correct behavior; not every synthesis stays relevant
