---
topic: Claude Squad
slug: claude-squad
date: 2026-03-01
sources: [github, reddit, twitter, linkedin, web]
---

# Claude Squad Research Report

**Date:** 2026-03-01
**Sentiment:** Mixed
**Summary:** The de facto terminal multiplexer for managing parallel AI coding agents (6.2K stars, Go, AGPL-3.0). Uses tmux + git worktrees for true process and branch isolation. Agent-agnostic (Claude Code, Codex, Aider, Gemini, OpenCode, Amp). Category-defining but inconsistently maintained — burst development pattern with months-long gaps and 21 stale PRs. Community concerns about abandonment partially alleviated by March 2026 activity burst.

---

## Overview

Claude Squad (smtg-ai/claude-squad) is a terminal-based TUI written in Go that manages multiple AI coding agents running in parallel. Despite the name, it's agent-agnostic — supporting Claude Code, Codex, Aider, Gemini CLI, OpenCode, and Amp. Each agent runs in an isolated tmux session with its own git worktree, preventing branch conflicts and enabling true parallel development.

At 6,173 stars and 417 forks, Claude Squad defined the "terminal AI agent multiplexer" category and inspired a wave of follow-on tools (CCManager, Agent Deck, Crystal, cmux, dmux). Installed via Homebrew (`brew install claude-squad`) or curl script, it provides the `cs` binary for creating, monitoring, pausing, resuming, and reviewing diffs from all agents in a single terminal window.

However, the project's maintenance pattern is concerning. Development follows an inconsistent burst pattern — very active June-August 2025, then quiet for months, with a new burst on March 1, 2026 (v1.0.15 and v1.0.16 released). Two separate GitHub issues (#214, #250) ask if the project is abandoned. Twenty-one community PRs remain unreviewed, some for 5-7 months. The two core developers (Mufeez Amjad, Jay Shrivastava) appear bandwidth-constrained, and the AGPL license plus CLA requirement may be deterring contributors.

## Technical Analysis

### Repository Health

