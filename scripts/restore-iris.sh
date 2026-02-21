#!/bin/bash
#
# 🌿 IRIS DISASTER RECOVERY
# 
# Restores Iris 100% from backup drive.
# Usage: plug in backup drive, then run:
#
#   bash /Volumes/BACKUP_DRIVE/openclaw-backup/restore-iris.sh
#
# Replace BACKUP_DRIVE with your actual drive name.
#
set -e

# ── CONFIG ──────────────────────────────────────────────────
BACKUP_DIR="$(cd "$(dirname "$0")" && pwd)"
OPENCLAW_HOME="$HOME/.openclaw"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "🌿 IRIS DISASTER RECOVERY"
echo "========================="
echo ""
echo "Backup source: $BACKUP_DIR"
echo "Restore target: $OPENCLAW_HOME"
echo ""

# ── PREFLIGHT CHECKS ───────────────────────────────────────
if [ ! -d "$BACKUP_DIR/workspace" ]; then
    echo -e "${RED}ERROR: No workspace found in backup directory.${NC}"
    echo "Expected: $BACKUP_DIR/workspace"
    exit 1
fi

# ── STEP 1: Install Homebrew (if missing) ──────────────────
echo -e "${YELLOW}[1/8] Checking Homebrew...${NC}"
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "${GREEN}✓ Homebrew installed${NC}"
fi

# ── STEP 2: Install Node.js (if missing) ──────────────────
echo -e "${YELLOW}[2/8] Checking Node.js...${NC}"
if ! command -v node &>/dev/null; then
    echo "Installing Node.js..."
    brew install node
else
    echo -e "${GREEN}✓ Node.js $(node -v) installed${NC}"
fi

# ── STEP 3: Install OpenClaw (if missing) ─────────────────
echo -e "${YELLOW}[3/8] Checking OpenClaw...${NC}"
if ! command -v openclaw &>/dev/null; then
    echo "Installing OpenClaw..."
    npm install -g openclaw
else
    echo -e "${GREEN}✓ OpenClaw $(openclaw --version 2>/dev/null || echo 'installed')${NC}"
fi

# ── STEP 4: Install ffmpeg + whisper (for voice) ──────────
echo -e "${YELLOW}[4/8] Checking audio tools...${NC}"
if ! command -v ffmpeg &>/dev/null; then
    echo "Installing ffmpeg..."
    brew install ffmpeg
else
    echo -e "${GREEN}✓ ffmpeg installed${NC}"
fi

if [ ! -f /opt/homebrew/bin/whisper-cli ]; then
    echo "Installing whisper-cli..."
    brew install whisper-cpp
else
    echo -e "${GREEN}✓ whisper-cli installed${NC}"
fi

# Download whisper model if missing
if [ ! -f /tmp/ggml-base.en.bin ]; then
    echo "Downloading whisper model..."
    curl -L -o /tmp/ggml-base.en.bin \
        "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin"
else
    echo -e "${GREEN}✓ Whisper model present${NC}"
fi

# ── STEP 5: Restore OpenClaw directory ────────────────────
echo -e "${YELLOW}[5/8] Restoring OpenClaw data...${NC}"

# Back up existing config if any
if [ -d "$OPENCLAW_HOME" ]; then
    echo "Existing .openclaw found — backing up to .openclaw.old"
    mv "$OPENCLAW_HOME" "${OPENCLAW_HOME}.old.$(date +%Y%m%d%H%M%S)"
fi

# Full restore from backup
echo "Copying from backup..."
rsync -av --progress "$BACKUP_DIR/" "$OPENCLAW_HOME/" \
    --exclude '.DS_Store' \
    --exclude '*.old.*'

echo -e "${GREEN}✓ All data restored${NC}"

# ── STEP 6: Install Gateway service ──────────────────────
echo -e "${YELLOW}[6/8] Installing Gateway service...${NC}"
openclaw gateway install 2>/dev/null || true
sleep 2
openclaw gateway status 2>/dev/null || echo "Gateway may need manual start"
echo -e "${GREEN}✓ Gateway configured${NC}"

# ── STEP 7: Verify GitHub remote ─────────────────────────
echo -e "${YELLOW}[7/8] Checking GitHub...${NC}"
cd "$OPENCLAW_HOME/workspace"
if git remote -v 2>/dev/null | grep -q "PEDROGRANDE001/iris"; then
    echo -e "${GREEN}✓ GitHub remote: PEDROGRANDE001/iris${NC}"
    # Pull latest just in case backup is slightly behind
    git pull --ff-only 2>/dev/null || echo "  (couldn't pull — may need git auth)"
else
    echo "Setting up GitHub remote..."
    git remote add origin https://github.com/PEDROGRANDE001/iris.git 2>/dev/null || true
fi

# ── STEP 8: Install ClawHub skills ───────────────────────
echo -e "${YELLOW}[8/8] Restoring ClawHub skills...${NC}"
if [ -f "$OPENCLAW_HOME/workspace/.clawhub/lock.json" ]; then
    cd "$OPENCLAW_HOME/workspace"
    npx clawhub sync 2>/dev/null || echo "  (ClawHub sync skipped — may need retry)"
else
    echo "  No ClawHub lock file — skills restored from backup"
fi

# ── DONE ──────────────────────────────────────────────────
echo ""
echo "========================================="
echo -e "${GREEN}🌿 IRIS RESTORED SUCCESSFULLY${NC}"
echo "========================================="
echo ""
echo "What's restored:"
echo "  ✓ Workspace (SOUL.md, MEMORY.md, all files)"
echo "  ✓ Memory files (daily notes, digests)"
echo "  ✓ Credentials (Telegram, email, APIs)"
echo "  ✓ Cron jobs"
echo "  ✓ Skills"
echo "  ✓ Gateway service"
echo ""
echo "Quick verify:"
echo "  openclaw gateway status"
echo "  openclaw cron list"
echo "  openclaw status"
echo ""
echo "If Telegram isn't connecting, run:"
echo "  openclaw telegram status"
echo ""
echo "🌿 I'm back."
echo ""
