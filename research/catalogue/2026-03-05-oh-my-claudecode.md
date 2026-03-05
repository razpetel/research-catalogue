---
topic: oh-my-claudecode
slug: oh-my-claudecode
date: 2026-03-05
sources: [github, reddit, twitter, linkedin, web]
---

# oh-my-claudecode (OMC) Research Report

## Overview

oh-my-claudecode (OMC) is a multi-agent orchestration plugin for Claude Code created by Yeachan Heo, a Korean developer. Branded as "Teams-first Multi-agent orchestration for Claude Code" with a "zero learning curve," it provides 32 specialized agents, 40+ skills, and multiple execution modes that transform a single Claude Code session into a coordinated AI development team.

Created January 9, 2026, it has grown to 8,452 GitHub stars and 588 forks in under two months -- making it the fastest-growing Claude Code orchestration framework. The project is actively maintained with daily commits (last push: March 5, 2026) and is currently at version 4.7.0. It installs as a Claude Code plugin via the marketplace and is published to npm as `oh-my-claude-sisyphus`.

The project was inspired by oh-my-opencode and has itself spawned several derivatives: oh-my-droid (Factory AI Droid port), oh-my-claudecode-slim (50-70% fewer tokens), oh-my-ccg (combined with CCG), and community guide websites.

## Technical Analysis

### Architecture

OMC is built in TypeScript with key dependencies including `@anthropic-ai/claude-agent-sdk`, `better-sqlite3` (local state), `@modelcontextprotocol/sdk`, and `zod` for schema validation. It operates as a Claude Code plugin that overlays orchestration behavior via skills (SKILL.md files), agents (Markdown prompt files), and hooks (shell scripts).

The architecture follows a conductor pattern: the lead Claude session reads the AGENTS.md system prompt, which defines delegation rules, agent routing, keyword detection, and execution protocols. Specialized agents are defined as Markdown prompt files in the `agents/` directory, each with a focused role and behavioral constraints.

### Execution Modes

| Mode | Type | Description | Parallelism |
|------|------|-------------|-------------|
| **Team** (recommended) | Staged pipeline | `team-plan -> team-prd -> team-exec -> team-verify -> team-fix` | N coordinated agents |
| **omc team (CLI)** | tmux workers | Real `claude`/`codex`/`gemini` processes in split panes | On-demand spawn |
| **ccg** | Tri-model advisors | ask-codex + ask-gemini, Claude synthesizes | Fan-out to 3 providers |
| **Autopilot** | Autonomous | Single lead agent, end-to-end feature work | Sequential with delegation |
| **Ultrawork** | Max parallelism | Burst parallel fixes/refactors | Up to 6 concurrent agents |
| **Ralph** | Persistent loop | Verify/fix loops until complete (includes ultrawork) | Iterative with parallelism |
| **Pipeline** | Sequential | Staged processing with strict ordering | Sequential |
| **Ultrapilot** | Legacy | Deprecated compatibility alias for autopilot pipeline | 3-5x parallel |

As of v4.1.7, **Team** is the canonical orchestration surface. The legacy `swarm` keyword was removed and replaced by `team`. v4.4.0 removed Codex/Gemini MCP servers in favor of tmux CLI workers that spawn on demand and terminate when their task completes.

### Agent Catalog (32 Agents)

Agents are organized into lanes:

**Build/Analysis Lane:**
explore, analyst, planner, architect, debugger, executor, verifier, deep-executor

**Review Lane:**
style-reviewer, quality-reviewer, api-reviewer, security-reviewer, performance-reviewer, code-reviewer

**Domain Specialists:**
dependency-expert, test-engineer, quality-strategist, build-fixer, designer, writer, qa-tester, git-master, researcher, document-specialist, scientist, code-simplifier

**Product Lane:**
product-manager, ux-researcher, information-architect, product-analyst

**Coordination:**
critic, harsh-critic, vision

### Parallel Execution Capabilities

