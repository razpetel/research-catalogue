---
topic: Get Shit Done (GSD)
slug: get-shit-done
date: 2026-03-05
prior_report: 2026-02-02
sources: [github, reddit, twitter, linkedin, web]
---

# Get Shit Done (GSD) Research Report

*Updated from [prior report (2026-02-02)](2026-02-02-get-shit-done.md). Focus areas: latest version, parallel execution, verification/quality gates, inter-task communication, mem0/persistent memory integration.*

## Overview

Get Shit Done (GSD) has grown dramatically since our February 2 report, nearly tripling its GitHub stars from 10.5K to 24.7K and advancing from v1.11.1 to v1.22.4 across 30 days of intense development. The repository has moved from the creator's personal account (glittercowboy) to a dedicated organization (gsd-build), signaling maturation. It now supports five runtimes: Claude Code, OpenCode, Gemini CLI, Codex, and (community-ported) GitHub Copilot.

The most significant technical addition since our last report is the **Nyquist Validation Layer** -- a new system that maps automated test coverage to each phase requirement *before* any code is written, enforced as the 8th dimension in plan verification. Combined with the existing planner-checker verification loop, wave-based parallel execution, and new model profiles (quality/balanced/budget), GSD has evolved from a clever meta-prompting framework into a comprehensive development orchestration system with formal quality gates at every stage.

Regarding the user's question about "dshills": no GitHub user or contributor by that name was found associated with GSD. The project creator remains TÂCHES (glittercowboy), and the repo is now under the gsd-build organization.

## Technical Analysis

### Repository Health

| Metric | Feb 2, 2026 | Mar 5, 2026 | Change |
|--------|-------------|-------------|--------|
| Stars | 10,500 | 24,656 | +135% |
| Forks | 1,000 | 2,110 | +111% |
| Open Issues | 139 | 258 | +86% |
| Version | v1.11.1 | v1.22.4 | +11 minor versions |
| License | MIT | MIT | -- |
| Agents | ~8 | 12 | +4 |
| Commands | ~15 | 31 | +16 |
| Runtimes | 3 | 5 | +2 |
| Status | Very Active | Very Active | -- |

### Parallel Execution Architecture

GSD's parallel execution system works through **wave-based orchestration**:

1. **Dependency analysis**: The orchestrator analyzes plan dependencies to determine which tasks are independent
2. **Wave grouping**: Independent plans are grouped into the same wave; dependent plans go into later waves
3. **Parallel execution within waves**: All plans in a wave run simultaneously, each in a fresh 200K-token context window
4. **Sequential waves**: Wave N+1 only starts after Wave N completes
5. **Atomic commits**: Each task gets its own git commit immediately after completion

```
Wave 1 (parallel): Plan 01 + Plan 02    (independent)
Wave 2 (parallel): Plan 03 + Plan 04    (depend on Wave 1)
Wave 3 (sequential): Plan 05            (depends on Wave 2)
```

The design philosophy favors "vertical slices" (end-to-end features per plan) over "horizontal layers" (all models, then all APIs) because vertical slices parallelize better across waves.

**Key insight**: The main context window stays at 30-40% capacity while execution happens in subagent contexts. The orchestrator is a thin coordinator that spawns, waits, and integrates -- it never does heavy lifting itself.

### Verification & Quality Gates (5 Layers)

GSD now implements five distinct quality gates:

| Layer | When | Mechanism |
|-------|------|-----------|
| **1. Plan Checker** | After planning, before execution | Planner creates plans, checker verifies against requirements. Loop up to 3x until pass. |
| **2. Nyquist Validation** (NEW) | During plan-phase research | Maps every requirement to a specific test command. Creates VALIDATION.md. Enforced as 8th plan-check dimension -- plans without automated verify commands are rejected. |
| **3. Execution Verification** | After each wave | Verifier agent checks codebase against phase goals. PASS creates VERIFICATION.md; FAIL logs issues. |
| **4. Cold-Start Smoke Test** (NEW) | During verify-work | Auto-injected for phases that modify server, database, seed, or startup files. Catches warm-state blind spots. |
| **5. User Acceptance Testing** | After execution | `/gsd:verify-work` walks through testable deliverables one-by-one. Failures spawn debug agents that create fix plans. |

