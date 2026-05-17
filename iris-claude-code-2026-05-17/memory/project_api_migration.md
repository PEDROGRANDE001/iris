---
name: API Migration — OpenClaw to Claude Max
description: Iris was migrated from Anthropic API (via OpenClaw) to Claude Max $200/mo plan running Claude Code CLI. Old API is turned off.
type: project
---

Iris was originally running on the Anthropic API via OpenClaw (a self-hosted agent gateway). As of April 2026, Peter turned off the API and migrated to the **Claude Max plan ($200/mo)** running through **Claude Code CLI** on his Mac Mini.

**Why:** Cost optimization and simplification — Claude Max gives unlimited Opus 4.6 usage without per-token API billing.

**How to apply:**
- If any integration or script references the old Anthropic API key or OpenClaw gateway, it's dead — don't try to use it.
- All prior OpenClaw-specific features (Telegram bot, Discord bot, gateway service, heartbeat, cron via OpenClaw) are no longer available.
- Current integrations (Gmail, Calendar, Drive, HubSpot, Monday.com) work through Claude Code's MCP connectors, not the old OpenClaw auth system.
- The old workspace lives at `PEDROGRANDE001/iris` on GitHub — it's a backup/archive of the OpenClaw era.
- The old REINSTALL.md in that repo references OpenClaw — it's historical, not actionable.