- **Up to 6 concurrent child agents** via `spawn_agent` tool
- **Team mode** distributes work through a staged pipeline with N workers
- **tmux CLI workers** (v4.4.0+) spawn real Claude/Codex/Gemini CLI processes in split panes
- **Parallelization rule:** Run 2+ independent tasks in parallel when each takes >30s; run dependent tasks sequentially
- **Background execution** for installs, builds, and tests
- **Event-driven Team Runtime v2** (v4.7.0): Dispatch queues, monitoring, and scaling modules with 5,000+ lines of orchestration infrastructure

### Verification & Quality Gates

OMC implements a multi-layered verification system:

1. **Team Pipeline Verification:** The canonical `team-verify` stage runs after `team-exec` completes. Verification decides whether to proceed to `team-fix` (loop back), `complete`, or `failed`. The `team-fix` loop is bounded by max attempts.

2. **Ralph Persistence Mode:** Self-referential verify/fix loop that refuses to stop until the job is verified complete. Enforces a "ralplan-first" gate -- no implementation until PRD + test spec artifacts exist.

3. **Evidence-Based Verification:** Sizing guidance scales verification effort:
   - Small changes (<5 files, <100 lines): lightweight verifier
   - Standard changes: standard verifier
   - Large/security/architectural changes (>20 files): thorough verifier

4. **Continuation Check:** Before concluding, confirms: zero pending tasks, all features working, tests passing, zero errors, verification evidence collected.

5. **Visual Verification:** For UI tasks, `visual-verdict` skill runs every iteration with numeric scoring and qualitative feedback persisted in `.omc/state/`.

6. **UltraQA Skill:** Dedicated QA cycling -- test, verify, fix, repeat.

### Inter-Task Communication

Communication between agents and tasks uses several mechanisms:

1. **File-Based State Management:** `.omc/` directory with JSON state files, per-mode tracking (ralph, autopilot, ultrawork, team, ecomode, ultraqa).

2. **MCP Tools:** `state_read`, `state_write`, `state_clear`, `state_list_active`, `state_get_status` for programmatic state access.

3. **Notepad System:** `.omc/notepad.md` with priority/working/manual sections for session-persistent notes shared across agents.

4. **Project Memory:** `.omc/project-memory.json` for cross-session project knowledge, with `project_memory_read/write/add_note/add_directive` MCP tools.

5. **Event-Driven Runtime (v4.7.0):** Direct tmux spawn with CLI API inbox replaces watchdog/done.json polling. New modules: `dispatch-queue.ts`, `events.ts`, `monitor.ts`, `scaling.ts`, `mcp-comm.ts`, `team-ops.ts`.

6. **Hooks-Based Integration:** Shell script hooks for lifecycle events (start, stop, phase transitions).

7. **Shared Task Pool:** In Team/Swarm mode, agents pull from a shared task list where each agent claims atomic tasks to prevent duplicate work.

### Memory & Persistence (NOT Mem0)

OMC implements its **own memory system** -- it does NOT integrate with Mem0. The memory architecture includes:

- **`.omc/project-memory.json`**: Cross-session project knowledge (notes, directives)
- **`.omc/notepad.md`**: Session-persistent notes with priority/working/manual sections
- **`.omc/state/`**: Mode state files (JSON) tracking active modes, iterations, phases
- **`.omc/plans/`**: Planning documents (PRDs, test specs)
- **`.omc/logs/`**: Audit logs and agent replay logs

Additionally, the **writer-memory** skill provides a specialized creative writing memory system for tracking characters, relationships, scenes, and themes in a `.writer-memory/memory.json` file -- designed with Korean storytelling workflows in mind.

The **learner** skill extracts reusable patterns from sessions for automatic skill extraction.

### Smart Model Routing

Three-tier delegation optimized for cost:
- **Haiku** (LOW): Simple tasks -- preferred for most work
- **Sonnet** (MEDIUM): Standard implementation, debugging, reviews
- **Opus** (HIGH): Architecture, deep analysis, complex reasoning -- used sparingly

Claims 30-50% token savings through Ecomode's intelligent routing.

### Multi-AI Provider Support

