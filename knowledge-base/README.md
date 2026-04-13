# Knowledge Base

This is your local-first LLM Wiki. All knowledge is stored as plain markdown with YAML frontmatter.

## Directory Structure

| Directory | Purpose | Mutability |
|-----------|---------|------------|
| `raw/` | Original source documents | **Immutable** — never modify |
| `concepts/` | Atomic concept definitions | Derived — updated by ingestion |
| `topics/` | Broader topic overviews grouping concepts | Derived — updated by ingestion |
| `summaries/` | Per-source summaries with provenance | Derived — one per raw source |
| `insights/` | Cross-cutting observations and synthesis | Derived — generated from analysis |
| `drafts/` | Work-in-progress pages not yet promoted | Temporary — promote or delete |
| `references/` | External URL/resource stubs | Reference — added during ingestion |
| `.data/entities/` | Knowledge graph — people, projects, technologies | Derived — updated by ingestion |
| `.data/index/` | Master index, concept index, source index | Auto-generated — rebuilt by `/wiki-update` |
| `.data/log.md` | Append-only activity log | Append-only |

## Rules

1. **Never modify `raw/`.** It is the source of truth.
2. **Every derived page must cite its sources.** No orphaned claims.
3. **Mark uncertainty explicitly.** Use `[uncertainty: reason]` inline.
4. **Use templates.** All new pages follow templates in `../templates/`.
5. **Update indexes after changes.** Run `/wiki-update` periodically.