Additionally, `/gsd:audit-milestone` verifies the entire milestone meets its definition of done, and `/gsd:validate-phase` retroactively audits and fills test coverage gaps for phases executed before Nyquist existed.

### Inter-Task Communication

GSD uses **file-based inter-task communication exclusively** -- agents never communicate directly:

| File | Purpose | Scope |
|------|---------|-------|
| `PROJECT.md` | Project vision, always loaded by every agent | Global |
| `REQUIREMENTS.md` | Scoped v1/v2 requirements with IDs and traceability | Global |
| `ROADMAP.md` | Phase breakdown with status tracking | Global |
| `STATE.md` | Decisions, blockers, position -- memory across sessions | Global |
| `{phase}-CONTEXT.md` | User's implementation preferences from discuss-phase | Per-phase |
| `{phase}-RESEARCH.md` | Domain research findings | Per-phase |
| `{phase}-{N}-PLAN.md` | Atomic task plans with XML structure | Per-plan |
| `{phase}-{N}-SUMMARY.md` | Execution outcomes per plan | Per-plan |
| `{phase}-VERIFICATION.md` | Post-execution verification results | Per-phase |
| `{phase}-VALIDATION.md` | Nyquist test coverage mapping | Per-phase |
| `config.json` | Workflow configuration (mode, granularity, model_profile) | Project |

Session persistence is handled through `/gsd:pause-work` (creates handoff context) and `/gsd:resume-work` (restores state). Git commits serve as the ultimate persistence -- every completed task is committed atomically.

### mem0 / Persistent Memory Integration

**No mem0 integration exists.** Zero references to mem0 anywhere in the GSD codebase (agents, commands, workflows, or references directories). GSD's approach to memory is entirely file-based:

- **Session memory**: STATE.md tracks decisions, blockers, and position
- **Cross-session persistence**: Git commits + /gsd:pause-work and /gsd:resume-work
- **Project knowledge**: PROJECT.md, REQUIREMENTS.md, ROADMAP.md travel with every agent interaction
- **Codebase knowledge**: /gsd:map-codebase creates STACK.md, ARCHITECTURE.md, CONVENTIONS.md, CONCERNS.md

This is a deliberate architectural choice. GSD externalizes all state to readable, version-controlled files rather than relying on external memory services. Reddit users sometimes pair GSD with graph-memory or Beads for additional context management, but GSD itself has no such integration.

### Model Profiles (New Since Feb 2)

| Agent | Quality | Balanced (default) | Budget |
|-------|---------|-------------------|--------|
| gsd-planner | Opus | Opus | Sonnet |
| gsd-roadmapper | Opus | Sonnet | Sonnet |
| gsd-executor | Opus | Sonnet | Sonnet |
| gsd-phase-researcher | Opus | Sonnet | Haiku |
| gsd-verifier | Sonnet | Sonnet | Haiku |
| gsd-plan-checker | Sonnet | Sonnet | Haiku |
| gsd-integration-checker | Sonnet | Sonnet | Haiku |
| gsd-nyquist-auditor | -- | -- | -- |

### New Since Feb 2: Key Features

- **Codex CLI support** -- 5th runtime via skills-based installation
- **Git branching strategies** -- none/phase/milestone with configurable templates
- **`/gsd:map-codebase`** -- Brownfield support: parallel agents analyze stack, architecture, conventions, concerns
- **`/gsd:audit-milestone`** -- Definition-of-done verification
- **`/gsd:health --repair`** -- Directory integrity validation and auto-repair
- **`/gsd:reapply-patches`** -- Restore local modifications after updates (backup system since v1.17)
- **`/gsd:list-phase-assumptions`** -- Preview Claude's intended approach before planning
- **`--auto` flag** -- `/gsd:new-project --auto @prd.md` for automated init from documents
- **Granularity setting** -- coarse (3-5 phases), standard (5-8), fine (8-12)
- **$GSD Solana token** -- Linked in README, listed on Dexscreener

