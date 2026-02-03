# Beads (steveyegge/beads)

**Research Date:** February 3, 2026
**Category:** AI Coding Tools / Agent Memory
**Repository:** https://github.com/steveyegge/beads

## TL;DR

Beads is a git-backed, dependency-aware task tracker designed specifically for AI coding agents. With 14.5K stars in 4 months and active weekly releases, it solves the critical "agent amnesia" problem—AI assistants forgetting context after compaction or across sessions. Users report sustained 12+ hour productivity versus ~1 hour without it. The tool now powers Steve Yegge's Gas Town multi-agent orchestrator, though that project has attracted controversy (BAGS token, code review claims). Beads itself remains well-regarded as infrastructure. Best for developers on serious, long-horizon AI-assisted projects who can accept workflow discipline overhead.

## What It Is

Beads (CLI: `bd`) is a distributed, git-backed graph issue tracker that provides persistent, structured memory for AI coding agents. Created by Steve Yegge (ex-Amazon, ex-Google, ex-Sourcegraph), it replaces messy markdown plans with a dependency-aware task graph stored directly in your repository.

**Key Innovation:** Instead of agents parsing prose specifications or losing context at compaction, Beads provides:
- **Hash-based IDs** (`bd-a1b2`) that prevent merge conflicts across agents/branches
- **Dependency graphs** with explicit blocking relationships
- **Semantic compaction** that summarizes old tasks while preserving reasoning
- **Git-native storage** (JSONL in `.beads/`) that versions and branches with code

## Technical Architecture

```
┌─────────────────────────────────────────────────┐
│                  Your Project                    │
├─────────────────────────────────────────────────┤
│  .beads/                                        │
│  ├── issues.jsonl    ← Source of truth          │
│  ├── config.yaml     ← Project configuration    │
│  └── cache.sqlite    ← Query performance layer  │
├─────────────────────────────────────────────────┤
│  bd CLI                                         │
│  ├── bd ready        → Unblocked tasks          │
│  ├── bd create       → New task with priority   │
│  ├── bd dep add      → Link dependencies        │
│  ├── bd show         → Task + audit trail       │
│  └── bd cleanup      → Prune/compact            │
├─────────────────────────────────────────────────┤
│  Storage Backends                               │
│  ├── SQLite + JSONL  ← Default                  │
│  └── Dolt            ← bd init --backend dolt   │
└─────────────────────────────────────────────────┘
```

**Dolt Integration (v0.49+):** Beads now supports Dolt as a backend, providing:
- SQL schema enforcement through constraints
- Transaction semantics for concurrent multi-agent writes
- Git-style version control for complete task history
- Complex queries and joins for selective context retrieval

## GitHub Metrics

| Metric | Value |
|--------|-------|
| Stars | 14,555 |
| Forks | 860 |
| Created | October 12, 2025 |
| Language | Go |
| License | MIT |
| Issues | 161 total |
| Latest Release | v0.49.3 (Feb 1, 2026) |
| Release Cadence | Weekly |

## Installation

```bash
# Shell script (recommended)
curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash

# Homebrew
brew install beads

# npm
npm install -g @beads/bd

# Go
go install github.com/steveyegge/beads/cmd/bd@latest
```

## Essential Commands

```bash
# Initialize in your project
cd your-project
bd init                          # Standard setup
bd init --backend dolt           # Dolt backend
bd init --stealth                # Local only, no commits
bd init --contributor            # Fork workflow

# Daily workflow
bd ready                         # Show unblocked tasks
bd create "Implement auth" -p 0  # Create P0 task
bd dep add bd-a1b2 bd-c3d4       # bd-a1b2 blocked by bd-c3d4
bd show bd-a1b2                  # View task + audit trail

# Hierarchical tasks
# bd-a3f8       (Epic)
# bd-a3f8.1     (Task)
# bd-a3f8.1.1   (Sub-task)
```

## Community Reception

### Reddit Sentiment (r/ClaudeCode, r/ClaudeAI)

**Positive (~70%):**
- "Solved my biggest frustration with AI coding—Claude forgetting everything after compaction"
- "Beads + Claude Code reduced my compaction regression loop a lot"
- "Incredibly valuable to keep Claude aligned with my goals"
- "bd ready surfaces only unblocked, high-priority tasks through graph traversal"

