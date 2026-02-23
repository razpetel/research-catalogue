---
topic: Claude Squad (smtg-ai)
slug: claude-squad
date: 2026-02-23
sources: [github, reddit, twitter, linkedin, web]
---

# Claude Squad Research Report

## Overview

**Claude Squad** is a Go-based terminal application that manages multiple AI coding agents (Claude Code, Codex, Aider, Gemini, and custom commands) in isolated workspaces, allowing developers to work on multiple tasks simultaneously. Created by **Mufeez Amjad** (engineer at Linear, ex-Meta/CockroachDB) and **Jayant Shrivastava** (systems programmer, ex-CockroachDB), it launched in March 2025 and has accumulated 6,111 GitHub stars and 410 forks. O'Reilly Radar calls it "a popular open source terminal app that essentially multiplexes Anthropic's Claude" and Addy Osmani (Google) identifies it as "one of the pioneers" in agent orchestration.

The tool's core innovation is **dual isolation**: each agent runs in its own tmux session (terminal isolation) with a dedicated git worktree (filesystem isolation), preventing conflicts when multiple AI agents modify the same codebase simultaneously. It installs as a single binary (`cs`) via Homebrew or curl, requiring only tmux and gh CLI as prerequisites.

However, the project shows significant signs of stagnation. The last commit was December 24, 2025 -- two months ago -- and Issue #250 explicitly asks "May I respectfully ask if this project is abandoned?" with 43 open issues and unreviewed PRs piling up. Both creators appear to maintain Claude Squad as a side project alongside their day jobs. Meanwhile, competitors like VibeKanban (20.4K stars), Anthropic's native Agent Teams, and Gas Town have continued active development.

## Technical Analysis

### Repository Health
- **URL:** https://github.com/smtg-ai/claude-squad
- **Stars:** 6,111 | **Forks:** 410
- **Language:** Go (99.5%)
- **License:** AGPL-3.0
- **Created:** 2025-03-09
- **Last Commit:** 2025-12-24
- **Latest Release:** v1.0.14 (Dec 24, 2025)
- **Status:** **Stale** -- 2 months without commits, open "is this abandoned?" issue

### Architecture
- **Framework:** Charmbracelet Bubbletea (TUI) + Cobra (CLI)
- **Isolation:** tmux sessions + git worktrees (dual isolation)
- **Max Instances:** 10 concurrent AI agents
- **Config:** `~/.claude-squad/config.json`
- **State:** JSON persistence + tmux external state + git worktree filesystem state
- **Pattern:** Unidirectional message-driven (Elm Architecture / MVU)

### Key Features
| Feature | Detail |
|---------|--------|
| **Multi-agent management** | Run up to 10 agents in parallel, navigate via TUI |
| **Agent-agnostic** | Claude Code, Codex, Aider, Gemini, or any custom command |
| **Git worktree isolation** | Each task gets its own branch and working directory |
| **AutoYes mode** | Background daemon auto-accepts prompts (`cs -y`) -- experimental |
| **Preview + Diff panes** | Real-time terminal preview (100ms) and git diff view |
| **Commit & push** | One-key commit to GitHub from TUI |
| **Checkout/Resume** | Pause sessions (commit + detach) and resume later |
| **Homebrew** | `brew install claude-squad` |

### Creators & Contributors
| Contributor | Commits | Background |
|-------------|---------|------------|
| **Mufeez Amjad** (@mufeez-amjad) | 105 | Engineer at Linear, UWaterloo, ex-Meta, ex-CockroachDB |
| **Jayant Shrivastava** (@jayshrivastava) | 85 | Systems programmer, based in NY |
| 8 others | 1 each | Community contributions |

### Release History (14 releases total)
| Version | Date | Key Change |
|---------|------|------------|
| v1.0.14 | Dec 24, 2025 | Unicode/Chinese character handling, branch name sanitization |
| v1.0.13 | Aug 28, 2025 | Nil pointer fix, tmux mouse mode |
| v1.0.12 | Jul 23, 2025 | Faster session creation |
| v1.0.11 | Jul 22, 2025 | Auto-accept Claude trust prompt |
| v1.0.10 | Jul 13, 2025 | Stdout retention on pause |

