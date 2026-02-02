---
topic: Get Shit Done (GSD)
slug: get-shit-done
date: 2026-02-02
sources: [github, reddit, twitter, linkedin, web, hacker-news]
---

# Get Shit Done (GSD) Research Report

## Overview

Get Shit Done (GSD) is a meta-prompting and context engineering framework for Claude Code, OpenCode, and Gemini CLI created by solo developer TÂCHES (glittercowboy). With 10.5k GitHub stars and rapid community adoption, it has become one of the most discussed AI-assisted development frameworks in the Claude Code ecosystem.

The framework addresses "context rot" — the quality degradation that occurs as AI models fill their context windows during extended coding sessions. As David Eastman explained in The New Stack (Jan 2026), research suggests "earlier tokens get more attention than later ones" causing "attention dilution" — "as if the LLM is a bored 6-year-old." GSD solves this through a structured workflow (Discuss → Plan → Execute → Verify) with multi-agent orchestration that keeps the main context window at 30-40% capacity while heavy lifting happens in fresh 200k-token subagent contexts.

Positioned explicitly against "enterprise theater" frameworks like BMAD and Speckit, GSD targets solo developers and small teams who want structured AI-assisted development without sprint ceremonies, story points, or Jira workflows. The tool has gained viral traction through Reddit success stories, including claims of building a "$32,000 company in 40 days" and "$70,000 from vibecoding."

## Technical Analysis

### Repository Health

| Metric | Value |
|--------|-------|
| Stars | 10.5k |
| Forks | 1k |
| Open Issues | 139 |
| License | MIT |
| NPM Package | get-shit-done-cc v1.11.1 |
| Last Commit | 2026-01-31 |
| Status | **Very Active** |

### Architecture

- **Context Engineering**: Structured files (PROJECT.md, REQUIREMENTS.md, ROADMAP.md, STATE.md) travel with every agent interaction
- **Multi-Agent Orchestration**: Parallel research (4 agents), planning (planner + checker), execution, verification
- **XML Prompt Formatting**: Precise task definitions optimized for Claude's XML affinity
- **Atomic Git Commits**: Individual commits per task with phase metadata

### Key Commands

| Command | Purpose |
|---------|---------|
| `/gsd:new-project` | Full initialization: questions → research → requirements → roadmap |
| `/gsd:discuss-phase [N]` | Capture implementation decisions before planning |
| `/gsd:plan-phase [N]` | Research + plan + verify for a phase |
| `/gsd:execute-phase <N>` | Execute all plans in parallel waves |
| `/gsd:verify-work [N]` | Manual user acceptance testing |
| `/gsd:quick` | Ad-hoc tasks with GSD guarantees |

### Installation

```bash
npx get-shit-done-cc
```

Supports Claude Code, OpenCode (open-source models), and Gemini CLI.

## User Sentiment

**Overall: Strongly Positive** with notable caveats

### The New Stack (David Eastman, Jan 31, 2026)

Detailed hands-on walkthrough titled "Beating context rot in Claude Code with GSD":

- **Context rot explained**: Research suggests earlier tokens get more attention than later ones, causing "attention dilution" — "as if the LLM is a bored 6-year-old"
- **Solution approach**: Split problems into tasks for sub-agents while keeping overall context intact
- **Workflow documented**: `/gsd:new -project` initiates interrogation phase extracting requirements through "product-centered" questions
- **Key observation**: Questions were "sensible designer" questions — neither GSD nor author mentioned CRUD directly, yet the system intelligently extracted those requirements
- **Test project**: Built a SwiftUI desktop app for viewing JSON objects despite author never using Swift before
- **Planning output**: PROJECT.md, roadmap, phases, goals, requirements, criteria, verification steps — all auto-generated
- **Author verdict**: "If you're about to ask whether this process made me think harder about what I actually needed, the answer is a definite yes"
- **Series**: Part 1 of 2; Part 2 will examine the resulting SwiftUI application

### Reddit (Primary Community)

Active discussions across r/ClaudeCode, r/ClaudeAI, r/vibecoding, r/opencodeCLI.

**Praise:**
- "By far the most powerful addition to my Claude Code. Nothing over-engineered."
- "I've done SpecKit, OpenSpec and Taskmaster — this has produced the best results for me."
- "GSD is like Plan mode on steroids."

