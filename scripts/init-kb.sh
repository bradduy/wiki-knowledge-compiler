#!/usr/bin/env bash
# Initialize a fresh knowledge-base directory structure.
# Usage: ./scripts/init-kb.sh [target-dir]
#
# This script is idempotent — safe to run multiple times.

set -euo pipefail

TARGET="${1:-knowledge-base}"

echo "Initializing knowledge base at: $TARGET"

dirs=(
  "$TARGET/raw"
  "$TARGET/wiki"
  "$TARGET/.data/index"
  "$TARGET/.data/summaries"
  "$TARGET/.data/concepts"
  "$TARGET/.data/topics"
  "$TARGET/.data/insights"
  "$TARGET/.data/entities"
  "$TARGET/.data/references"
  "$TARGET/.data/drafts"
)

for dir in "${dirs[@]}"; do
  mkdir -p "$dir"
  if [ ! -f "$dir/.gitkeep" ] && [ "$(ls -A "$dir" 2>/dev/null)" = "" ]; then
    touch "$dir/.gitkeep"
  fi
done

# Create .data/log.md if it doesn't exist
if [ ! -f "$TARGET/.data/log.md" ]; then
  mkdir -p "$TARGET/.data"
  cat > "$TARGET/.data/log.md" << 'EOF'
---
title: Knowledge Base Activity Log
type: log
---

# Activity Log

All structural changes to the knowledge base are logged here in reverse chronological order.

---
EOF
  echo "Created $TARGET/.data/log.md"
fi

# Create index files if they don't exist
for idx in master-index concept-index source-index; do
  if [ ! -f "$TARGET/.data/index/$idx.md" ]; then
    echo "---
title: ${idx//-/ }
type: index
updated: $(date +%Y-%m-%d)
---

# ${idx//-/ }

_(empty — run /update-index to populate)_" > "$TARGET/.data/index/$idx.md"
    echo "Created $TARGET/.data/index/$idx.md"
  fi
done

echo "Knowledge base initialized at: $TARGET"
echo "Directories: ${#dirs[@]} created/verified"
