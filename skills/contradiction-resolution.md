---
name: contradiction-resolution
description: Skill for detecting and resolving contradictions between wiki pages — compare evidence, propose resolution, link both sides
type: rigid
---

# Contradiction Resolution Skill

This skill governs how contradictions are detected, evaluated, and resolved. Follow it exactly.

## What is a contradiction?

A contradiction occurs when two wiki pages make **incompatible claims** about the same thing. Not every disagreement is a contradiction:

| Type | Is a contradiction? | Example |
|------|-------------------|---------|
| Incompatible facts | **Yes** | Page A: "Redis uses port 6379" vs Page B: "Redis uses port 6380" |
| Different scope | **No** | Page A: "Redis is fast for caching" vs Page B: "Redis is slow for complex queries" |
| Different time | **Maybe** | Page A (2023): "We use MySQL" vs Page B (2024): "We use PostgreSQL" — this is supersession, not contradiction |
| Different perspective | **No** | Page A: "Microservices improve scalability" vs Page B: "Microservices increase complexity" — both can be true |

## Detection procedure

### 1. Identify candidate pairs

Two pages might contradict each other if they:
- Share the same topic or entity references
- Define the same concept differently
- Make claims about the same entity with different values
- Have an existing `contradicts` relationship (verify it's still valid)

### 2. Compare claims

For each candidate pair:
1. Extract the specific claims from each page (look for factual statements, definitions, attribute values).
2. Check if the claims are **logically incompatible** — both cannot be true at the same time.
3. If they can both be true (different scope, perspective, or time), it's **not** a contradiction.

### 3. Score each side

When a genuine contradiction is found, evaluate each claim:

| Factor | Weight | How to assess |
|--------|--------|---------------|
| **Source recency** | High | Which claim comes from a more recent source? Check `created` and `updated` dates. |
| **Source authority** | High | Which source has higher `authority`? `primary` > `secondary` > `commentary`. |
| **Evidence count** | Medium | How many sources support each claim? Check the `sources` frontmatter. |
| **Confidence level** | Medium | What is the page's `confidence` rating? `high` > `medium` > `low`. |
| **Specificity** | Low | Which claim is more specific and detailed? Vague claims are weaker. |

### 4. Propose resolution

Based on the scoring:

**If one side clearly wins** (newer source + higher authority + more evidence):
- Recommend keeping the stronger claim as the primary
- Mark the weaker claim's page with `superseded_by` pointing to the stronger
- Mark the stronger claim's page with `supersedes` pointing to the weaker
- Add `[superseded: replaced by [link]]` in the weaker page's body

**If it's a close call** (mixed signals):
- Do NOT auto-resolve
- Add `contradicts` relationships to both pages' `related` fields
- Add `[uncertainty: contradicted by [link] — see both sources]` to both pages
- Report to the user with your analysis and let them decide

**If it's a time-based change** (not a real contradiction):
- Treat as supersession, not contradiction
- The newer claim supersedes the older one
- Link with `supersedes`/`superseded_by` instead of `contradicts`

## Resolution actions

When resolving a contradiction:

1. **Update both pages' frontmatter:**
   ```yaml
   related:
     - page: "concepts/other-claim.md"
       type: "contradicts"  # or "supersedes"
   ```

2. **Add inline notation in both pages:**
   ```markdown
   [contradiction: This claim conflicts with [Other Page](path). See resolution below.]
   ```
   or
   ```markdown
   [superseded: This claim has been replaced by [Newer Page](path).]
   ```

3. **Update confidence:**
   - Lower the `confidence` of the weaker claim (e.g., `high` → `medium`)
   - Do NOT raise the confidence of the stronger claim unless new evidence supports it

4. **Log the resolution:**
   ```
   ## [DATE] Contradiction resolved
   - Pages: [page A] vs [page B]
   - Topic: [what they disagree about]
   - Resolution: [which was kept and why, or "flagged for user review"]
   ```

## When NOT to resolve

- The user has explicitly said both claims are valid (different contexts)
- You cannot determine which claim is stronger — flag it and move on
- The contradiction is between a wiki page and your training knowledge — the wiki page wins; never override wiki content with external knowledge
- The pages are in `drafts/` — contradictions in drafts are expected

## Quality check

After resolving:
- [ ] Both pages have `contradicts` or `supersedes` in their `related` field
- [ ] Inline markers are present in both pages
- [ ] Confidence levels are adjusted appropriately
- [ ] The resolution is logged
- [ ] No information was deleted — only marked and linked
