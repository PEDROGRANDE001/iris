#!/bin/bash
set -euo pipefail
WORKSPACE="${OPENCLAW_WORKSPACE:-$HOME/.openclaw/workspace}"
MEMORY_DIR="$WORKSPACE/memory"
DISTILL_DIR="$MEMORY_DIR/distill"
mkdir -p "$DISTILL_DIR"

if [[ "$(uname)" == "Darwin" ]]; then
  YESTERDAY=$(date -v-1d +%Y-%m-%d)
else
  YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)
fi

JOURNAL="$MEMORY_DIR/journal/$YESTERDAY.md"
DISTILL_OUT="$DISTILL_DIR/$YESTERDAY.md"

if [[ ! -f "$JOURNAL" ]]; then exit 0; fi
if [[ -f "$DISTILL_OUT" ]]; then exit 0; fi

echo "# Distill: $YESTERDAY" > "$DISTILL_OUT"
echo "" >> "$DISTILL_OUT"

echo "## Key Decisions & Rules" >> "$DISTILL_OUT"
grep -iE "(PERMANENT|NEVER |ALWAYS |RULE|decision|established)" "$JOURNAL" | head -20 >> "$DISTILL_OUT" 2>/dev/null || true

echo "" >> "$DISTILL_OUT"
echo "## Completed" >> "$DISTILL_OUT"
grep -iE "(created|built|deployed|emailed|sent |set up|installed|configured|confirmed|done|added)" "$JOURNAL" | head -30 >> "$DISTILL_OUT" 2>/dev/null || true

echo "" >> "$DISTILL_OUT"
echo "## Blockers & Next" >> "$DISTILL_OUT"
grep -iE "(blocked|waiting|needs|next:|TODO|pending|overdue)" "$JOURNAL" | head -15 >> "$DISTILL_OUT" 2>/dev/null || true

echo "Distilled $YESTERDAY -> $DISTILL_OUT"