**Concerns:**
- Token consumption can hit Pro plan limits quickly
- Some find the workflow complex initially
- Minority view: "I tried this and it's rubbish. It's much easier and much more effective to just use Claude code directly."

### Hacker News

Mixed reception. Some skeptics critical of "vibe coding slop." One detailed user reported success with:
- Effect pipeline refactoring
- DuckDB error parsing
- Test suite auditing

But noted: "I'm not quite jiving with it yet. I still like working with Claude more like a peer than as a subordinate."

### Twitter/X

Minimal direct Twitter engagement. Activity concentrated on Reddit, YouTube, and Threads.

### LinkedIn

Limited visibility due to login walls. Claims of adoption by engineers at Amazon, Google, Shopify, and Webflow (unverified).

## Competitive Landscape

| Alternative | GSD Advantage | Alternative Advantage |
|-------------|---------------|----------------------|
| **BMAD** | Less "enterprise theater," simpler workflow | More structured for large teams |
| **Speckit/OpenSpec** | Higher community adoption, more testimonials | Multi-platform support |
| **TaskMaster** | Better reported results from users | — |
| **Superpowers plugin** | Full project lifecycle, not just planning | Lighter weight |
| **Conductor** | More active development, easier onboarding | Some users switch post-GSD |

## Pros and Cons

| Pros | Cons |
|------|------|
| Solves context rot effectively | Token-heavy, can hit rate limits |
| Clean multi-agent orchestration | Learning curve for workflow |
| Active development (v1.11.1) | XML prompts optimized for Claude, may degrade with other models |
| Strong community and author support | Some prefer peer-style interaction over task delegation |
| Multi-platform (Claude, OpenCode, Gemini) | 139 open issues indicate some rough edges |
| Atomic commits and clean git history | Requires `--dangerously-skip-permissions` for best experience |

## Key Insights

**What it is:** A meta-prompting framework that manages context windows and orchestrates multi-agent workflows for Claude Code development.

**What's novel:** Fresh 200k-token subagent contexts per task, keeping main context at 30-40% while executing complex projects.

**How it compares:** More practical than enterprise-focused alternatives (BMAD, Speckit), with stronger community adoption and testimonials than competitors.

**Bottom line:** Strong choice for solo developers wanting structured AI-assisted development. Be prepared for token consumption and a learning curve. Not ideal if you prefer collaborative "peer" interaction with AI over delegating to a subordinate system.

## Sources

### GitHub
- https://github.com/glittercowboy/get-shit-done
- https://www.npmjs.com/package/get-shit-done-cc

### Reddit
- https://www.reddit.com/r/ClaudeCode/comments/1qf6vcc/ive_massively_improved_gsd_get_shit_done/
- https://www.reddit.com/r/ClaudeAI/comments/1q4yjo0/get_shit_done_the_1_cc_framework_for_people_tired/
- https://www.reddit.com/r/vibecoding/comments/1q5w5kh/i_used_claude_code_to_launch_a_32000_company_in/
- https://www.reddit.com/r/ClaudeCode/comments/1qjf225/vibecoding_gsd_just_made_me_70000/
- https://www.reddit.com/r/opencodeCLI/comments/1qa8nkx/there_is_my_adaptation_of_getshitdone_for_opencode/

### Hacker News
- https://news.ycombinator.com/item?id=46746231

### Web/News
- https://thenewstack.io/beating-the-rot-and-getting-stuff-done/ (David Eastman, Jan 31, 2026)
- https://medium.com/@joe.njenga/i-tested-gsd-claude-code-meta-prompting-that-ships-faster-no-agile-bs-ca62aff18c04
- https://pasqualepillitteri.it/en/news/169/gsd-framework-claude-code-ai-development
- https://www.nytimes.com/2026/01/23/technology/claude-code.html
- https://scientificamerican.com/article/how-claude-code-is-bringing-vibe-coding-to-everyone
- https://dev.to/chand1012/the-best-way-to-do-agentic-development-in-2026-14mn

### Video
- https://www.youtube.com/watch?v=5L3dm7KBCmY

---
*Generated by Research Agent on 2026-02-02*
