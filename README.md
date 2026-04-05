# wiki-knowledge-compiler

A local-first LLM Wiki / Knowledge Compiler plugin for Claude Code.

Inspired by [Karpathy's "LLM Wiki" concept](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f): raw sources are immutable, the wiki is derived knowledge, and useful outputs are always written back.

## What it does

**wiki-knowledge-compiler** turns Claude Code into an AI-powered knowledge management system that:

- **Ingests** raw sources (PDFs, markdown, notes, URL stubs) into an immutable archive
- **Extracts** atomic concepts, creates summaries, and builds topic pages — all with provenance
- **Queries** the knowledge base with citations and writes back reusable answers
- **Maintains** structural health: detects orphans, duplicates, stale pages, and broken links
- **Synthesizes** cross-cutting insights with explicit confidence ratings and uncertainty markers

Everything is plain markdown with YAML frontmatter. No databases, no cloud services, no proprietary formats.

## Install

### Option 1: Clone into your project

```bash
git clone https://github.com/bradduy/wiki-knowledge-compiler.git
cd wiki-knowledge-compiler
```

Claude Code will automatically detect the `CLAUDE.md` and `.claude/` configuration.

### Option 2: Add to an existing repo

Copy the plugin files into your project:

```bash
cp -r wiki-knowledge-compiler/.claude/ your-project/.claude/
cp -r wiki-knowledge-compiler/{agents,skills,templates} your-project/
cp wiki-knowledge-compiler/CLAUDE.md your-project/CLAUDE.md
bash wiki-knowledge-compiler/scripts/init-kb.sh your-project/knowledge-base
```

## Commands

| Command | Description |
|---------|-------------|
| `/setup-wiki` | **Start here.** Interactive setup — choose project size, configure search backend |
| `/ingest-source <path-or-url>` | Add a raw source and extract knowledge from it |
| `/query-wiki <question>` | Search the wiki, answer with citations, write back if useful |
| `/update-index` | Rebuild all knowledge base indexes from the file system |
| `/health-check` | Audit for orphans, duplicates, stale pages, weak links |
| `/generate-insights [focus]` | Synthesize new insights from existing knowledge |

## Knowledge Base Structure

```
knowledge-base/
  raw/           # Immutable source documents
  concepts/      # Atomic concept pages (one per file)
  topics/        # Broader topic overviews
  summaries/     # Per-source summaries with provenance
  insights/      # Cross-cutting observations
  index/         # Auto-generated indexes
  drafts/        # Work-in-progress pages
  references/    # External URL/resource stubs
  log.md         # Append-only activity log
```

## Usage Examples

### Ingest a paper

```
/ingest-source ~/papers/vaswani-2017-attention-is-all-you-need.pdf
```

Creates: raw copy, summary, concept pages (attention, self-attention, multi-head attention, etc.), topic updates, index updates, log entry.

### Ask a question

```
/query-wiki How does self-attention differ from cross-attention?
```

Searches the wiki, answers with citations to specific pages, identifies knowledge gaps, and writes back the synthesis as an insight if it's novel.

### Check wiki health

```
/health-check
```

Reports: 2 orphan pages, 1 suspected duplicate (attention.md vs attention-mechanism.md), 3 summaries with broken source links. Offers to auto-fix safe issues.

### Generate insights

```
/generate-insights scaling laws
```

Reads across all sources related to scaling, identifies cross-cutting patterns, generates insight pages with confidence ratings.

## Architecture

### Agents

| Agent | Role |
|-------|------|
| `wiki-ingestor` | Processes raw sources into structured wiki content |
| `wiki-librarian` | Searches, answers questions, decides write-backs |
| `wiki-synthesizer` | Generates cross-cutting insights and finds gaps |
| `wiki-auditor` | Structural health checks and link verification |

### Skills

| Skill | Purpose |
|-------|---------|
| `source-ingestion` | Rules for storing and deduplicating sources |
| `concept-extraction` | Rules for identifying and writing atomic concepts |
| `topic-synthesis` | Rules for creating and maintaining topic pages |
| `wiki-linking` | Rules for cross-linking between pages |
| `wiki-health-check` | Full audit checklist |
| `write-back-discipline` | When and how to persist outputs to the wiki |
| `search-strategy` | Search tier selection based on project size and backend |

### Non-negotiable Rules

1. `raw/` is immutable — never modified after ingestion
2. Every derived page cites its sources
3. Uncertainty is always marked explicitly: `[uncertainty: reason]`
4. Useful outputs are written back — conversation is ephemeral, the wiki is persistent
5. No hallucinated citations — if it's not in a source, don't cite it

## Search Tiers

The plugin adapts its search strategy based on your project size. Run `/setup-wiki` to configure.

| Tier | Project Size | Backend | How it works |
|------|-------------|---------|--------------|
| **Small** | <100 pages | Grep + index files | Built-in, no setup. Keyword search across markdown files. |
| **Medium** | 100–500 pages | [qmd](https://github.com/tobi/qmd) CLI | Hybrid BM25/vector search, all on-device. Shell out to `qmd search`. |
| **Large** | 500+ pages | qmd MCP server | Native tool integration with LLM re-ranking. Best quality, lowest latency. |
| **Custom** | Any | `scripts/search.sh` | Bring your own search script. |

### Installing qmd (for medium/large projects)

```bash
# macOS
brew install tobi/tap/qmd

# or build from source
git clone https://github.com/tobi/qmd && cd qmd && make install
```

For MCP mode, add to your Claude Code config:
```json
{
  "mcpServers": {
    "qmd": {
      "command": "qmd",
      "args": ["mcp", "--root", "knowledge-base/"]
    }
  }
}
```

The plugin **always falls back gracefully**: qmd MCP → qmd CLI → Grep. Index files remain human-readable navigation regardless of backend.

## Limitations (v0.1)

- **No PDF text extraction.** PDFs are stored in `raw/` but you need to paste or provide markdown content for ingestion. Claude Code can read PDFs directly, but complex layouts may not extract perfectly.
- **Single-user.** No conflict resolution for concurrent edits.
- **No version history.** Relies on git for page history. Run `git init` in your knowledge-base if you want versioning.

## Future Upgrade Path

### Packaging for Marketplace

```
# Future marketplace structure
marketplace/
  plugins/
    wiki-knowledge-compiler/
      plugin.json      # Already exists
      CLAUDE.md        # Already exists
      .claude/         # Commands and hooks
      agents/
      skills/
      templates/
```

The `plugin.json` manifest is already structured for marketplace discovery.

### Paper-Writing Support

Future versions may add:
- `drafts/` → `papers/` promotion workflow
- Citation management (BibTeX generation from wiki sources)
- Outline generation from topic pages
- Literature review synthesis from summaries

## Contributing

This plugin follows Claude Code plugin conventions. To add a new command:

1. Create a `.md` file in `.claude/commands/`
2. Add frontmatter with `name`, `description`, and `arguments`
3. Write the command prompt following the existing command structure
4. Add the command to `plugin.json`
5. Test with Claude Code

## License

MIT
