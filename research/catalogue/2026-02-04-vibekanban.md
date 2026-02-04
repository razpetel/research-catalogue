# VibeKanban

**Date**: 2026-02-04
**URL**: https://www.vibekanban.com/
**GitHub**: https://github.com/BloopAI/vibe-kanban
**Sentiment**: Positive

## Summary

VibeKanban is an open-source GUI orchestration platform for parallel AI coding agents by BloopAI (YC S21). 20.4K stars in 8 months, TypeScript/Rust stack, London team of 10. Runs Claude Code, Codex, Gemini CLI, Cursor, and others in isolated git worktrees with built-in diff review. Reddit calls it "most mature, reliable" among orchestrators. Key tradeoff: enables `--dangerously-skip-permissions` by default for autonomous operation. Best for teams wanting visual task management over terminal workflows.

## Key Stats

| Metric | Value |
|--------|-------|
| GitHub Stars | 20,444 |
| Forks | 1,912 |
| Open Issues | 352 |
| Created | June 2025 |
| License | Apache 2.0 |
| Team Size | 10 |
| YC Batch | Summer 2021 |

## What It Does

VibeKanban transforms the AI coding workflow from "watch terminal logs scroll by" to "manage a team through a Kanban board":

1. **Create tasks** in a web UI (or let agents create their own via MCP)
2. **Assign to agents** (Claude Code, Codex, Gemini CLI, Cursor CLI, etc.)
3. **Execute in parallel** across isolated git worktrees
4. **Review via built-in diff UI** before merging
5. **Auto-create PRs** to GitHub

## Core Features

- **Multi-Agent Support**: Claude Code, OpenAI Codex, Gemini CLI, GitHub Copilot, Amp, Cursor CLI, Qwen Code
- **Parallel Execution**: Run multiple agents simultaneously without conflicts
- **Git Worktree Isolation**: Each task gets its own workspace, auto-cleanup after completion
- **Built-in Code Review**: Diff viewer for inspecting, editing, approving agent work
- **VS Code Extension**: Monitor tasks from within the editor
- **MCP Server**: Claude Desktop integration - agents can self-manage tickets
- **Task Templates**: Reusable patterns for standardized workflows
- **GitHub Integration**: Auto-PR creation, rebase/merge handling

## Technical Architecture

```
┌─────────────────────────────────────────────────────┐
│                   Web UI (React/TS)                 │
├─────────────────────────────────────────────────────┤
│                   Rust Backend                      │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐            │
│  │ Process │  │   Git   │  │WebSocket│            │
│  │ Manager │  │Worktrees│  │  Server │            │
│  └─────────┘  └─────────┘  └─────────┘            │
├─────────────────────────────────────────────────────┤
│              Agent CLI Layer                        │
│  Claude Code │ Codex │ Gemini │ Cursor │ etc.     │
└─────────────────────────────────────────────────────┘
```

## Installation

```bash
npx vibe-kanban
# Opens web UI at localhost:5173
```

Requires Node.js 18+ and agent CLIs already authenticated.

## Team

- **Louis Knight-Webb** - CEO
- **Gabriel Gordon-Hall** - Co-founder
- **Location**: London, UK
- **Funding**: YC Summer 2021
- **Hiring**: Senior Frontend (£100-120K, 0.5% equity), Senior Backend Rust (£100-120K, 0.5% equity)

## Community Reception

### Hacker News
- "Same increase in productivity...from when I first used Cursor"
- Privacy concern (analytics default) resolved within hours - praised for transparency

### Reddit
- r/ClaudeCode: "Most mature, reliable, supports lots of models, great previews and tooling, mobile friendly"
- Recommended over Auto-Claude, Maestro, Conductor for stability

### Medium Coverage
- Multiple positive writeups in Jan 2026
- "Turns coding agents into a team you can actually manage"

## Concerns

### Security: Dangerous Permissions Default
VibeKanban runs agents with `--dangerously-skip-permissions` (or `--yolo`) enabled by default. This is intentional - autonomous operation requires skipping approval prompts. However:
- No granular permission controls
- Tradeoff: convenience vs safety verification
- May not suit regulated environments or strict review requirements

### Privacy (Resolved)
- Initial version had analytics enabled by default harvesting email/GitHub usernames
- Community flagged it on HN
- Team merged opt-in PR within hours
- Now fully opt-in

### File Conflicts
- "Works great until two agents touch the same code path"
- Git worktrees mitigate but don't eliminate merge conflicts
- Requires task decomposition discipline

## Comparison to Alternatives

| Tool | Approach | Stars | Key Difference |
|------|----------|-------|----------------|
| **VibeKanban** | GUI Kanban | 20.4K | Visual task management, multi-model |
| **multiclaude** | tmux + Go | 457 | Minimal, terminal-native |
| **Auto-Claude** | Visual Kanban | 11.1K | More all-in-one, Claude-specific |
| **Gas Town** | Mayor/Polecats | 8.1K | Complex multi-agent, experimental |
| **Spec Kitty** | GitHub Spec Kit | ~new | Stricter worktree workflow |

VibeKanban differentiates by being:
- **GUI-first** (vs terminal-native multiclaude, Gas Town)
- **Multi-model** (vs Claude-specific Auto-Claude)
- **Production-stable** (vs experimental Gas Town)
- **Actively maintained** (daily releases, responsive team)

## When to Use

**Good Fit:**
- Teams wanting visual orchestration over terminal management
- Multi-model shops (using Claude + Codex + Gemini)
- Developers who prefer GUI-based workflows
- Projects needing built-in code review for agent output

**Poor Fit:**
- Regulated environments requiring approval workflows
- Teams uncomfortable with dangerous permissions defaults
- Single-agent workflows (overkill)
- Those preferring terminal-native tooling

## Verdict

VibeKanban is the most mature GUI-based multi-agent orchestrator available. The 20K+ stars, daily releases, YC backing, and responsive team indicate serious commitment. The "dangerous permissions" default is a deliberate design choice reflecting where autonomous AI coding is heading - you either trust agents to operate independently or you don't.

**Recommended** for teams already running parallel AI agents who want better visibility and review tooling. If you're managing Claude Code + other agents across multiple features and drowning in terminal windows, this is the tool to evaluate first.

**Wait** if you need granular permission controls or aren't comfortable with autonomous agent execution.

## Sources

- [GitHub Repository](https://github.com/BloopAI/vibe-kanban)
- [Official Website](https://www.vibekanban.com/)
- [Y Combinator Profile](https://www.ycombinator.com/companies/vibe-kanban)
- [Hacker News Discussion](https://news.ycombinator.com/item?id=44533004)
- [Reddit r/ClaudeCode Thread](https://www.reddit.com/r/ClaudeCode/comments/1m1b7rf/vibe_kanban_is_now_open_source/)
- [Elite AI-Assisted Coding Review](https://elite-ai-assisted-coding.dev/p/vibe-kanban-tool-review)
- [VirtusLab Blog](https://virtuslab.com/blog/ai/vibe-kanban/)
