# Self-Improving Agent

## When to Trigger

Automatically capture a learning when:
- A command or operation fails unexpectedly
- The user corrects you ("No, that's wrong...", "Actually it's...", etc.)
- You discover your knowledge is outdated or incorrect
- A better approach is found for a recurring task
- An external API or tool fails
- A user requests a capability that doesn't exist yet

## How to Capture

Append to `.learnings/log.md` using this format:

```markdown
## [YYYY-MM-DD HH:MM] Category: Brief Title

**Context:** What was happening
**Issue:** What went wrong or what was learned
**Resolution:** How it was fixed or what the correct answer is
**Prevention:** How to avoid this in the future

---
```

### Categories
- `ERROR` — Something broke
- `CORRECTION` — User corrected the agent
- `DISCOVERY` — Found better approach or new information
- `OUTDATED` — Knowledge was stale/wrong
- `FEATURE-GAP` — Requested capability doesn't exist
- `PREFERENCE` — User preference learned

## Review Cycle

During heartbeats or memory maintenance:
1. Review `.learnings/log.md` for patterns
2. Promote significant learnings to `MEMORY.md` under "Lessons Learned"
3. If a learning changes how a tool should be used, update `TOOLS.md`
4. Archive old entries to `.learnings/archive.md` monthly

## Before Refactors or New Work

Always check `.learnings/log.md` for relevant past issues before:
- Trying a new approach to something that failed before
- Working with a tool/API that had prior issues
- Repeating a task type where corrections were made
