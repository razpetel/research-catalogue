# SuperBeads Universal Framework

**Date:** 2026-02-04
**Sentiment:** Mixed
**Summary:** Meta-framework combining Beads, Superpowers, and Ralph Wiggum into unified Claude Code methodology with domain-specific packs.

---

## Overview

SuperBeads Universal Framework (with "Wiggum Flavour") is a Claude Code methodology framework by Elia Alberti that bundles proven tools into a systematic approach for AI-assisted development. Rather than creating novel functionality, it integrates existing popular tools (Steve Yegge's Beads for task tracking, obra's Superpowers for workflows, Anthropic's Ralph Wiggum for iteration) and adds domain-specific "packs" with specialized agents and skills.

## Key Details

| Attribute | Value |
|-----------|-------|
| **GitHub** | [EliaAlberti/superbeads-universal-framework](https://github.com/EliaAlberti/superbeads-universal-framework) |
| **Stars** | 21 |
| **Created** | January 13, 2026 |
| **Last Updated** | January 19, 2026 |
| **License** | MIT |
| **Version** | 1.1.0 |

## Architecture

### Four-Agent System

| Agent | Role | Default Model |
|-------|------|---------------|
| **Strategist** | Plans, breaks down work into 10-15 min tasks | Sonnet |
| **Executor** | Builds deliverables using skills | Sonnet |
| **Specialist** | Handles complex domain-specific challenges | Sonnet |
| **Critic** | Reviews, verifies quality | Haiku (5x cheaper) |

### Session Commands

- `/resume` - Loads CLAUDE.md + session logs, supports topic search
- `/preserve` - Updates CLAUDE.md, auto-archives when >280 lines
- `/wrapup` - Quick session endings with summary
- `/compress` - Saves searchable logs before `/compact`

### Domain Packs (5 Available)

Each pack includes 4 specialized agents + 9 skills:

| Pack | Domain | Focus Areas |
|------|--------|-------------|
| **ios** | Swift/SwiftUI | MVVM, accessibility, design tokens |
| **python** | Python | Type hints, FastAPI, pytest, async |
| **web** | React/Next.js | TypeScript, server components |
| **design** | Product Design | WCAG 2.1 AA, design systems, handoffs |
| **pm** | Product Management | INVEST stories, roadmaps, A/B tests |

### Core Principles

1. **Task Discipline:** 10-15 minute atomic tasks, no "and" in titles
2. **Observable Verification:** Every task has verifiable completion signal
3. **Session Memory:** CLAUDE.md persists context across sessions
4. **Atomic Commits:** One commit per task with task ID reference

## What It Combines

| Source | Stars | Contribution |
|--------|-------|--------------|
| [Superpowers](https://github.com/obra/superpowers) (obra) | 42.4K | Skill-based workflows |
| [Beads](https://github.com/steveyegge/beads) (Yegge) | 14.5K | Git-backed task tracking |
| [Ralph Wiggum](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum) | Plugin | Iteration methodology |
| [Beads-Viewer](https://github.com/Dicklesworthstone/beads_viewer) | ~500 | TUI visualization |

## Community Reception

### Reddit Activity

- Author actively promotes in r/ClaudeAI and r/ClaudeCode
- Created to solve Pro plan context loss issues
- One organic mention from non-author user
- No negative feedback but limited discussion

### Social Presence

- **Twitter/X:** None found
- **LinkedIn:** None found
- **News Coverage:** None (though source tools like Beads and Ralph Wiggum have coverage)

## Installation

```bash
git clone https://github.com/EliaAlberti/superbeads-universal-framework.git
cd superbeads-universal-framework
./core/scripts/install-superbeads.sh
source ~/.zshrc
superbeads init
superbeads pack install <pack>  # Optional
```

## Comparison with Alternatives

| Framework | Stars | Differentiator |
|-----------|-------|----------------|
| **SuperBeads** | 21 | Domain packs, unified methodology |
| everything-claude-code | 37K+ | Comprehensive configs, hackathon-validated |
| oh-my-claudecode | 4K+ | 32 specialized agents, 5 execution modes |
| GSD | 10.5K | Meta-prompting, established community |
| Beads (alone) | 14.5K | Pure task tracking, no methodology |
| Superpowers (alone) | 42.4K | Pure skills, no task tracking |

## Strengths

1. **Unified Approach:** Combines best-of-breed tools into single methodology
2. **Domain Packs:** Specialized configurations for iOS, Python, Web, Design, PM
3. **Cost Optimization:** Haiku for reviews, Sonnet for work (models configurable)
4. **Task Board TUI:** Visual project management with dependency graphs
5. **Session Management:** Comprehensive commands for context persistence
6. **Documentation:** Thorough README, GUIDE.md, VISION.md

## Weaknesses

1. **New & Unproven:** 3 weeks old, 21 stars, limited real-world validation
2. **Single Maintainer:** Elia Alberti only, unknown availability
3. **Dependency Risk:** Relies on Beads and Beads-Viewer which are external
4. **No Plugin Format:** Manual git clone installation vs Claude marketplace
5. **Limited Community:** No Twitter presence, minimal Reddit engagement
6. **Overhead:** Full framework may be overkill for simple projects

## Verdict

SuperBeads is a well-documented "meta-framework" that intelligently combines proven Claude Code tools into a unified methodology. The domain packs (iOS, Python, Web, Design, PM) are genuinely useful additions not found in the source tools.

**Best for:**
- Developers wanting a structured, opinionated Claude Code workflow
- Teams working across multiple domains (one framework, multiple packs)
- Users familiar with Beads/Superpowers who want them unified

**Consider alternatives if:**
- You need established community support (use Beads or Superpowers directly)
- You want marketplace installation (wait for plugin format)
- You need simpler setup (just use CLAUDE.md pattern)

**Recommendation:** Interesting for early adopters who appreciate the unified approach. The domain packs add genuine value. However, given its age (3 weeks) and limited adoption (21 stars), wait for more community validation before production use. For most users, the individual source tools (Beads + Superpowers) provide the same functionality with more established support.

## Sources

- [GitHub Repository](https://github.com/EliaAlberti/superbeads-universal-framework)
- [Reddit Launch Post](https://www.reddit.com/r/ClaudeAI/comments/1qbsiw0/superbeads_universal_framework_wiggum_flavour/)
- [Reddit: Superpowers marketplace thread](https://www.reddit.com/r/ClaudeCode/comments/1qgkupf/superpowers_is_now_on_the_official_claude/)
- [Beads by Steve Yegge](https://github.com/steveyegge/beads)
- [Superpowers by obra](https://github.com/obra/superpowers)
