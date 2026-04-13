---
title: "[Insight Title]"
type: insight
created: "[YYYY-MM-DD]"
updated: "[YYYY-MM-DD]"
verified: "[YYYY-MM-DD]"
confidence: "[high/medium/low]"
visibility: "public"
sources:
  - "summaries/[source1].md"
  - "concepts/[concept1].md"
entities:
  - "entities/[entity-name].md"
tags:
  - "[pattern/contradiction/gap/connection]"
supersedes: ""
superseded_by: ""
---

# [Insight Title]

## Confidence: [high/medium/low]

**High** = directly supported by multiple sources
**Medium** = reasonable inference from partial evidence
**Low** = speculative, based on limited evidence

## Observation

[2-3 paragraph statement of the insight. What pattern, contradiction, gap, or connection did you identify? Be specific.]

## Evidence

[Show your reasoning. For each piece of evidence, cite the wiki page:]

1. [Source/concept A](../path/to/page.md) states: "[relevant claim or finding]"
2. [Source/concept B](../path/to/page.md) states: "[relevant claim or finding]"
3. Together, these suggest: [your synthesis]

[If any step involves inference beyond what sources state, mark it: `[speculative: reason]`]

## Implications

[What does this insight mean for the broader knowledge base? Does it suggest:]
- New questions to investigate?
- Existing pages that need updating?
- Concepts that should be linked but aren't?

## Uncertainty

[What could make this insight wrong? What assumptions does it rest on? What additional evidence would strengthen or weaken it?]

## Entities

- [Entity Name](../entities/entity-name.md) — [role in this insight]

## Related

- [Related insight or page](../path) — **extends** — [relationship]

Relationship types: `extends`, `contradicts`, `supersedes`, `depends-on`
