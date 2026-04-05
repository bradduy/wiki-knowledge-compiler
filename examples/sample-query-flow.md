# Example: Querying the Wiki

This shows how to query the knowledge base and how write-back works.

## Scenario

You want to understand how attention mechanisms relate to memory in LLMs, and your wiki has several relevant sources.

## Step 1: Ask a question

```
/query-wiki How do attention mechanisms relate to memory systems in LLMs?
```

## Step 2: The librarian searches

The plugin:
1. Reads `master-index.md` to see what's available
2. Searches for "attention", "memory", "LLM" across all directories
3. Finds relevant pages:
   - `concepts/attention-mechanism.md`
   - `concepts/kv-cache.md`
   - `topics/transformer-architecture.md`
   - `summaries/vaswani-2017-attention.md`
   - `summaries/karpathy-llm-os.md`

## Step 3: The answer

```markdown
## Answer

Attention mechanisms serve as a form of **dynamic, context-dependent memory**
in LLMs. Specifically:

1. **Self-attention** ([Attention Mechanism](concepts/attention-mechanism.md))
   allows each token to "look back" at all previous tokens, functioning as a
   read-only memory over the current context.

2. **KV-cache** ([KV Cache](concepts/kv-cache.md)) is the physical implementation
   of this memory during inference — it stores the key-value pairs from previous
   tokens to avoid recomputation.

3. Karpathy frames this as the "RAM" of the LLM OS
   ([Summary: LLM OS](summaries/karpathy-llm-os.md)), where the context window
   is working memory and external retrieval is long-term storage.

[knowledge gap: the wiki does not yet cover explicit memory architectures like
MemoryBank or retrieval-augmented generation in depth]

### Sources consulted
- [Attention Mechanism](concepts/attention-mechanism.md) — core definition
- [KV Cache](concepts/kv-cache.md) — implementation detail
- [Transformer Architecture](topics/transformer-architecture.md) — architectural context
- [Summary: LLM OS](summaries/karpathy-llm-os.md) — memory metaphor

### Knowledge gaps
- No dedicated page for "explicit memory architectures" in LLMs
- RAG is mentioned but not fully covered

### Write-back
- Writing insight: insights/attention-as-memory.md (novel synthesis across 3+ sources)
- Creating draft stub: drafts/explicit-memory-architectures.md (knowledge gap)
```

## Step 4: What was written back

The plugin created `insights/attention-as-memory.md`:

```markdown
---
title: "Attention as Dynamic Memory"
type: insight
created: 2026-04-05
confidence: medium
sources:
  - summaries/vaswani-2017-attention.md
  - concepts/kv-cache.md
  - summaries/karpathy-llm-os.md
tags:
  - connection
---

# Attention as Dynamic Memory

## Confidence: medium

## Observation

Attention mechanisms in transformers function as a form of dynamic,
context-dependent memory...
```

## When write-back does NOT happen

```
/query-wiki What sources do we have about transformers?
```

Answer: A list of pages. No write-back needed — this is navigation, not synthesis.
