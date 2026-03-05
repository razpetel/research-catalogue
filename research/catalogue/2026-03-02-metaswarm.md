---
topic: Metaswarm
slug: metaswarm
date: 2026-03-02
sources:
  - https://github.com/dsifry/metaswarm
  - https://dsifry.github.io/metaswarm/
  - https://news.ycombinator.com/item?id=46864977
  - https://github.com/dsifry/metaswarm-marketplace
  - https://github.com/dsifry/metaswarm-introduction-preso
  - https://www.linkedin.com/in/dsifry/
  - https://www.reddit.com/r/ClaudeAI/comments/1qwi7cm/
  - https://www.reddit.com/r/ClaudeAI/comments/1ldm523/
  - https://www.reddit.com/r/ChatGPTCoding/comments/1lz8chi/
---

# Metaswarm

## Overview

Metaswarm is a self-improving multi-agent orchestration framework for Claude Code, Gemini CLI, and Codex CLI. Created by **Dave Sifry** (founder of Technorati, Linuxcare, and Warmstart; former tech executive at Lyft and Reddit), it coordinates 18 specialized AI agents through 13 orchestration skills and 15 slash commands across a complete software development lifecycle -- from GitHub issue to merged PR.

The project was first released on **February 2, 2026** and has reached version **0.10.0** as of late February 2026. It is extracted from a production-tested agentic orchestration system that has been used to write production-level code with 100% test coverage, mandatory TDD, and spec-driven development across hundreds of autonomous PRs. In a widely-cited demonstration, Sifry merged **127 PRs to production in a single weekend** using the system with no human code writing, reviews, or merge approvals.

