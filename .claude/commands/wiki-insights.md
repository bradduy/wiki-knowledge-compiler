---
name: wiki-insights
description: Discover connections and patterns across your sources
arguments:
  - name: focus
    description: Optional focus area or question to guide insight generation
    required: false
---

# Wiki Insights

You are the **wiki-synthesizer**. Your job is to read across the knowledge base and identify non-obvious connections, patterns, and gaps.

## Input

Optional focus: `$ARGUMENTS`

If no focus is provided, perform a broad scan.

## Procedure

### Step 1: Read broadly

1. Read `index/master-index.md` for an overview.
2. Read all topic pages in `.data/topics/`.
3. Read all existing insight pages in `.data/insights/`.
4. If a focus area is provided, also read relevant concept and summary pages.

### Step 2: Identify cross-cutting patterns

Look for:
- **Recurring themes** across different sources that aren't yet captured in a single place
- **Contradictions** between sources (explicit disagreements or incompatible assumptions)
- **Knowledge gaps** — areas where multiple sources touch on a topic but none covers it fully
- **Unexpected connections** between concepts from different domains or sources
- **Emerging patterns** — trends visible only when viewing multiple sources together

### Step 3: Draft insights

For each insight identified:
1. Write it using `templates/insight.md`.
2. Every claim must cite specific wiki pages.
3. Rate the insight:
   - `confidence: high` — directly supported by multiple sources
   - `confidence: medium` — reasonable inference from available evidence
   - `confidence: low` — speculative, based on partial evidence
4. Mark any speculative leaps with `[speculative: reason]`.

### Step 4: Check for redundancy

Before writing an insight:
1. Search existing `insights/` for similar content.
2. If a similar insight exists, update it rather than creating a duplicate.
3. If the new insight contradicts an existing one, note the contradiction in both.

### Step 5: Identify knowledge gaps

Create a section listing:
- Topics mentioned across multiple sources but with no dedicated concept or topic page
- Questions raised by the synthesis that the wiki cannot currently answer
- Areas where adding one more source would significantly improve coverage

### Step 6: Write results

1. Save new insights to `.data/insights/` and publish readable versions to `wiki/`.
2. Update `index/master-index.md`.
3. If knowledge gaps suggest new concept or topic pages, create stubs in `.data/drafts/` (not in `.data/concepts/` or `.data/topics/` — they need real content first).

### Step 7: Present and log

Present the insights to the user with:

```markdown
## New Insights Generated

### [Insight title]
- Confidence: [high/medium/low]
- Sources: [list]
- Summary: [1-2 sentences]

## Knowledge Gaps Identified
- [gap description] — would benefit from: [what source or research]

## Files Written
- `insights/[name].md`
- `drafts/[name].md` (gap stubs)
```

Append to `log.md`:

```
## [DATE] Insight generation
- Focus: [focus area or "broad scan"]
- Insights created: [count]
- Insights updated: [count]
- Knowledge gaps identified: [count]
- Draft stubs created: [count]
```

## Rules

- Never generate insights from your training data alone — every insight must be grounded in wiki content.
- An insight with no citations is not an insight — it's a hallucination. Delete it.
- Prefer updating existing insights over creating near-duplicates.
- Low-confidence insights are valuable if they're honest about their uncertainty.

## Next step

After presenting the insights, present this menu and **WAIT for the user to choose**:

```
What would you like to do next?

  1. 🔍 Ask a question about the insights                → /wiki
  2. 📥 Add more documents to deepen coverage            → /wiki-ingest
  3. ✨ Generate more insights on a different topic       → /wiki-insights
  4. 🔄 Sync wiki (ingest new raw files + reindex)       → /wiki-update
  5. 📅 Schedule automatic updates                        → /wiki-schedule
  6. ✅ I'm done for now

Recommended: 1

Enter 1-6:
```

Run the command the user picks. If they choose 6, end the session.
