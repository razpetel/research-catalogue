---
topic: conductor-build
slug: conductor-build
date: 2026-02-26
sources: [github, reddit, twitter, linkedin, web]
---

# Conductor (conductor.build) Research Report

## Overview

Conductor is a free, closed-source Mac application by Melty Labs that enables developers to run multiple Claude Code and OpenAI Codex agents in parallel, each in its own isolated git worktree. Built by YC S24 founders Charlie Holtz (ex-Replicate, Point72) and Jackson de Campos, the 4-person San Francisco team previously created Melty, an open-source chat-first code editor with 5.4k GitHub stars, before pivoting to the orchestration layer.

The app addresses a practical pain point: when developers want to parallelize AI coding work, manually managing multiple terminal sessions, git branches, and worktrees is tedious and error-prone. Conductor wraps this complexity in a native Mac GUI — one click creates an isolated workspace with its own branch, runs a setup script (e.g., `npm install`, copy `.env`), and launches a Claude Code or Codex session. A unified dashboard shows all active agents, a built-in diff viewer lets you review changes, and you can create PRs and merge directly from the app.

Adoption signals are strong for an early-stage product: Conductor is trusted by Linear, Vercel, Notion, Stripe, Life360, and others. It's featured in an O'Reilly Radar article on the future of agentic coding, reviewed by The New Stack, and endorsed by engineers at LinkedIn and Stripe. However, a GitHub permissions controversy (requesting full read-write OAuth access) has created friction with security-conscious developers, and the closed-source, Mac-only nature limits its addressable market.

## Technical Analysis

### Architecture
- **Workspace isolation**: Each agent runs in a separate git worktree with its own branch — no merge conflicts between parallel agents
- **Configuration**: `conductor.json` defines `setup`, `run`, and `archive` scripts per project
- **Environment variable handling**: `$CONDUCTOR_ROOT_PATH` env var enables symlinking `.env`, credentials, and config files from the root repo into each worktree
- **Framework quickstarts**: Documented setups for Rails, Next.js, Django with templates for dependency installation, config copying, and dev server startup
- **MCP support**: Claude Code MCP servers work within Conductor workspaces (e.g., Context7, custom MCPs)
- **Slash commands**: Custom commands available within agent sessions

### Integrations
- **Linear**: One-click issue-to-workspace — start work on a Linear issue directly
- **GitHub**: PR creation and merge from within the app; OAuth-based authentication (migration to GitHub App auth in progress)
- **Claude Code**: Uses existing authentication (Pro, Max, or API key)
- **Codex**: OpenAI Codex agent support

### Predecessor: Melty
- Open-source MIT-licensed chat-first code editor (TypeScript, 5,449 stars)
- Last updated Nov 2024 — team fully pivoted to Conductor
- Strategic shift: open-source editor → closed-source orchestration tool

### Version & Distribution
- Current version: 0.36.4
- Distributed via Melty Labs website and meltylabs/conductor-releases GitHub repo
- Homebrew tap available

## User Sentiment

**Overall: Positive**

- **Reddit**: Enthusiastic early adopters in r/ClaudeAI. Users call it "a new productivity unlock" and praise the git worktree automation. Criticism focused on Claude Code-only dependency (some want agent-agnostic support) and a plan mode bug in long sessions (since patched). Confusion with Google Conductor (different product) and conductor-tasks MCP (different project) is common.
- **Twitter/X**: Limited direct search visibility, but Twitter demo videos are cited as a primary discovery channel. Testimonials from Stripe and Supermemory engineers are prominently featured.
- **LinkedIn**: Professional endorsements from early adopters. Hiring 3 founding roles ($140K–$250K + equity) signals growth investment. Staff engineers at LinkedIn praise the UX balance.

## Competitive Landscape

| Tool | Type | Open Source | Agents | Key Differentiator |
|------|------|-------------|--------|--------------------|
| **Conductor** (conductor.build) | Mac GUI app | No | Claude Code, Codex | Best UX, Linear integration, enterprise adoption |
| **Claude Squad** | Terminal TUI | Yes | Claude Code | Open-source, lightweight, terminal-native |
| **code-conductor** (ryanmac) | GitHub-native CLI | Yes | Claude Code | GitHub-native orchestration, no app required |
| **Google Conductor** | Gemini CLI extension | Yes | Gemini only | Context-driven development, spec-first workflow |
| **oh-my-claudecode** | Claude Code plugin | Yes | Claude Code | 5 execution modes, 32 agents, smart model routing |
| **Agent Hive** | Multi-tool | Yes | Multiple | Agent-agnostic alternative |

Conductor occupies a unique niche as the **only polished GUI app** in this space. All open-source alternatives are terminal-based. The tradeoff is clear: better UX and enterprise trust vs. closed-source lock-in and Mac-only availability.

The O'Reilly Radar article positions Conductor in the "orchestrator" category — tools that help developers coordinate multiple AI agents — and predicts this category will grow as the developer role shifts from "implementer" to "manager of AI agents."

## Pros and Cons

| Pros | Cons |
|------|------|
| Beautiful native Mac GUI with unified dashboard | Closed-source — can't audit, fork, or self-host |
| Automatic git worktree isolation eliminates conflicts | Mac-only (Windows waitlist) |
| Free — no subscription, no feature gates | GitHub OAuth requests overly broad permissions |
| Linear integration for issue-based workflows | Limited to Claude Code + Codex (no Gemini, Cursor, etc.) |
| Enterprise adoption (Stripe, Vercel, Notion, Linear) | 4-person team — bus factor risk for enterprise reliance |
| Setup scripts (`conductor.json`) handle env/deps per project | No public issue tracker or roadmap |
| MCP and slash command support | Plan mode had bugs in long sessions (patched) |
| Active development (v0.36.4, frequent updates) | Name confusion with Google Conductor and conductor-tasks |

## Sources

### GitHub
- https://github.com/meltylabs (Melty Labs org — 10 repos)
- https://github.com/meltylabs/melty (predecessor, 5.4k stars)

### Reddit
- https://www.reddit.com/r/ClaudeAI/comments/1m8fq16/conductor_a_mac_app_that_lets_you_run_a_bunch_of/
- https://www.reddit.com/r/ClaudeAI/comments/1m331h1/share_conductor_for_macos_run_a_bunch_of_claude/
- https://www.reddit.com/r/ClaudeAI/comments/1owx2ga/conductor_implementation_and_orchestration_with/
- https://www.reddit.com/r/vibecoding/comments/1q2105p/can_someone_build_this_dream_vibe_coding/
- https://www.reddit.com/r/mcp/comments/1klvgb6/conductor_tasks_mcp_task_manager_for_ai/

### Twitter/X
- https://x.com/conductoragent (different product — crypto AI agent)

### LinkedIn
- https://www.linkedin.com/posts/elie222_conductorbuild-makes-it-really-easy-to-handle-activity-7421191695230304256-kXf_
- https://www.linkedin.com/posts/asgharali07_i-recently-started-usingconductorbuild-activity-7354657701940899841-V7T6

### Web
- https://www.conductor.build/
- https://docs.conductor.build
- https://www.ycombinator.com/companies/conductor
- https://thenewstack.io/a-hands-on-review-of-conductor-an-ai-parallel-runner-app/
- https://www.oreilly.com/radar/conductors-to-orchestrators-the-future-of-agentic-coding/
- https://biggo.com/news/202507210115_Conductor_App_GitHub_Permissions_Controversy

---
*Generated by Research Agent on 2026-02-26*
