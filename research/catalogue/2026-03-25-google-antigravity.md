---
topic: Google Antigravity
slug: google-antigravity
date: 2026-03-25
sources: [github, reddit, twitter, linkedin, web]
---

# Google Antigravity Research Report

## Overview

Google Antigravity is an agent-first AI IDE announced November 2025 alongside the Gemini 3 model family, available at antigravity.google. Built as a VS Code fork, it differentiates itself through two primary views: **Editor View** (standard IDE with an agent sidebar) and **Manager View** (a multi-agent orchestration control center that can run up to 5 parallel agents simultaneously). It represents Google's most aggressive move into the vibe-coding space, directly competing with Cursor, Claude Code, and Windsurf.

Antigravity supports 5 LLMs out of the box: Gemini 3.1 Pro (High/Low), Gemini 3 Flash, Claude Sonnet 4.6, Claude Opus 4.6, and GPT-OSS 120B. Its **SWE-bench Verified score of 76.2%** places it among the highest publicly benchmarked AI coding tools. In March 2026, Google shut down Firebase Studio in favor of Antigravity, consolidating its developer IDE strategy. The platform added MCP (Model Context Protocol) support in early 2026, and AgentKit 2.0 brought 16 specialized agents with modular skills and "Semantic Triggering" for token efficiency.

The community response has been enthusiastic but qualified. Reddit users praise the Agent Manager feature as "amazing" and say "Cursor and Codex launcher can't compete," but also report issues with rate limits, agents deleting files unexpectedly, and a "half-baked" feel in some areas. The free tier is unusually generous, making it the most accessible premium-quality AI IDE available.

## Technical Analysis

- **Architecture:** VS Code fork with Editor View + Manager View (multi-agent orchestration)
- **Models:** Gemini 3.1 Pro (High/Low), Gemini 3 Flash, Claude Sonnet 4.6, Claude Opus 4.6, GPT-OSS 120B
- **Benchmark:** 76.2% SWE-bench Verified
- **MCP support:** Added early 2026, connecting to external tools/services (GitHub, databases, APIs)
- **AgentKit 2.0:** 16 specialized agents, modular skills, Semantic Triggering for token efficiency
- **Agent MD / Gemini MD:** Rules files for agent configuration (similar to CLAUDE.md)
- **Firebase integration:** Full-stack backend (databases, auth, hosting) in-browser
- **No official open-source repo** — closed-source product with growing community ecosystem (11+ community repos on GitHub)
- **Official X account** (@antigravity) has 132K followers but zero posts — unusual for a major Google product

## User Sentiment

**Overall: Mixed-to-Positive**

- **Reddit:** Active community on r/google_antigravity. Agent Manager is the standout feature — "holy is it amazing." But safety concerns (agents deleting files), rate limits on free tier, and "half-baked" edges noted. Multiple users recommend "Antigravity for quick prototyping + Claude Code for complex tasks" as the optimal 2026 setup.
- **Twitter/X:** Official @antigravity account has 132K followers but zero posts. Buzz is mainly through Google I/O coverage and developer blog posts. Less organic developer advocacy compared to Cursor or Claude Code.
- **LinkedIn:** Growing enterprise interest. Google Developer Experts publishing guides. Medium articles from Google Cloud community. Professional discourse around "agent-first IDE" paradigm shift.

## Competitive Landscape

| Competitor | Antigravity Advantage | Competitor Advantage |
|-----------|----------------------|---------------------|
| Cursor | Free tier, multi-agent Manager View, multi-model | Cursor has deeper codebase indexing, larger community, Composer 2 model |
| Claude Code | GUI, parallel agents, Firebase backend | Claude Code has higher SWE-bench (80.8%), MCP ecosystem, subagent teams |
| Windsurf | Free tier, Google backing, more models | Windsurf has Cascade context, established enterprise base |
| v0 | Full IDE, backend support, multi-language | v0 has higher code quality (9/10), Vercel deployment moat |

## Pricing

| Tier | Price | Models | Limits |
|------|-------|--------|--------|
| Free | $0 | Flash only | 50 requests/day |
| Pro | $20-25/mo | All models | Higher limits |
| Ultra | $249.99/mo | All models + priority | Highest limits |
| Enterprise | $45/user/mo | Custom | SLA, admin controls |

## Pros and Cons

| Pros | Cons |
|------|------|
| Free tier with real capabilities | Rate limits frustrate power users |
| 5 parallel agents in Manager View | Agents sometimes delete files unexpectedly |
| Multi-model support (Gemini + Claude + GPT-OSS) | "Half-baked" feel in some areas |
| Firebase integration for full-stack | No official open-source repo |
| 76.2% SWE-bench Verified | Smaller community than Cursor/Claude Code |
| Google backing = long-term viability | Firebase Studio shutdown = forced migration |
| AgentKit 2.0 with Semantic Triggering | Enterprise pricing unclear/in flux |
| MCP support | Official X account dormant (0 posts, 132K followers) |

## Sources

- https://en.wikipedia.org/wiki/Google_Antigravity
- https://www.openaitoolshub.org/en/blog/google-antigravity-review
- https://vibecoding.app/blog/google-antigravity-review
- https://juliangoldie.com/google-antigravity-ai-ide/
- https://www.geeky-gadgets.com/google-antigravity-agentkit-2026/
- https://awesomeagents.ai/reviews/review-google-antigravity/
- https://www.heyuan110.com/posts/ai/2026-03-10-google-antigravity-review/
- https://medium.com/google-cloud/the-era-of-agentic-ai-first-ides-with-google-antigravity-323e55bca593
- https://abit.ee/en/artificial-intelligence/google-ai-studio-antigravity-vibe-coding-gemini-firebase-studio-ide-app-development-2026-en
- https://www.sourcetrail.com/software/ide/google-ai-studio-evolves-into-a-full-stack-vibe-coding-platform-with-antigravity-and-firebase/

---
*Generated by Research Agent on 2026-03-25*