The project is open-source under the **MIT license**, hosted at [github.com/dsifry/metaswarm](https://github.com/dsifry/metaswarm), and currently has **87 stars** and **8 forks** on GitHub. It is distributed primarily as a **Claude Code marketplace plugin** but also supports Gemini CLI (as an extension) and Codex CLI (via shell script installation), with a cross-platform installer available via `npx metaswarm init`.

## Technical Analysis

### Architecture

Metaswarm uses a **prompt-based architecture** -- agents are defined as readable, editable Markdown files. There is no custom runtime, server, or proprietary SDK. The framework layers on top of existing AI coding CLI tools (Claude Code, Gemini CLI, Codex CLI) and coordinates them through structured workflows.

The core coordination mechanism is **BEADS** (by Steve Yegge), a git-native, AI-first issue tracking system that stores task state in a SQLite database within the repository. Agents coordinate via database state rather than inter-agent messages.

### 11-Phase Workflow Pipeline

1. **Research** -- Codebase exploration and pattern discovery
2. **Plan** -- Implementation plan creation
3. **Plan Validation** -- Pre-flight architecture, dependencies, security checks
4. **Design Review Gate** -- 6 specialist agents (PM, Architect, Designer, Security, UX, CTO) review in parallel with a 3-iteration cap before human escalation
5. **Decompose** -- Break into work units with Definition of Done items
6. **External Dependency Check** -- API key and credential identification
7. **Orchestrated Execution** -- 4-phase loop per work unit: IMPLEMENT -> VALIDATE -> ADVERSARIAL REVIEW -> COMMIT
8. **Final Review** -- Cross-unit integration and full test coverage verification
9. **PR Creation** -- Structured PR with test plan
10. **PR Shepherd** -- CI monitoring and review comment handling
11. **Close + Learn** -- Knowledge extraction and base updates

### 18 Agent Personas

| Agent | Role |
|---|---|
| Researcher | Codebase exploration, pattern discovery |
| Architect | System design, architecture review |
| Product Manager | Requirements, scope, user stories |
| Designer | UI/UX design review |
| Security Design Agent | Security architecture review |
| CTO | High-level technical decisions |
| Coder | Implementation with mandatory TDD |
| Code Reviewer | Collaborative and adversarial review |
| Security Auditor | Security vulnerability scanning |
| PR Shepherd | PR lifecycle automation, CI monitoring |
| Test Automator | Test creation and coverage enforcement |
| Knowledge Curator | Pattern extraction, knowledge base maintenance |
| Issue Orchestrator | Work decomposition, phase coordination |
| Swarm Coordinator | Top-level orchestration, spawns issue orchestrators |
| Metrics Agent | Performance and quality metrics tracking |
| SRE Agent | Infrastructure and reliability concerns |
| Slack Coordinator | Notifications and external communication |
| Customer Service Agent | User-facing support workflows |

### Key Technical Features

**Cross-Model Adversarial Review**: When multiple CLI tools are installed, the writer is always reviewed by a different model. If Claude writes code, Codex or Gemini reviews it -- eliminating single-model blind spots.

**Recursive Orchestration**: Swarm Coordinators spawn Issue Orchestrators, which spawn sub-orchestrators for complex epics. This "swarm of swarms" pattern handles arbitrary complexity.

**Self-Learning Knowledge Base**: A JSONL-based fact store captures patterns, gotchas, architectural decisions, and anti-patterns. The `/self-reflect` workflow analyzes merged PRs and extracts learnings back into the knowledge base. Selective retrieval via `bd prime` filters entries by affected files and work type, preventing context window bloat.

**Quality Gates as Blocking State Transitions**: Quality gates are not advisory -- there is no path from FAIL to COMMIT. Coverage thresholds (`.coverage-thresholds.json`), linting, and type checking are enforced through git hooks, CI workflows, and agent completion gates simultaneously.

**Context Recovery**: Approved plans and execution state persist to disk via BEADS, surviving context compaction and session interruption. The system can resume interrupted work units without re-running earlier phases.

**Conversation Introspection**: The reflection system analyzes user repetition (when users correct the same behavior multiple times), user disagreements (when users override agent recommendations), and friction points (repeated manual steps) to propose new skills, updated rubrics, or revised agent behaviors.

### Installation

```bash
# Claude Code (recommended)
claude plugin marketplace add dsifry/metaswarm-marketplace
claude plugin install metaswarm

# Gemini CLI
gemini extensions install https://github.com/dsifry/metaswarm.git

# Codex CLI
curl -sSL https://raw.githubusercontent.com/dsifry/metaswarm/main/.codex/install.sh | bash

# Cross-platform (detects all installed CLIs)
npx metaswarm init
```

### Dependencies

- One of: Claude Code, Gemini CLI, or Codex CLI
- Node.js 18+
- BEADS CLI (`bd`) v0.40+ (recommended, for task tracking)
- GitHub CLI (`gh`) (recommended, for PR automation)
- Playwright (optional, for visual review skill)

### Version History Highlights

| Version | Date | Key Changes |
|---|---|---|
| 0.1.0 | Feb 2026 | Initial release: 18 agents, 5 skills, 7 commands |
| 0.3.0 | Feb 2026 | Orchestrated execution loop, adversarial review, work unit decomposition |
| 0.5.0 | Feb 2026 | Team Mode, Plan Review Gate, 6 development guides |
| 0.6.0 | Feb 2026 | External AI tool delegation (Codex CLI, Gemini CLI), cross-model review |
| 0.8.0 | Feb 2026 | Workflow enforcement, context recovery, BEADS persistence |
| 0.9.0 | Feb 2026 | Claude Code marketplace distribution, setup/migrate/status skills |
| 0.10.0 | Feb 2026 | Native Gemini + Codex packages, cross-platform installer |

## User Sentiment

### Hacker News (Show HN)

The Show HN post received **5 points and 2 comments**. One commenter noted: "This actually looks substantial unlike most of the AI agent grifting I see on HN." Another asked about Claude's upcoming native swarms feature and whether it could replace the BEADS dependency. The low engagement is partially explained by the project's niche audience (users of AI coding CLIs) and its newness.

### Reddit

No direct Reddit posts about metaswarm were found. However, the broader context of Claude Code multi-agent orchestration is extremely active on r/ClaudeAI and r/ClaudeCode. Key related discussions include:

- Users building DIY swarm orchestration with Claude Code (multi-agent via tmux, git worktrees)
- Interest in Claude Code's native Agent Teams feature (announced alongside Opus 4.6)
- Frustration with CLAUDE.md instructions being ignored by agents ("CLAUDE.md says MUST use agent -- Claude ignores it 80% of the time")
- Discussions about race conditions in parallel agent setups -- a problem metaswarm addresses via BEADS coordination

### Twitter / X

No specific metaswarm posts were found on Twitter/X within the past month.

### LinkedIn

Dave Sifry has an active LinkedIn presence (linkedin.com/in/dsifry) primarily focused on Warmstart.ai, his current company. No metaswarm-specific LinkedIn posts were detected, though the project acknowledgments link to his profile.

## Competitive Landscape

### Direct Competitors (AI Coding Orchestration)

| Tool | Focus | Agents | Cross-Model | Knowledge Base | License |
|---|---|---|---|---|---|
| **Metaswarm** | Claude Code / Gemini / Codex orchestration | 18 | Yes (Claude + Codex + Gemini) | JSONL + BEADS | MIT |
| **Claude Code Agent Teams** (native) | Built-in Claude Code multi-agent | Dynamic | No (Claude only) | No persistent KB | Proprietary |
| **Claude Squad** | TUI for parallel Claude sessions | N/A (manual) | No | No | MIT |
| **Hyperpowers** | Claude Code skill system | Configurable | No | No | MIT |
| **Obra Superpowers** | Claude Code skill framework | Configurable | No | No | MIT |

### Broader Multi-Agent Frameworks

| Framework | Focus | Language | Approach |
|---|---|---|---|
| **OpenAI Swarm** | Educational multi-agent | Python | Lightweight handoffs |
| **CrewAI** | General multi-agent | Python | Role-based agents |
| **LangGraph** | Agent state machines | Python | Graph-based orchestration |
| **MetaGPT** | Software company simulation | Python | Role-playing agents |
| **Swarms (kyegomez)** | Enterprise orchestration | Python | Framework-agnostic |

### Key Differentiators vs. Competitors

1. **CLI-native, not SDK-based**: Metaswarm uses markdown prompts and shell scripts, not a Python SDK. Agents are readable text files that can be edited by anyone.
2. **Cross-model adversarial review**: The only framework in this space that routes code review to a different LLM than the one that wrote the code.
3. **Production extraction**: Unlike educational or demo frameworks, metaswarm was extracted from a system that shipped hundreds of production PRs with 100% test coverage.
4. **Self-learning loop**: Post-merge knowledge extraction and conversation introspection create a feedback loop that improves agent behavior over time.
5. **BEADS integration**: Git-native task tracking eliminates the need for external project management tools.

### Overlap with Claude Code Native Features

The announcement of Claude Code's native **Agent Teams** feature (spawning coordinated swarms via `TeamCreate`/`SendMessage`) creates both competition and synergy. Metaswarm already uses these primitives when available (Team Mode in v0.5.0) but provides a much more opinionated workflow on top of them. The native feature handles agent spawning; metaswarm handles the 11-phase workflow, quality gates, knowledge persistence, and cross-model review that the native feature does not provide.

## Pros and Cons

| Pros | Cons |
|---|---|
| Production-proven with 127+ autonomous PRs and 100% test coverage | Requires BEADS CLI dependency for full functionality |
| Cross-platform: Claude Code, Gemini CLI, Codex CLI | Very new (1 month old); small community (87 stars) |
| Cross-model adversarial review eliminates single-model blind spots | Heavy process overhead -- not suitable for quick fixes |
| Self-learning knowledge base improves over time | Steep learning curve with 18 agents, 13 skills, 15 commands |
| MIT licensed and fully open-source | Token-intensive: running 6 parallel reviewers burns credits |
| Blocking quality gates prevent shortcuts | Depends on BEADS which itself is a young project |
| Git-native: no external services required | No established community or third-party ecosystem yet |
| Context recovery survives session interruption | Markdown-based agents may be fragile to prompt engineering changes |
| Human-in-the-loop at configurable checkpoints | Overlap with Claude Code's native Agent Teams may cause confusion |

## Sources

1. [dsifry/metaswarm - GitHub](https://github.com/dsifry/metaswarm) -- Primary repository (87 stars, 8 forks, MIT)
2. [Metaswarm Official Site](https://dsifry.github.io/metaswarm/) -- Documentation and feature overview
3. [Show HN: 127 PRs to Prod this wknd with 18 AI agents](https://news.ycombinator.com/item?id=46864977) -- Hacker News launch post
4. [dsifry/metaswarm-marketplace - GitHub](https://github.com/dsifry/metaswarm-marketplace) -- Claude Code plugin marketplace
5. [dsifry/metaswarm-introduction-preso - GitHub](https://github.com/dsifry/metaswarm-introduction-preso) -- Introduction presentation
6. [Dave Sifry - LinkedIn](https://www.linkedin.com/in/dsifry/) -- Creator profile
7. [BEADS by Steve Yegge - GitHub](https://github.com/steveyegge/beads) -- Core dependency
8. [Superpowers by Jesse Vincent - GitHub](https://github.com/obra/superpowers) -- Foundational skills framework
9. [Claude Code Agent Teams docs](https://code.claude.com/docs/en/agent-teams) -- Native competing feature
10. [r/ClaudeAI multi-agent discussions](https://www.reddit.com/r/ClaudeAI/) -- Community sentiment on swarm orchestration