## User Sentiment

**Overall:** Mixed -- respected pioneer, but maintenance concerns are eroding trust

### Reddit
- **Positive:** "I've been using Claude-Squad for this to run worktrees in tmux sessions and manage them from one place and it's the shit tbh"
- **Positive:** Consistently listed in every Claude Code tool compilation thread alongside top-tier tools
- **Negative:** "I found claude squad pretty buggy. It would lag out at times and I couldn't scroll up and see the old convo log" -- user switched to manual git worktrees
- **Negative:** CCManager built specifically as tmux-free alternative: "Most solutions (like claude-squad or self-managed tmux pane) still rely on tmux, which means..."
- Users frequently note that Claude Squad's value proposition (tmux + git worktrees) can be replicated manually

### Hacker News
- Co-creator moofeez claims it is "the most popular+used of these 'claude code multiplexers'"
- User zanek: setup instructions unintuitive, no official uninstall guidelines, "disappointing" experience

### Twitter/X
- Official @ClaudeSquadAI account exists but has minimal engagement
- Community discussion happens primarily on Reddit and Hacker News, not Twitter

### LinkedIn
- No significant LinkedIn presence
- Creators' professional backgrounds (Linear, Meta, CockroachDB) lend credibility

## Industry Recognition

| Source | Assessment |
|--------|------------|
| **O'Reilly Radar** | "Popular open source terminal app that essentially multiplexes Anthropic's Claude" |
| **Addy Osmani (Google)** | "One of the pioneers" in agent orchestration |
| **DEV Community** | Referenced in multi-agent orchestration tutorials |
| **AitoolNet** | Listed as featured tool |

## Competitive Landscape

| Tool | Stars | Active? | Key Differentiator | vs Claude Squad |
|------|-------|---------|--------------------|-----------------|
| **VibeKanban** | 20.4K | Yes | GUI + Rust/TS + git worktrees | More polished, visual, actively maintained |
| **Agent Teams** (Anthropic) | Built-in | Yes | Native Claude Code feature | First-party, no external tooling |
| **Auto-Claude** | 11.1K | Yes | Kanban + 12 parallel agents + QA loops | More features, more bugs |
| **Gas Town** (Yegge) | 8.1K | Yes | Go + tmux + Beads task tracking | More ambitious, more complex |
| **oh-my-claudecode** | 4K+ | Yes | Plugin + 5 execution modes | Plugin-based, more modes |
| **multiclaude** (Lorenc) | ~500+ | Yes | Go + tmux, "MMORPG" philosophy | Similar approach, team-oriented |
| **CodeMachine** | 2.2K | Yes | CLI orchestration engine | More sophisticated orchestration |

### Claude Squad's Position
Claude Squad occupies the **simplicity niche**: it does one thing (multiplex agents in tmux with git worktree isolation) and does it with minimal complexity. This was a strong position in early 2025, but the space has matured significantly. VibeKanban offers a richer GUI, Agent Teams eliminates external tooling entirely, and Gas Town adds sophisticated task tracking. Claude Squad's 6.1K stars reflect its early-mover advantage, but its stagnant development risks rapid obsolescence in this fast-moving category.

## Pros and Cons