v4.4.0+ supports orchestrating external AI providers:
- **Codex CLI** (OpenAI): Architecture validation, code review cross-check
- **Gemini CLI** (Google): Design review, UI consistency (1M token context)
- **ccg skill**: Tri-model fan-out where Claude synthesizes results from Codex + Gemini
- Cost estimate: ~$60/month for 3 Pro plans (Claude + Gemini + ChatGPT)

### Notification System

Supports stop callbacks for session summaries via:
- Telegram (with @mention tagging)
- Discord (webhook with user IDs, role mentions)
- Slack (webhook with member IDs, channels, subteams)
- File-based output

## User Sentiment

**Overall: Positive (with caveats)**

### Strengths Cited
- "Zero learning curve" -- natural language interface, no commands to memorize
- Hooks-based integration means no ToS violations (unlike some alternatives)
- Multi-language README shows international community
- Active Korean developer community driving adoption
- Rapid iteration pace (v1 to v4.7 in ~2 months)
- Multiple execution modes for different use cases

### Concerns Cited
- **Bug density:** Issue #301 found 15 bugs in v3.9.5 via stress testing (4 critical, 6 high) including state file cleanup issues, database locks, and race conditions
- **Token consumption:** Reddit users report orchestration overhead can significantly increase token usage
- **Loop termination:** Some users report runaway loops that do not terminate
- **Rapid churn:** Version velocity (4.7.0 in 2 months) means breaking changes -- migration guide needed for v2.x users
- **Anthropic competition:** Official Agent Teams (research preview, Feb 2026) may obsolete community orchestration tools
- **Community-maintained risk:** jeongil.dev warns "community tools can stop being updated once official features launch"

### Reddit Sentiment
- Referenced frequently in r/ClaudeCode multi-agent discussions
- Compared favorably to oh-my-opencode for Claude Code compatibility
- Some pushback: "OmO feels like it's running in loops, taking long hours to finish a feature that Claude one-shots in a single prompt"
- Agent Teams announcement (185 upvotes, 41 comments) drew attention away

### Web/Blog Sentiment
- "Legal Doping for Claude Code" (sonim1.com) -- enthusiastic but focused review
- "The Only Agents Swarm Orchestration You Need" (Medium/Joe Njenga) -- positive endorsement
- Korean tech blog community actively producing tutorials and guides
- paddo.dev lists OMC among the 3 key community multi-agent solutions alongside claude-flow and ccswarm

## Competitive Landscape

| Framework | Stars | Focus | Key Differentiator |
|-----------|-------|-------|-------------------|
| **oh-my-claudecode** | 8.4K | Full orchestration | 32 agents, 7 modes, zero config |
| **Get Shit Done (GSD)** | 10.5K | Meta-prompting | Fresh 200k-token subagent contexts |
| **Auto-Claude** | 11.1K | Visual Kanban | 12 parallel agents, Docker-based |
| **OrchestKit** | 53 | Full toolkit + memory | 196 skills, Mem0 integration |
| **cc10x** | 69 | Minimalist | 4 workflows, TDD-enforced |
| **multiclaude** | 457 | tmux/worktrees | Go-based, CI auto-merge |
| **Agent Teams (official)** | N/A | Native Claude Code | Built-in, mailbox comms |

### OMC Positioning
- **vs GSD:** OMC offers structured modes and agent specialization; GSD focuses on meta-prompting with fresh contexts
- **vs Auto-Claude:** OMC is plugin-based (no Docker); Auto-Claude is visual but buggier
- **vs OrchestKit:** OMC has larger community (8.4K vs 53 stars) but no Mem0 integration
- **vs Agent Teams (official):** OMC has more modes and agents but faces obsolescence risk from official feature

## Pros and Cons