**Neutral/Curious (~20%):**
- "Is Beads worth a try?" discussion threads
- Questions about compatibility with other agents

**Skeptical (~10%):**
- "Even though I have put in the rules... it doesn't always follow" (agent compatibility)
- Concern about complexity and workflow overhead

### Performance Claims

DoltHub testing: "agents using Beads maintained productivity for 12+ hours versus ~1 hour for standard coding agents"

### Ecosystem Integration

- **SuperBeads:** Framework combining Beads + Superpowers + Ralph Wiggum philosophy
- **BeadsViewer:** Visual interface by Dicklesworthstone
- **Gas Town:** Multi-agent orchestrator built on Beads

## Gas Town Controversy

Steve Yegge's Gas Town (launched January 2026) uses Beads as its task infrastructure but has attracted criticism:

1. **Code Review Claims:** Yegge stated "I've merged over 100 PRs from nearly 50 contributors, adding 44k lines of code that no human has looked at"—raising quality/security concerns
2. **BAGS Token:** A meme coin associated with Gas Town was pumped and dumped, with Pivot to AI calling it "crypto scam"
3. **Fabricated Terminology:** Critics note excessive jargon ("towns," "rigs," "polecats") for standard concepts

**Important:** This controversy primarily targets Gas Town, not Beads itself. Beads as a standalone task tracker maintains positive community reception.

## Strengths

1. **Solves Real Problem:** Agent amnesia is universal frustration; Beads addresses it directly
2. **Git-Native:** Appeals to developers who want version-controlled task state
3. **Active Development:** Weekly releases, responsive maintainer, 50+ contributors
4. **Proven Performance:** 12x productivity improvement in sustained sessions
5. **Flexible Deployment:** Stealth mode, contributor mode, Dolt backend options

## Limitations

1. **Workflow Discipline Required:** Not for quick scripts—designed for serious projects
2. **Learning Curve:** Dependency graph mental model takes adoption effort
3. **Agent Compatibility:** Some agents prefer their own task management
4. **Gas Town Association:** Controversy may affect perception by association

## Who Should Use This

**Best For:**
- Developers on long-horizon AI-assisted projects (weeks, not hours)
- Teams using Claude Code, Cursor, or similar agents
- Projects where context loss is causing real productivity drain
- Those comfortable with git-backed tooling

**Wait If:**
- Working on quick, self-contained tasks
- Using agents that strongly prefer built-in task management
- Not comfortable with workflow changes
- Risk-averse about newer tooling

## Competitive Landscape

| Tool | Focus | Beads Differentiation |
|------|-------|----------------------|
| Markdown plans | Static docs | Dependency graph, auto-ready detection |
| GitHub Issues | Human-first | Agent-optimized JSON output, hash IDs |
| Superpowers TodoWrite | Session tasks | Persistent across sessions, git-versioned |
| Custom sqlite | Ad-hoc | Standardized, community tooling |

## Verdict

**Rating: Positive**

Beads solves a genuine, widespread problem (agent amnesia) with a thoughtful, git-native approach. The 14.5K stars in 4 months and active development signal strong adoption. The Gas Town controversy is worth noting but doesn't undermine the core value proposition.

**Recommendation:** Adopt for serious AI-assisted development projects. The workflow discipline pays dividends for long-horizon work. Evaluate carefully if your agent has strong built-in task preferences or if you're doing quick prototyping.

## Sources

- [GitHub Repository](https://github.com/steveyegge/beads)
- [DoltHub: Agentic Memory](https://www.dolthub.com/blog/2026-01-22-agentic-memory)
- [DEV: How beads Changed My Development Workflow](https://dev.to/koustubh/building-apps-with-ai-how-beads-changed-my-development-workflow-2p7)
- [YUV.AI: Git-Backed Memory for AI Agents](https://yuv.ai/blog/beads-git-backed-memory-for-ai-agents-that-actually-remembers)
- [Steve Yegge Medium: Software Survival 3.0](https://steve-yegge.medium.com/software-survival-3-0-97a2a6255f7b)
- [Pivot to AI: Gas Town Criticism](https://pivot-to-ai.com/2026/01/22/steve-yegges-gas-town-vibe-coding-goes-crypto-scam/)
- r/ClaudeCode and r/ClaudeAI discussion threads