## User Sentiment

**Overall: Strongly Positive** (consistent with Feb 2 report, now with broader adoption evidence)

### Reddit (Primary Community)

**Praise (intensifying):**
- "Claude Code with 4.6 and techniques like Get Shit Done can do all this in like 20 minutes and in much higher quality than any human team I've ever seen"
- "For major features, refactors, and things I haven't fully thought out yet, I have found Get Shit Done (GSD) to be pivotal"
- Senior engineer: "I get quite bored answering hundreds upon hundreds of questions, but the end result is usually great"

**Concerns (persistent):**
- Token consumption remains the #1 complaint; Pro plan often insufficient
- "At first attempts reached Claude Pro plan limits very quickly using GSD framework"
- Vanilla Claude Code is catching up: "It will switch to plan, research, clear context, implement and test all on its own"
- Some users building alternatives (SuperBeads, agent-agnostic orchestrators) inspired by GSD's limitations

### Twitter/X

Minimal. Activity concentrated on Reddit, Discord, and Threads. Official @gsd_foundation account exists.

### LinkedIn

Improved visibility since Feb 2. Multiple individual engineers sharing GSD experiences publicly (Girish S, Mauvis Ledford, Seth Sandler, Max Buckley). No enterprise case studies visible.

### Threads

Seth Sandler's post about completing a 23-plan project with GSD and the "Lean Orchestrator" pattern was widely shared.

### International

Bilibili video (Chinese) with deep-dive claiming "21K stars in 2 months." Spanish and Italian coverage expanding.

## Competitive Landscape

| Alternative | GSD Advantage | Alternative Advantage |
|-------------|---------------|----------------------|
| **Vanilla Claude Code** | Structured workflow, formal quality gates, parallel execution | Zero setup, improving native capabilities |
| **BMAD** | Lighter weight, stronger community | More structured for large teams |
| **ralph** | Full project lifecycle vs. single-task loops | Simpler mental model, overnight autonomy |
| **Auto-Claude** | More mature, smaller bug surface | Visual Kanban UI, 12 parallel agents |
| **multiclaude** | More structured planning and verification | Git worktree isolation, auto-merge |
| **SuperBeads** | Broader ecosystem, more battle-tested | Works on Pro plan without hitting limits |
| **Conductor** | More active development since Feb | Lighter weight |

The competitive field has shifted: vanilla Claude Code itself is improving (native plan mode, memory, context clearing), potentially reducing the need for external frameworks. However, GSD's multi-stage verification (Nyquist + plan-checker + verifier + UAT) remains unmatched.

## Pros and Cons

| Pros | Cons |
|------|------|
| Solves context rot effectively via fresh 200K subagent contexts | Token-heavy -- often requires Max plan, Pro plan insufficient |
| 5-layer verification system (plan-check, Nyquist, execution verify, cold-start smoke test, UAT) | 258 open issues indicate growing maintenance burden |
| Wave-based parallel execution with dependency analysis | Discuss phase can be exhausting ("hundreds of questions") |
| 5 runtime support (Claude Code, OpenCode, Gemini, Codex, Copilot) | $GSD Solana token in README raises questions about project direction |
| Configurable model profiles (quality/balanced/budget) | Vanilla Claude Code catching up on native capabilities |
| Brownfield support via /gsd:map-codebase | Learning curve remains steep for new users |
| Active development (11 minor versions in ~30 days) | File-based communication has no formal conflict resolution |
| 24.7K stars, strong community, Discord, educational courses | No persistent memory integration (mem0 or similar) |

## Key Insights

**What it is:** The dominant meta-prompting and context engineering framework for Claude Code, now at v1.22.4 with 24.7K stars and 12 specialized agents.