| Pros | Cons |
|------|------|
| 8.4K stars, very active development | Rapid churn: v4.7 in 2 months, breaking changes |
| 32 specialized agents with role-based routing | Bug density: 15 bugs found in stress test of v3.9.5 |
| Multiple execution modes for different tasks | Token consumption overhead from orchestration |
| Zero config -- works with natural language | Anthropic Agent Teams may obsolete this |
| Smart model routing saves 30-50% tokens | No Mem0 or external memory integration |
| Multi-AI support (Codex, Gemini) | Community-maintained, single core maintainer |
| Hooks-based: no ToS violations | Runaway loop reports from some users |
| Rich notification system (Telegram/Discord/Slack) | Korean-centric docs may limit accessibility |
| MIT licensed, spawning derivatives | Ultrapilot deprecated already (fast deprecation cycle) |

## Recommendation

oh-my-claudecode is the current frontrunner among community-built Claude Code orchestration frameworks, with strong growth (8.4K stars in < 2 months) and comprehensive multi-agent capabilities. It is best suited for:

1. **Developers wanting structured multi-agent workflows** without building their own orchestration
2. **Team/parallel execution scenarios** where tasks can be decomposed across specialized agents
3. **Multi-provider users** who want Claude + Codex + Gemini synthesis
4. **Users who value zero-configuration** natural language interfaces

**Caution advised** for:
- Production-critical workflows (stress testing revealed significant bugs)
- Users concerned about long-term stability (Anthropic's official Agent Teams may supersede)
- Token-sensitive users (orchestration overhead is real)

**No Mem0 integration exists** -- if cross-session semantic memory is critical, consider combining OMC with a separate memory solution (e.g., OrchestKit's approach, or standalone Mem0 MCP server).

Watch the project for v5.0, which the build scripts reference with deprecation notices for Codex/Gemini MCP servers. The event-driven team runtime v2 in v4.7.0 signals a maturing architecture, but the rapid pace of breaking changes requires users to stay current.

## Sources

### Primary
- https://github.com/Yeachan-Heo/oh-my-claudecode
- https://www.npmjs.com/package/oh-my-claude-sisyphus
- https://yeachan-heo.github.io/oh-my-claudecode-website

### Technical Articles
- https://adambernard.com/kb/oh-my-claude-code-omc-agent-swarm-orchestration/
- https://sonim1.com/en/blog/oh-my-claudecode
- https://jeongil.dev/en/blog/trends/claude-code-agent-teams/
- https://aibit.im/blog/post/oh-my-claudecode-boost-claude-code-with-multi-agent-automation
- https://paddo.dev/blog/claude-code-hidden-swarm/

### GitHub Issues
- https://github.com/Yeachan-Heo/oh-my-claudecode/issues/301
- https://github.com/Yeachan-Heo/oh-my-claudecode/issues/602
- https://github.com/Yeachan-Heo/oh-my-claudecode/issues/971

### Community
- https://playbooks.com/skills/yeachan-heo/oh-my-claudecode/omc-help
- https://playbooks.com/skills/yeachan-heo/oh-my-claudecode/ecomode

### Derivatives
- https://github.com/MeroZemory/oh-my-droid
- https://github.com/woosikkim/oh-my-claudecode-slim

### Reddit Discussions
- https://www.reddit.com/r/ClaudeCode/comments/1q9dmxd/multiagent_orchestration_for_parallel_work_tools/
- https://www.reddit.com/r/opencodeCLI/comments/1r5bopx/oh_my_opencode_vs_gsd_vs_others_vs_claude_cli_vs/
- https://www.reddit.com/r/ClaudeCode/comments/1qws3hj/introducing_agent_teams_research_preview/

### LinkedIn
- https://kr.linkedin.com/posts/dohyun-jung-b66b8262_oh-my-claude-code-claude-code%EB%A5%BC-%ED%8C%80%EC%9C%BC%EB%A1%9C-%EC%93%B0%EB%8A%94-activity-7419731384572882945--W2P
- https://www.linkedin.com/posts/yeachan-heo-225b02219_github-yeachan-heooh-my-claudecode-multi-agent-activity-7422242139142512640--wx2

### Social
- https://www.threads.com/@bellman.pub/post/DU65ow_ErPL

---
*Generated by Research Agent on 2026-03-05*
