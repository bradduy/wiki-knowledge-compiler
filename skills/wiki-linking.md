---
name: wiki-linking
description: Skill for creating and maintaining cross-links between wiki pages to build a connected knowledge graph
type: flexible
---

# Wiki Linking Skill

Cross-links are what turn a collection of files into a wiki. This skill governs how to create, maintain, and audit links between pages.

## Link format

Always use relative markdown links:
```markdown
[Display Text](../directory/filename.md)
```

Examples:
- From a topic page to a concept: `[Attention Mechanism](../concepts/attention-mechanism.md)`
- From a summary to its raw source: `[Original paper](../raw/vaswani-2017-attention.pdf)`
- From a concept to a related concept: `[Self-Attention](../concepts/self-attention.md)`

## When to link

### Always link
- Concept names mentioned in any page → link to their concept page
- Sources cited in any page → link to their summary (preferred) or raw file
- Topics referenced in narrative text → link to their topic page

### Link on first mention
- In a given page, link a concept/topic on its **first mention** only
- Do not link every occurrence — it clutters the text

### Don't link
- Common English words that happen to match a concept name in a different context
- Self-links (a page linking to itself)
- Links to pages that don't exist yet (use `[Concept Name] [no page yet]` instead)

## Link placement

### Frontmatter links
```yaml
sources:
  - raw/source-file.pdf
related:
  - concepts/related-concept.md
concepts:
  - concepts/concept1.md
```

### Inline links
```markdown
The [transformer architecture](../topics/transformer-architecture.md) relies on
[self-attention](../concepts/self-attention.md) to process sequences.
```

### Section-level links
```markdown
## Related Concepts
- [Self-Attention](../concepts/self-attention.md) — core mechanism
- [Multi-Head Attention](../concepts/multi-head-attention.md) — parallel attention

## Sources
- [Attention Is All You Need](../summaries/vaswani-2017-attention.md) — original paper
```

## Bidirectional linking

When you link page A → page B, check if page B should link back to page A.

- Concept → Related Concept: **always bidirectional**
- Topic → Concept: Topic links to concept; concept links back via "Related Topics" or "Appears in"
- Summary → Concept: Summary links to concept; concept lists summary in Sources
- Insight → Sources: Insight links to sources; no automatic backlink needed

## Link maintenance

When creating or updating any page:
1. Scan the text for concept, topic, and source names
2. Check if corresponding pages exist using Glob
3. Add links where they're missing
4. Verify existing links still resolve (no renamed/deleted targets)

## Link audit checklist

Use during `/wiki-health`:
- [ ] No broken links (target file exists)
- [ ] No orphan pages (every page has at least one incoming link)
- [ ] No self-links
- [ ] Key concepts are linked from topics that discuss them
- [ ] All summaries link to their raw source
- [ ] All concept pages list their sources
