---
name: write-back-discipline
description: Skill governing when and how to persist useful outputs back into the knowledge base instead of leaving them only in conversation
type: rigid
---

# Write-Back Discipline Skill

The cardinal rule of this knowledge system: **useful outputs must be written back.** Conversation is ephemeral. The knowledge base is persistent. If you generate something reusable, it belongs in the wiki.

## The write-back decision

After generating any substantive output (answer, summary, analysis, insight), evaluate:

| Question | If Yes → |
|----------|----------|
| Does this synthesize multiple wiki sources in a new way? | Write to `insights/` |
| Does this summarize a source not yet summarized? | Write to `summaries/` |
| Does this define a concept not yet in the wiki? | Write to `concepts/` |
| Does this provide a broad overview of a topic area? | Write to `topics/` |
| Is this a work-in-progress that needs refinement? | Write to `drafts/` |
| Is this trivial, already covered, or too conversation-specific? | **Do not write back** |

## Write-back procedure

1. **Choose the target directory** based on the table above.
2. **Check for duplicates** — search the target directory and indexes.
3. **Use the correct template** from `templates/`.
4. **Include full provenance** — cite every source used.
5. **Mark uncertainty** — any speculative content must be flagged.
6. **Update indexes** — add the new page to the relevant index.
7. **Log the action** — append to `log.md`.

## What "useful" means

**Write back:**
- A question was answered by combining 3+ sources → the synthesis is an insight
- A concept was explained that has no concept page → create the concept page
- A comparison was made between approaches → write an insight or extend a topic
- A knowledge gap was identified → write a draft stub noting the gap

**Do not write back:**
- User asked "what's in the wiki about X?" and you listed pages → that's navigation, not knowledge
- User asked a yes/no question and you answered → too narrow to be a page
- The answer just restates a single existing page → already captured
- The output is debugging/troubleshooting for the plugin itself → not wiki content

## Quality bar for write-backs

A write-back must meet ALL of these:
- [ ] Has a clear, descriptive title
- [ ] Has complete YAML frontmatter
- [ ] Cites at least one source
- [ ] Contains no hallucinated citations
- [ ] Contains no unattributed claims presented as facts
- [ ] Uses uncertainty markers where appropriate
- [ ] Follows the appropriate template structure

If you cannot meet all criteria, write to `drafts/` instead with a note about what's missing.

## The "done" test

A task is not done until:
1. The user's question is answered (in conversation)
2. Any reusable output is written to the wiki (write-back)
3. Indexes are updated (if pages were created/modified)
4. The log is updated (if structural changes were made)

Answering in conversation without writing back when write-back is warranted = **incomplete work**.
