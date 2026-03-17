#!/bin/bash
set -euo pipefail
WORKSPACE="${OPENCLAW_WORKSPACE:-$HOME/.openclaw/workspace}"
MEMORY_DIR="$WORKSPACE/memory"
ALERTS=""

if [[ ! -f "$WORKSPACE/MEMORY.md" ]]; then
  ALERTS+="CRITICAL: MEMORY.md is MISSING\n"
elif [[ $(wc -c < "$WORKSPACE/MEMORY.md") -lt 100 ]]; then
  ALERTS+="WARNING: MEMORY.md is suspiciously small\n"
fi

for f in infrastructure.md contacts.md projects.md; do
  if [[ ! -f "$MEMORY_DIR/facts/$f" ]]; then
    ALERTS+="WARNING: memory/facts/$f is MISSING\n"
  fi
done

if [[ -f "$WORKSPACE/MEMORY.md" ]]; then
  SIZE=$(wc -c < "$WORKSPACE/MEMORY.md")
  if [[ "$SIZE" -gt 4096 ]]; then
    ALERTS+="NOTE: MEMORY.md is ${SIZE} bytes (consider trimming).\n"
  fi
fi

for f in AGENTS.md HEARTBEAT.md SOUL.md; do
  if [[ ! -f "$WORKSPACE/$f" ]]; then
    ALERTS+="WARNING: $f is MISSING from workspace root\n"
  fi
done

if [[ -n "$ALERTS" ]]; then
  echo -e "MEMORY INTEGRITY ISSUES:\n$ALERTS"
  exit 1
else
  echo "MEMORY_OK"
  exit 0
fi
