# Example: Ingesting a Source

This shows a typical workflow for adding a new source to the knowledge base.

## Scenario

You have Karpathy's "LLM OS" blog post saved as a markdown file and want to add it to your wiki.

## Step 1: Run the ingest command

```
/wiki-ingest ~/Downloads/karpathy-llm-os.md
```

## Step 2: What happens

The plugin will:

1. **Copy the file** to `knowledge-base/raw/karpathy-llm-os.md` (immutable copy)

2. **Create a summary** at `knowledge-base/summaries/karpathy-llm-os.md`:
   ```markdown
   ---
   title: "Summary: LLM OS"
   type: summary
   created: 2026-04-05
   source: raw/karpathy-llm-os.md
   author: Andrej Karpathy
   ---

   # Summary: LLM OS

   **Source:** [LLM OS](../raw/karpathy-llm-os.md)

   ## TL;DR
   Karpathy argues that LLMs are evolving into a new kind of operating system,
   where the LLM serves as the CPU and various tools serve as peripherals...

   ## Key Takeaways
   1. LLMs as a new computing paradigm, not just text generators
   2. Tool use as the "peripheral bus" of the LLM OS
   3. Memory systems as the "RAM/disk" equivalent
   ```

3. **Extract concepts** such as:
   - `knowledge-base/concepts/llm-os.md` — the LLM OS metaphor
   - `knowledge-base/concepts/tool-use.md` — LLMs using external tools
   - `knowledge-base/concepts/retrieval-augmented-generation.md` — if discussed

4. **Update or create topic page**: `knowledge-base/topics/llm-architecture.md`

5. **Update indexes**: source-index, concept-index, master-index

6. **Log the ingestion** in `log.md`

## Step 3: Review the output

The plugin shows you:
```
Ingestion complete: karpathy-llm-os.md

Files created:
  - raw/karpathy-llm-os.md (source stored)
  - summaries/karpathy-llm-os.md (summary)
  - concepts/llm-os.md (new concept)
  - concepts/tool-use.md (new concept)

Files updated:
  - topics/llm-architecture.md (added source + concepts)
  - index/source-index.md
  - index/concept-index.md
  - index/master-index.md
  - log.md

Items for review:
  - concepts/retrieval-augmented-generation.md — already existed, added
    new source citation from this paper
```

## Error case: Duplicate source

If you try to ingest the same file again:
```
/wiki-ingest ~/Downloads/karpathy-llm-os.md
```

The plugin responds:
```
A source with a similar name already exists: raw/karpathy-llm-os.md

Content comparison: files appear identical.

Options:
1. Skip ingestion (source already in wiki)
2. Re-ingest and update summaries/concepts

Choose [1/2]:
```