**What changed (since Feb 2):** Stars doubled to 24.7K. Nyquist Validation Layer adds pre-execution test coverage mapping. Model profiles enable quality/cost tradeoffs. Codex support added. Git branching strategies formalized. Repo moved to gsd-build org.

**Parallel execution:** Wave-based system grouping independent plans for simultaneous execution in fresh 200K contexts, with sequential wave dependencies. Orchestrator stays thin at 30-40% context.

**Verification gates:** Five layers: plan-checker loop (3x), Nyquist validation (test mapping), execution verifier, cold-start smoke test, and user acceptance testing. The most comprehensive quality gate system in the Claude Code ecosystem.

**Inter-task communication:** Entirely file-based via `.planning/` directory. STATE.md serves as session memory. Git commits provide persistence. No direct agent-to-agent communication.

**mem0 integration:** None. GSD deliberately uses file-based state management. Users occasionally pair it with external memory tools (graph-memory, Beads), but GSD has no built-in support.

**"dshills" connection:** None found. The creator is TÂCHES (glittercowboy). No GitHub user "dshills" is associated with the project.

**Bottom line:** GSD has solidified its position as the most feature-rich Claude Code orchestration framework. The Nyquist validation layer and 5-layer verification system are genuine differentiators. The main risks are token consumption (making it impractical on lower plans), growing issue count, and the $GSD token raising questions about long-term project governance. For developers on Claude Max who want structured, verifiable AI-assisted development, GSD remains the top choice.

## Sources

### GitHub
- https://github.com/gsd-build/get-shit-done
- https://www.npmjs.com/package/get-shit-done-cc
- https://github.com/gsd-build/get-shit-done/blob/main/CHANGELOG.md
- https://github.com/gsd-build/get-shit-done/blob/main/docs/USER-GUIDE.md

### Reddit
- https://www.reddit.com/r/ClaudeCode/comments/1r59hz2/why_ai_still_cant_replace_developers_in_2026/
- https://www.reddit.com/r/ClaudeCode/comments/1r2vakt/dear_senior_software_engineer_are_you_still/
- https://www.reddit.com/r/ClaudeCode/comments/1qxfprh/gsd_vs_superpowers_vs_speckit_what_are_you_using/
- https://www.reddit.com/r/ClaudeCode/comments/1qg615b/is_get_shit_done_gsd_via_claude_code_feasible_on/
- https://www.reddit.com/r/vibecoding/comments/1ralbzk/i_loved_the_idea_of_gsd_for_project_planning_but/
- https://www.reddit.com/r/GithubCopilot/comments/1qvv7lh/gsd_get_shit_done_now_works_with_github_copilot/
- https://www.reddit.com/r/ClaudeCode/comments/1qps9xj/how_do_you_all_deal_with_claudes_small_context/

### Web/News
- https://agentnativedev.medium.com/get-sh-t-done-meta-prompting-and-spec-driven-development-for-claude-code-and-codex-d1cde082e103
- https://medium.com/@parvemayur/get-shit-done-gsd-how-one-developer-built-a-system-to-make-ai-code-actually-work-c2023dc0bc38
- https://www.codecentric.de/en/knowledge-hub/blog/the-anatomy-of-claude-code-workflows-turning-slash-commands-into-an-ai-development-system
- https://deepwiki.com/gsd-build/get-shit-done
- https://ccforeveryone.com/gsd

### LinkedIn
- https://www.linkedin.com/posts/girish-s-16b4b91a6_claudecode-aiagents-devtools-activity-7416057263422988288-6X5m
- https://www.linkedin.com/pulse/how-get-shit-done-claude-gsd-plugin-mauvis-ledford-z7pwc
- https://www.linkedin.com/posts/sethsandler_github-glittercowboyget-shit-done-a-light-weight-activity-7424687215697362944-oPdQ

### Social
- https://www.threads.com/@sethsandler/post/DUUlWlwkehB/

---
*Generated by Research Agent on 2026-03-05 (update of 2026-02-02 report)*
