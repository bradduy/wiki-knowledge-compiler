---
title: "[Entity Name]"
type: entity
entity_type: "[person/project/library/technology/decision/organization/file]"
created: "[YYYY-MM-DD]"
updated: "[YYYY-MM-DD]"
verified: "[YYYY-MM-DD]"
confidence: "[high/medium/low]"
sources:
  - "raw/[source-file]"
aliases:
  - "[alternative name]"
relationships:
  - target: "entities/[other-entity].md"
    type: "[uses/used-by/depends-on/maintained-by/owns/created-by/part-of/replaces/contradicts]"
    confidence: "[high/medium/low]"
  - target: "concepts/[concept].md"
    type: "[implements/relates-to/defined-in]"
    confidence: "[high/medium/low]"
supersedes: ""
superseded_by: ""
---

# [Entity Name]

**Type:** [person/project/library/technology/decision/organization/file]

## Description

[1-2 paragraph description. Who or what is this? What role does it play? Cite sources.]

## Attributes

| Attribute | Value | Source |
|-----------|-------|--------|
| [e.g. language] | [e.g. Go] | [source](../raw/source.md) |
| [e.g. status] | [e.g. active] | [source](../raw/source.md) |

## Relationships

- **uses** → [Other Entity](../entities/other.md) — [context]
- **maintained-by** → [Person](../entities/person.md) — [context]
- **implements** → [Concept](../concepts/concept.md) — [context]

Relationship types: `uses`, `used-by`, `depends-on`, `maintained-by`, `owns`, `created-by`, `part-of`, `replaces`, `contradicts`, `implements`, `relates-to`, `defined-in`

## Sources

- [Source Title](../raw/source-file) — [what this source says about the entity]
