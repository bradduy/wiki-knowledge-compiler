---
name: entity-extraction
description: Skill for extracting structured entities from source material — people, projects, technologies, decisions — and building the knowledge graph
type: rigid
---

# Entity Extraction Skill

This skill governs how entities are identified, typed, and connected. Entities are the nodes of the knowledge graph. Follow it exactly.

## What is an entity?

An entity is a named, typed thing that exists in the real world and appears in the knowledge base. Unlike concepts (which are ideas), entities are concrete: a specific person, a specific project, a specific library.

**Good entities:** "Redis", "Sarah Chen", "Auth Migration Q1", "React 18", "Decision: switch to PostgreSQL"
**Bad entities:** "caching" (that's a concept), "the database" (too vague, which one?), "performance" (that's a topic)

## Entity types

| Type | Description | Examples |
|------|-------------|---------|
| `person` | A named individual | Sarah Chen, Andrej Karpathy |
| `project` | A named initiative or effort | Auth Migration, API Redesign |
| `library` | A software library or framework | React, PyTorch, Express |
| `technology` | A tool, platform, or system | Redis, PostgreSQL, Kubernetes |
| `decision` | A specific architectural or design decision | "Use Redis for session caching" |
| `organization` | A team, company, or group | Platform Team, Anthropic |
| `file` | A specific file or codebase artifact | `auth-middleware.ts`, `schema.sql` |

## Extraction procedure

### 1. Read the source and identify candidates

While reading, flag any named thing that:
- Is mentioned by name (not just by category)
- Has attributes described (what it does, who owns it, when it was created)
- Has relationships to other named things
- Appears in more than one place in the source

### 2. For each candidate entity

**Check existence first:**
```
Grep for the entity name in .data/entities/
```

**If it exists:** Read the existing page. Update it:
- Add the new source to `sources` frontmatter
- Add any new relationships discovered
- Add new attributes to the Attributes table
- Update confidence if new evidence strengthens or weakens it
- Do NOT overwrite existing description — append or refine

**If it's new:** Create using `templates/entity.md`:
- Set `entity_type` from the type table above
- Set `confidence` based on how clearly the source identifies it:
  - `high` — named, described, central to the source
  - `medium` — named and referenced but not the focus
  - `low` — mentioned in passing, inferred from context
- Extract all relationships visible in this source

### 3. Extract relationships

For each entity, identify its connections to:
- **Other entities** — who uses what, who owns what, what depends on what
- **Concepts** — what ideas does this entity implement or relate to
- **Decisions** — what was decided and why

Use typed relationships:

| Relationship | Meaning | Example |
|-------------|---------|---------|
| `uses` | A uses B | "Auth service **uses** Redis" |
| `used-by` | A is used by B (inverse of uses) | "Redis **used-by** Auth service" |
| `depends-on` | A cannot work without B | "API **depends-on** PostgreSQL" |
| `maintained-by` | A is maintained/owned by B | "Auth module **maintained-by** Sarah" |
| `owns` | A owns/is responsible for B | "Sarah **owns** Auth migration" |
| `created-by` | A was created by B | "Redis cache layer **created-by** Platform team" |
| `part-of` | A is a component of B | "Auth middleware **part-of** API gateway" |
| `replaces` | A replaces/supersedes B | "PostgreSQL **replaces** MySQL" |
| `contradicts` | A conflicts with B | "New policy **contradicts** old guideline" |
| `implements` | A implements concept B | "Redis cache **implements** caching strategy" |
| `relates-to` | General association | Fallback when no specific type fits |
| `defined-in` | A is defined/documented in B | "Cache config **defined-in** config.yaml" |

Every relationship must have a confidence level and at least one supporting source.

### 4. Quality check each entity

Before finalizing, verify:
- [ ] The entity has a clear, specific name (not generic)
- [ ] The entity type is correct
- [ ] At least one source is cited
- [ ] Relationships have types and confidence levels
- [ ] No duplicate entity exists under a different name (check aliases)
- [ ] Description is based on sources, not assumed

## Entity naming rules

- Filename: `kebab-case.md` matching the entity name
- Title: Original casing in frontmatter (e.g., "Redis", "Sarah Chen")
- Aliases: List common alternative names (e.g., aliases for "PostgreSQL": ["Postgres", "pg"])
- For decisions: prefix with "decision-" (e.g., `decision-switch-to-postgresql.md`)

## When NOT to extract an entity

- The thing is generic, not named → it might be a concept instead
- The thing is mentioned once in passing with no attributes → note it in the summary, skip entity
- The thing is too broad (e.g., "the internet") → not useful as a graph node
- You cannot clearly distinguish it from an existing entity → update the existing one instead

## Graph traversal support

Entities are designed to support graph traversal. When the `/wiki` command needs to answer "what's the impact of X?":

1. Find the entity for X in `.data/entities/`
2. Read its `relationships` to find directly connected entities
3. For each connected entity, read ITS relationships (one hop out)
4. Collect all connected pages (entities, concepts, topics) within 2 hops
5. Use this subgraph to synthesize the answer

This catches connections that keyword search misses.
