# 🔧 Iris Reinstall Guide

If you ever need to reinstall OpenClaw and restore Iris from scratch, here's everything you need.

---

## Where Everything Lives

### On Your Mac Mini

| What | Path |
|------|------|
| **OpenClaw config** | `~/.openclaw/openclaw.json` |
| **Iris workspace** (all files, memory, projects) | `~/.openclaw/workspace/` |
| **Auth profiles** (API keys, OAuth tokens) | `~/.openclaw/agents/main/agent/auth-profiles.json` |
| **Exec approvals** | `~/.openclaw/exec-approvals.json` |
| **Google OAuth credentials** | `~/Library/Application Support/gogcli/credentials.json` |
| **Gateway service** | `~/Library/LaunchAgents/ai.openclaw.gateway.plist` |
| **Gateway logs** | `/tmp/openclaw/openclaw-YYYY-MM-DD.log` |

### Backed Up to GitHub

| What | Repo |
|------|------|
| **Iris workspace** (memory, files, projects) | `github.com/PEDROGRANDE001/iris` (private) |
| **StemSmith onboarding** | `github.com/PEDROGRANDE001/stemsmith-onboarding` |
| **40 Edgewater fabric selector** | `github.com/PEDROGRANDE001/40e-fabric-selector` |
| **HI Knowledge Base** | `github.com/PEDROGRANDE001/hi-knowledge-base` |

---

## Step-by-Step Reinstall

### 1. Install OpenClaw

```bash
npm install -g openclaw
```

### 2. Run Setup Wizard

```bash
openclaw configure
```

This walks you through:
- Anthropic API key
- Gateway settings (port 18789, loopback bind, token auth)

### 3. Restore Config

If you have a backup of `~/.openclaw/openclaw.json`, copy it back. Otherwise, manually set:

```bash
# Anthropic (primary model)
openclaw config set agents.defaults.model.primary '"anthropic/claude-opus-4-6"'

# Gemini (fallback + image model)
openclaw config set models.providers.google.apiKey '"YOUR_GEMINI_KEY"' --json
openclaw config set agents.defaults.imageModel.primary '"google/gemini-2.0-flash"'
openclaw models fallbacks add "google/gemini-2.5-pro"

# Telegram
openclaw config set channels.telegram.enabled true --json
openclaw config set channels.telegram.botToken '"YOUR_BOT_TOKEN"' --json

# Discord
openclaw config set channels.discord.enabled true --json
openclaw config set channels.discord.token '"YOUR_DISCORD_BOT_TOKEN"' --json
openclaw config set channels.discord.guilds '{"1483260351821910047":{"requireMention":false}}' --json
```

### 4. Restore Workspace

```bash
cd ~/.openclaw
git clone https://github.com/PEDROGRANDE001/iris.git workspace
```

This brings back:
- `SOUL.md`, `USER.md`, `AGENTS.md`, `IDENTITY.md` — who Iris is
- `MEMORY.md` — long-term memory
- `memory/` — daily notes
- `TOOLS.md` — API keys, system notes
- All client files, projects, brochures, etc.

### 5. Restore Google OAuth (gog CLI)

```bash
# Install gog if needed
npm install -g gogcli

# Re-authenticate
gog auth login
```

This gives Iris access to Google Calendar, Gmail, Drive.

### 6. Start the Gateway

```bash
openclaw gateway start
```

Or if you want it as a background service:

```bash
openclaw gateway install
openclaw gateway start
```

### 7. Test

Send a message to Iris on Telegram. She should respond. If not:

```bash
openclaw status
openclaw doctor
openclaw channels list
```

---

## API Keys & Tokens You'll Need

These are stored in `TOOLS.md` in the workspace (backed up to GitHub):

- **Anthropic** API key
- **Google Gemini** API key
- **Telegram bot token** (Iris + Book Bot)
- **Discord bot token**
- **HubSpot** private app token
- **Monday.com** API token
- **Perplexity** API key
- **GitHub** PAT
- **Gmail app passwords** (peter@ and iris@)

---

## Quick Health Check After Reinstall

```bash
openclaw status
openclaw security audit
openclaw gateway status
openclaw channels list
openclaw cron list
```

---

## Notes

- The workspace is the most important thing to back up — it's Iris's brain
- `openclaw.json` is the second most important — it's all the wiring
- OAuth tokens expire, so you may need to re-auth Google after a reinstall
- Telegram/Discord bot tokens don't expire unless you reset them
- The Mac Mini runs the gateway as a LaunchAgent (auto-starts on login)