| Attribute | Value |
|-----------|-------|
| **GitHub** | [smtg-ai/claude-squad](https://github.com/smtg-ai/claude-squad) |
| **Stars** | 6,173 |
| **Forks** | 417 |
| **License** | AGPL-3.0 |
| **Language** | Go |
| **Version** | v1.0.16 (released 2026-03-01) |
| **Created** | 2025-03-09 |
| **Last commit** | 2026-03-01 |
| **Total releases** | 16 |
| **Contributors** | 12 (2 core, 10 with 1 commit each) |
| **Issues (all time)** | 115 |
| **PRs (all time)** | 132 (21 open, many stale) |
| **CI/CD** | Yes (goreleaser) |
| **Install** | `brew install claude-squad` or curl script |
| **Binary** | `cs` |
| **Status** | **Inconsistently maintained** |

### Architecture

- **tmux** — isolated terminal sessions per agent
- **Git worktrees** — branch isolation per task
- **bubbletea/lipgloss** — Go terminal UI framework
- **cobra** — CLI command framework
- **Background daemon** — manages sessions when TUI is detached

### Key Features

- Multi-agent management in single terminal window
- Background task execution with "yolo" auto-accept mode (`-y`)
- Diff review before applying changes
- Session lifecycle: create, attach, detach, pause, resume, delete, push
- Terminal tab (v1.0.15) — interactive shell within TUI
- Agent-agnostic: Claude Code, Codex, Aider, Gemini, OpenCode, Amp

### Development Pattern

| Period | Activity |
|--------|----------|
| Jun-Aug 2025 | Very active — 10 releases, core features built |
| Sep-Nov 2025 | Near-silent — 4 commits total, community concerns begin |
| Dec 2025 | 2 commits (Unicode fix) |
| Jan-Feb 2026 | Silent |
| Mar 1, 2026 | Burst — 6 commits, 2 releases (v1.0.15, v1.0.16) |

## User Sentiment

**Overall: Mixed — category-defining but frustrating maintenance**

### Reddit
- **Positive:** "The shit," "amazing," category-defining tool, agent-agnostic design praised
- **Negative:** "Stopped using Claude Squad and just use git worktrees directly" — bugs, lag, can't scroll conversation history
- **Competitor mentions:** Crystal "looks way better," CCManager removes tmux dependency, Agent Deck has better notifications
- **Key gap:** No notification when agents complete or need approval

### Twitter/X
- **Buzz level:** Moderate-Low
- **@obie (Obie Fernandez):** "if you're smart, you're using Claude Squad"
- **@BetterStackHQ:** Framed it as "powerful agent multiplexer"
- **@ClaudeSquadAI:** Official account, 240 followers

### LinkedIn
- **Advocates:** Addy Osmani (multiple posts), Sven Korfmann (explainer), Better Stack (usage guide)
- **Creators identified:** Mufeez Amjad and Jay Shrivastava (smtg-ai)

### Web
- Listed in awesome-claude-code under Tooling > Orchestrators
- No dedicated news coverage or reviews
- Competitors: Crystal, claude-flow, ccswarm, uzi, CodeMux, Agent Teams (native)

## Competitive Landscape

| Tool | Stars | Approach | Maintained? | Key Differentiator |
|------|-------|----------|------------|-------------------|
| **Claude Squad** | 6.2K | tmux + worktrees TUI | Inconsistent | Category-definer, agent-agnostic |
| **Agent Teams** | N/A | First-party Anthropic | Active | Native, context-aware coordination |
| **Crystal** | New | Terminal multiplexer | Active | More polished UI |
| **CCManager** | New | tmux-free TUI | Active | No tmux dependency |
| **Agent Deck** | New | Status tracking | Active | Better notifications |
| **DIY tmux + worktrees** | N/A | Manual | N/A | Most reliable, zero overhead |
| **multiclaude** | 457 | Go + tmux | Active | Auto-merge CI-passing PRs |

## Pros and Cons

| Pros | Cons |
|------|------|
| Category-defining tool (6.2K stars) | Inconsistent maintenance (months-long gaps) |
| Agent-agnostic (6+ agents supported) | 21 stale PRs, community abandonment concerns |
| True process isolation (tmux + worktrees) | Bus factor of 2 (effectively 1 active) |
| Homebrew install, clean Go codebase | AGPL license may deter commercial use |
| Inspired ecosystem of follow-on tools | CLA requirement adds contributor friction |
| Recent activity (v1.0.16, Mar 2026) | No agent completion notifications |
| | tmux dependency polarizing |
| | No Windows support |

## Verdict

Claude Squad defined the "terminal AI agent multiplexer" category and remains the most-referenced tool in this space. Its tmux + worktrees architecture provides true process isolation that wrapper tools can't match. However, the inconsistent maintenance pattern is a real risk — users may invest in a workflow around a tool that goes months without updates.

**Best for:**
- Terminal power users comfortable with tmux
- Developers running multiple different AI agents (not just Claude Code)
- Users who want simple, process-level isolation without framework overhead

**Consider alternatives if:**
- You need reliable maintenance and PR responsiveness (consider Crystal or CCManager)
- You only use Claude Code (Agent Teams is native and actively developed)
- You want notifications when agents finish (consider Agent Deck)
- You prefer DIY reliability (plain tmux + git worktrees)

**Recommendation:** Still the default recommendation in its category, but with a watchful eye on maintenance. If the March 2026 burst is a one-time revival rather than sustained attention, users should have a migration plan to alternatives. The DIY tmux + worktrees approach remains the most reliable option for power users who don't mind the manual overhead.

## Sources

- [GitHub: smtg-ai/claude-squad](https://github.com/smtg-ai/claude-squad)
- [Reddit: Stopped using Claude Squad](https://www.reddit.com/r/ClaudeAI/comments/1lsgaab/)
- [Reddit: Crystal vs Claude Squad](https://www.reddit.com/r/ClaudeAI/comments/1lkzl44/)
- [@obie endorsement](https://x.com/obie)
- [awesome-claude-code listing](https://github.com/hesreallyhim/awesome-claude-code)
- [Prior report: multiclaude (2026-02-02)](catalogue/2026-02-02-multiclaude.md)

---
*Generated by Research Agent on 2026-03-01*
