#!/bin/bash
set -euo pipefail
WORKSPACE="${OPENCLAW_WORKSPACE:-$HOME/.openclaw/workspace}"
MEMORY_DIR="$WORKSPACE/memory"
CHECKPOINT_DIR="$MEMORY_DIR/checkpoints"
mkdir -p "$CHECKPOINT_DIR"

TIMESTAMP=$(date +%Y-%m-%d_%H%M)
LATEST="$CHECKPOINT_DIR/latest.md"
TIMESTAMPED="$CHECKPOINT_DIR/$TIMESTAMP.md"

{
  echo "# Memory Checkpoint: $TIMESTAMP"
  echo ""
  echo "## MEMORY.md (hot)"
  cat "$WORKSPACE/MEMORY.md" 2>/dev/null || echo "(missing)"
  echo ""
  echo "## Facts (warm)"
  for f in "$MEMORY_DIR/facts/"*.md; do
    if [[ -f "$f" ]]; then
      echo "### $(basename "$f")"
      cat "$f"
      echo ""
    fi
  done
} > "$LATEST"

cp "$LATEST" "$TIMESTAMPED"
ls -t "$CHECKPOINT_DIR"/*.md 2>/dev/null | grep -v latest.md | tail -n +11 | xargs rm -f 2>/dev/null || true
echo "Checkpoint saved: $TIMESTAMPED"
