---
title: Wiki Knowledge Compiler Configuration
type: config
created: 2026-04-05
---

# Wiki Configuration

## Project Size

<!-- Set this after running /setup-wiki. Determines search strategy. -->

size: small

<!--
  small  = <100 pages   → index files + Grep (built-in, no setup)
  medium = 100-500 pages → qmd CLI recommended (hybrid BM25/vector search)
  large  = 500+ pages    → qmd MCP server recommended (native tool integration)
-->

## Search Backend

backend: grep

<!--
  grep    = Built-in Grep/Glob + index files. Default for small projects.
  qmd-cli = qmd CLI search (shell out). Install: https://github.com/tobi/qmd
  qmd-mcp = qmd MCP server (native tool). Install: https://github.com/tobi/qmd
  custom  = User-provided search script at scripts/search.sh
-->

## Search Paths

search_root: knowledge-base
search_dirs:
  - concepts
  - topics
  - summaries
  - insights
  - references

## qmd Configuration (if applicable)

<!-- Uncomment and configure when using qmd-cli or qmd-mcp -->
<!-- qmd_path: /usr/local/bin/qmd -->
<!-- qmd_index_path: .wiki-search-index -->
<!-- qmd_rerank: true -->