| Pros | Cons |
|------|------|
| Simple, focused design -- one binary, clear purpose | Last commit 2 months ago, "abandoned?" issue filed |
| Agent-agnostic (Claude, Codex, Aider, Gemini) | Only 2 core contributors, both with day jobs |
| Homebrew installable, low barrier to entry | AGPL-3.0 license (restrictive for commercial use) |
| 6.1K stars -- significant community adoption | Buggy TUI reported (lag, scroll issues) |
| Industry recognition (O'Reilly, Addy Osmani) | tmux dependency limits audience |
| Git worktree isolation prevents conflicts | Manual git worktrees can replicate core value |
| 14 stable releases reaching v1.0.14 | No Windows support |
| Clean Go codebase with Bubbletea TUI | Native Agent Teams closing the gap |

## Key Insight

Claude Squad's trajectory illustrates a common pattern in the AI tooling space: **early movers that nail the core concept but can't sustain development get overtaken by better-resourced competitors**. It launched when running multiple Claude Code instances in parallel was novel and required manual tmux/worktree juggling. Its clean, simple design earned it 6K+ stars, O'Reilly recognition, and a spot in every tool roundup. But both creators are professional engineers at demanding companies (Linear, etc.), and the project has effectively stalled since December 2025. Meanwhile, VibeKanban (backed by BloopAI, a funded YC startup) has 3x the stars and active development, and Anthropic's own Agent Teams makes external orchestrators less necessary.

The question is whether Claude Squad's simplicity is a feature (it does what you need, no more) or a liability (it can't evolve to match the market). The open-source community filing "is this abandoned?" issues suggests the answer is increasingly the latter.

## Recommendation

**Worth trying for the simplest multi-agent use case** -- if you want to spin up 2-3 Claude Code instances on different tasks with git worktree isolation and don't need anything fancier. The Homebrew install makes getting started trivially easy.

**Skip if** you need active maintenance, Windows support, a visual interface, team features, sophisticated orchestration, or confidence that the tool will evolve. Look at **VibeKanban** for a GUI-based alternative, **Agent Teams** for first-party support, or **manual git worktrees + tmux** if you want full control without dependency on a stale project.

Best suited for:
- Solo developers already comfortable with tmux
- Quick parallel task execution on macOS/Linux
- Users who prefer minimal, focused tools over feature-rich platforms
- Anyone who wants a stepping stone before committing to a more complex orchestrator

## Sources

### Primary
- https://github.com/smtg-ai/claude-squad
- https://smtg-ai.github.io/claude-squad/
- https://deepwiki.com/smtg-ai/claude-squad

### Industry Coverage
- https://www.oreilly.com/radar/conductors-to-orchestrators-the-future-of-agentic-coding/
- https://addyo.substack.com/p/coding-for-the-future-agentic-world
- https://news.ycombinator.com/item?id=44630194
- https://www.aitoolnet.com/claude-squad
- https://www.emsi.me/tech/ai-ml/tame-your-terminal-managing-ai-coding-agents-with-claude-squad/2025-04-04/203a37

### Reddit Discussions
- https://www.reddit.com/r/ClaudeAI/comments/1jqzzzv/run_multiple_claude_code_instances_in_parallel/
- https://www.reddit.com/r/ClaudeAI/comments/1lsgaab/stopped_using_claude_squad_and_just_use_git/
- https://www.reddit.com/r/ClaudeAI/comments/1lfimy8/any_tips_on_multi_agent_for_the_same_project_with/
- https://www.reddit.com/r/ClaudeAI/comments/1ofltdr/i_spent_way_too_long_cataloguing_claude_code/
- https://www.reddit.com/r/ClaudeAI/comments/1l80jd4/i_built_ccmanager_a_tmuxfree_way_to_manage/

### Related Reports
- [multiclaude](catalogue/2026-02-02-multiclaude.md) (2026-02-02) -- Similar tmux+worktree approach
- [Claude Code Agent Teams](catalogue/2026-02-09-claude-code-agent-teams.md) (2026-02-09) -- First-party alternative
- [VibeKanban](catalogue/2026-02-04-vibekanban.md) (2026-02-04) -- GUI orchestrator competitor
- [Auto-Claude](catalogue/2026-02-02-auto-claude.md) (2026-02-02) -- Kanban-based competitor
- [Gas Town](catalogue/2026-02-04-gastown.md) (2026-02-04) -- Yegge's orchestrator

---
*Generated by Research Agent on 2026-02-23*
