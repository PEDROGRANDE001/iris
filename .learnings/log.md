# Learnings Log

---

## [2026-03-07 13:55] DISCOVERY: Whisper model not persistent

**Context:** Transcribing voice message, whisper-cli failed
**Issue:** `/tmp/ggml-base.en.bin` gets cleared between reboots/cleanups. Had to re-download.
**Resolution:** Re-downloaded from huggingface. Works fine after that.
**Prevention:** Check if model exists before transcribing. Re-download if missing. Consider storing in `~/.openclaw/models/` instead of `/tmp/`.

---

## [2026-03-07 13:56] DISCOVERY: ClawHub site is client-side rendered

**Context:** Tried to fetch ClawHub skill pages
**Issue:** `web_fetch` returns empty content — site is a SPA that renders via JavaScript
**Resolution:** Use `web_search` to find skill info, or use browser tool when available
**Prevention:** Don't bother with web_fetch on clawhub.ai — always search instead

---

## [2026-03-07 13:57] FEATURE-GAP: No skill install command in OpenClaw CLI

**Context:** Tried to install self-improving-agent from ClawHub
**Issue:** `openclaw skills` only has list/check/info — no install subcommand. The `npx @lobehub/market-cli` route needs credentials.
**Resolution:** Built the skill manually in workspace
**Prevention:** For ClawHub skills, just read what they do and implement locally

---
