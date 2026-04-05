---
name: concept-extraction
description: Skill for extracting atomic concepts from source material and creating well-structured concept pages
type: rigid
---

# Concept Extraction Skill

This skill governs how concepts are identified, defined, and written as wiki pages. Follow it exactly.

## What is an atomic concept?

An atomic concept is a single, well-defined idea that:
- Can be explained in 1-3 paragraphs
- Has a clear boundary (you can say what it is AND what it isn't)
- Is referenced by at least one source in the knowledge base
- Is useful as a building block for understanding larger topics

**Good concepts:** "Attention mechanism", "Backpropagation", "Tokenization", "Gradient descent"
**Bad concepts:** "Machine learning" (too broad for a concept page — that's a topic), "The thing from that paper" (too vague), "Section 3.2" (not a concept)

## Extraction procedure

### 1. Read the source carefully
- Identify terms that are defined, explained, or central to the argument
- Note the author's own definitions — prefer these over your training knowledge
- Mark terms that appear frequently but are not defined (these may already have concept pages)

### 2. For each candidate concept

**Check existence first:**
```
Grep for the concept name in knowledge-base/concepts/
Grep for the concept name in knowledge-base/index/concept-index.md
```

**If it exists:** Read the existing page. Add new information from this source:
- Add the new source to the `sources` frontmatter
- Add any new details to the Definition or Details section
- Add the new source to the Sources section at the bottom
- Do NOT overwrite the existing definition — append or refine

**If it's new:** Create using the concept template:

```markdown
---
title: [Concept Name]
type: concept
created: [today]
updated: [today]
sources:
  - raw/[source-file]
aliases: [other names for this concept]
related:
  - concepts/[related-concept].md
---

# [Concept Name]

## Definition

[1-2 paragraph definition derived from the source. Cite the source.]

## Details

[Additional context, nuance, or explanation. Cite sources for each claim.]

## Examples

[Concrete examples if available from the source. Mark if constructed by you: "[constructed example]"]

## Related Concepts

- [Related Concept 1](../concepts/related.md) — [brief note on relationship]

## Sources

- [Source Title](../raw/source-file) — [what this source says about the concept]
```

### 3. Quality check each concept page

Before finalizing, verify:
- [ ] The definition is clear enough for someone unfamiliar with the concept
- [ ] At least one source is cited
- [ ] The `sources` frontmatter matches the inline citations
- [ ] Related concepts are linked if they exist
- [ ] No information is presented that isn't in the cited sources (unless marked `[external knowledge]`)

## Concept naming rules

- Filename: `kebab-case.md` matching the concept name
- Title: Title Case in frontmatter
- Aliases: List common alternative names
- If two names are equally common, prefer the more descriptive one

## When NOT to extract a concept

- The term is used but never defined or explained → note it as a knowledge gap instead
- The concept is too broad to be atomic → it belongs in `topics/`
- The concept is too specific to be reusable → include it in the summary instead
- You cannot write a clear definition from the source material → put a stub in `drafts/`
