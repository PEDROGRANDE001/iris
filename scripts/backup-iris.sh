#!/bin/bash
#
# 🌿 IRIS BACKUP
#
# Backs up everything to external drive.
# Run manually or set as a cron job.
#
# Usage: bash backup-iris.sh /Volumes/YOUR_DRIVE_NAME
#
set -e

BACKUP_DEST="${1:-/Volumes/BACKUP/openclaw-backup}"
OPENCLAW_HOME="$HOME/.openclaw"

if [ ! -d "$OPENCLAW_HOME" ]; then
    echo "ERROR: No .openclaw directory found at $OPENCLAW_HOME"
    exit 1
fi

# Check if destination is writable
mkdir -p "$BACKUP_DEST" 2>/dev/null || {
    echo "ERROR: Can't write to $BACKUP_DEST"
    echo "Usage: bash backup-iris.sh /Volumes/YOUR_DRIVE_NAME"
    exit 1
}

echo "🌿 Backing up Iris..."
echo "   From: $OPENCLAW_HOME"
echo "   To:   $BACKUP_DEST"
echo ""

rsync -av --delete --progress \
    "$OPENCLAW_HOME/" "$BACKUP_DEST/" \
    --exclude '.DS_Store' \
    --exclude 'logs/' \
    --exclude 'browser/chrome-extension/' \
    --exclude 'node_modules/'

# Copy the restore script to the root of the backup
cp "$OPENCLAW_HOME/workspace/scripts/restore-iris.sh" "$BACKUP_DEST/restore-iris.sh" 2>/dev/null || true

echo ""
echo "✅ Backup complete: $(du -sh "$BACKUP_DEST" | cut -f1)"
echo "   Restore with: bash $BACKUP_DEST/restore-iris.sh"
echo ""
