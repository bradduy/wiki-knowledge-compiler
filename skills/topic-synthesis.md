---
name: topic-synthesis
description: Skill for creating and maintaining topic pages that organize related concepts and sources into coherent narratives
type: flexible
---

# Topic Synthesis Skill

Topic pages are the organizational backbone of the wiki. They group related concepts and sources into a coherent narrative about a broader area.

## What is a topic page?

A topic page:
- Covers a broad area that spans multiple concepts and sources
- Provides narrative context for why concepts relate to each other
- Links to concept pages for detailed definitions
- Links to summaries for source-level detail
- Is a reading guide, not an encyclopedia article

**Good topics:** "Transformer Architecture", "Reinforcement Learning Fundamentals", "Scaling Laws for LLMs"
**Bad topics:** "Attention" (too narrow — that's a concept), "AI" (too broad), "Papers I Read in January" (not topical)

## Creating a topic page

Use the topic template:

```markdown
---
title: [Topic Name]
type: topic
created: [today]
updated: [today]
sources:
  - raw/[source1]
  - raw/[source2]
concepts:
  - concepts/[concept1].md
  - concepts/[concept2].md
status: [draft/active/mature]
---

# [Topic Name]

## Overview

[2-3 paragraph overview of this topic area. What is it? Why does it matter?
Cite sources for factual claims.]

## Key Concepts

- **[Concept 1](../concepts/concept1.md)** — [one-line summary of relevance to this topic]
- **[Concept 2](../concepts/concept2.md)** — [one-line summary]

## How It Works / Core Ideas

[Narrative explanation of the topic, linking to concepts and sources.
This is the "reading guide" section — help the reader understand
how the pieces fit together.]

## Current State / Open Questions

[What's known, what's debated, what's unknown.
Use uncertainty markers: [uncertainty: ...] where appropriate.]

## Sources

- [Source 1](../summaries/source1.md) — [what it contributes to this topic]
- [Source 2](../summaries/source2.md) — [what it contributes]

## Related Topics

- [Related Topic](../topics/related.md) — [relationship]
```

## Updating an existing topic page

When new sources or concepts are added that relate to an existing topic:

1. Read the existing topic page in full
2. Determine what new information the source adds
3. Update the relevant sections:
   - Add new sources to the frontmatter and Sources section
   - Add new concepts to Key Concepts
   - Extend the narrative in "How It Works" if warranted
   - Update "Current State" if the new source changes the picture
4. Update the `updated` date
5. Do NOT rewrite the entire page — add to it

## When to create vs. update

- If a new source covers a topic that already has a page: **update**
- If a new source introduces a genuinely new area: **create**
- If unsure: **don't create**. A topic with only one source is usually not worth a dedicated page yet. Instead, note it in the summary and let topics emerge naturally.

## Topic status

- `draft` — Has fewer than 2 sources and the narrative is thin
- `active` — Has 2+ sources, a clear narrative, and linked concepts
- `mature` — Comprehensive coverage, well-linked, regularly reviewed

Promote topics as they grow. Don't start at `mature`.
