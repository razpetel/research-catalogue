---
topic: OpenAI Codex
slug: openai-codex
date: 2026-03-25
sources: [github, reddit, twitter, linkedin, web]
---

# OpenAI Codex Research Report

## Overview

OpenAI Codex is a cloud-based AI coding agent that launched in May 2025 and has rapidly evolved into one of the two dominant AI coding tools alongside Anthropic's Claude Code. The open-source CLI repository (github.com/openai/codex) has amassed 67,518 stars and 9,036 forks, with an extraordinarily active development cadence -- multiple alpha releases per day as of March 2026. Originally written in TypeScript, the CLI has been rewritten in Rust and is licensed under Apache-2.0.

Codex operates across four product surfaces: Codex Web (cloud-based agent at chatgpt.com/codex), Codex CLI (terminal-based local agent), IDE extensions (VS Code, Cursor, Windsurf), and a native desktop app for macOS and Windows. The cloud agent runs tasks in isolated sandbox environments, typically completing in 1-30 minutes, while the CLI provides OS-level sandboxing with configurable security modes. The system is powered by a succession of increasingly capable models: the original codex-1 (based on o3 with RL optimization), GPT-5.2-Codex, GPT-5.3-Codex (February 2026), and the latest GPT-5-codex variant announced on March 25, 2026.

March 2026 has been a pivotal month for Codex. OpenAI acquired Astral (creators of the Python tools uv and ruff) to cover the full developer workflow from dependency management to code review. The company confirmed plans to merge ChatGPT, Codex, and the Atlas browser into a single "superapp," with Codex first gaining productivity capabilities beyond coding. Subagents reached general availability with default roles for "explorer," "worker," and "default." Meanwhile, OpenAI is shutting down Sora to redirect resources into the superapp vision.

## Technical Analysis

### Architecture
Codex uses a two-phase runtime model for cloud tasks: a setup phase with network access for installing dependencies, followed by an agent phase that runs offline by default. Secrets are available only during setup and are removed before the agent phase starts. The agent loop at the center of the system cycles through reasoning, tool calling, and code generation, with prompt caching and smart context compaction to manage long sessions. The CLI uses stateless API calls, supporting zero data retention and privacy-first configurations.

### Sandbox & Security
The CLI provides three sandbox modes: read-only, workspace-write, and danger-full-access. AGENTS.md files provide layered project-level instructions. However, a March 2026 HelpNetSecurity study found that Claude Code, Codex, and Gemini all repeat "decade-old security mistakes" when building applications from scratch, with researchers scanning every PR submitted by the agents.

### Models & Performance
- **GPT-5.3-Codex** (Feb 2026): State-of-the-art on SWE-bench Pro with a 25% speed improvement over its predecessor
- **Token efficiency**: Codex uses approximately 3x fewer tokens than Claude Code for equivalent tasks
- **Terminal-Bench 2.0**: Codex leads at 77.3% vs Claude Code's 65.4%
- **HumanEval**: Claude Code edges ahead at 92% vs 90.2%
- **SWE-bench**: Claude Code leads at 72.7% vs 69.1%

### Ecosystem
The skills ecosystem has its own official repo (openai/skills, 15,309 stars) with a curated catalog. Skills originated as a Claude Code feature but became an open standard via agentskills.io, which OpenAI adopted. The codex-action GitHub Action (891 stars) enables CI/CD integration. A rich community ecosystem includes orchestrators (codex-orchestrator, codexia), cross-agent tools (Mysti for Claude+Codex collaboration in VS Code), and shared configuration repos.

### Pricing
- **ChatGPT Plus**: $20/mo (30-150 messages per 5-hour window)
- **ChatGPT Pro**: $200/mo (higher limits)
- **Business**: $30/user/mo
- **Enterprise**: Custom
- **API**: GPT-5.2-Codex at $1.25/1M input tokens, $10.00/1M output tokens

## User Sentiment

**Reddit** sentiment is broadly positive but with significant caveats. The most-discussed GitHub issue (#14593, 237 comments) is titled "Still burning tokens very fast with today's VS Code extension update," reflecting a persistent user frustration with token consumption rates. Users praise the cloud-based parallelism, VS Code integration, and the ability to handle entire codebases in a sandbox. However, the deep integration with OpenAI's ecosystem makes it nearly impossible to use with other models -- a community attempt to fork Codex for custom model support was abandoned due to the deep coupling.

Sam Altman has stated that "almost all new code written at OpenAI today is from Codex users," and Steven Heidel (OpenAI APIs team) revealed the Agent Builder was built in 6 weeks with Codex writing 80% of PRs. Skeptics on Reddit counter that these are "smart typing assistants" and the job remains the same.

**LinkedIn** coverage is more enterprise-positive, with adoption signals from Stripe, Vercel, Notion, and Linear. Codex is appearing in job descriptions, indicating it has moved beyond early-adopter phase. A growing ecosystem of consultants and trainers now specialize in Codex/Claude Code workflows.

The dedicated **r/OpenaiCodex** subreddit has 6,300+ subscribers, and the community actively discusses AGENTS.md configuration, custom skills, and workflow optimization.

A clear **hybrid workflow pattern** has emerged: many developers use Claude Code for initial feature generation and architecture decisions, then switch to Codex for code review, debugging, and terminal-heavy tasks where it excels.

## Competitive Landscape

| Tool | Approach | Strengths | Stars |
|------|----------|-----------|-------|
| **OpenAI Codex** | Cloud-first + local CLI | Parallelism, token efficiency, enterprise backing, superapp vision | 67.5K |
| **Claude Code** | Local-first terminal | Accuracy benchmarks, 1M context window, Agent Teams, hooks ecosystem | N/A (closed) |
| **Cursor** | IDE-native | Interactive editing, inline diffs, familiar IDE UX | N/A (closed) |
| **GitHub Copilot** | IDE extension | Ubiquity, GitHub integration, free tier | N/A (closed) |
| **Windsurf** | IDE (acquired by OpenAI) | Cascade flow, formerly Codeium | N/A (uncertain future) |
| **OpenCode** | Open-source terminal | Model-agnostic, community-driven | Growing |

OpenAI's acquisition of Astral and the superapp merger signal a strategy to own the entire developer workflow. The Windsurf acquisition (from Codeium) gives OpenAI an IDE foothold, though community reaction has been mixed. The competitive dynamic increasingly favors a two-horse race between Codex and Claude Code, with developers adopting both for different strengths.

## Pros and Cons

| Pros | Cons |
|------|------|
| 67.5K GitHub stars, massive adoption and community | High token consumption is a recurring complaint (237-comment issue) |
| Cloud parallelism: multiple agents on multiple tasks simultaneously | Deeply locked to OpenAI models; near-impossible to use alternatives |
| 3x better token efficiency than Claude Code | 2,274 open issues suggest quality/stability challenges at scale |
| Open-source CLI (Apache-2.0, Rust) | $200/mo Pro tier needed for serious usage; Plus limits hit quickly |
| Native desktop app for macOS and Windows | Cloud dependency for full power; CLI alone is less capable |
| Strong enterprise adoption (Stripe, Vercel, Notion, Linear) | Security research shows agents still produce vulnerable code |
| Skills ecosystem with open standard (agentskills.io) | Superapp vision may dilute coding focus |
| Astral acquisition strengthens Python tooling story | Windsurf acquisition future uncertain, confusing product lineup |
| Multiple model tiers (GPT-5, 5.2, 5.3, 5-codex) | Rapid model churn can break workflows |
| Active development: multiple releases per day | Still in alpha (v0.117.0-alpha.17) despite massive usage |

## Sources

### GitHub
- [openai/codex](https://github.com/openai/codex) - 67,518 stars, primary repository
- [openai/skills](https://github.com/openai/skills) - 15,309 stars, skills catalog
- [openai/codex-universal](https://github.com/openai/codex-universal) - 836 stars, Docker base image
- [openai/codex-action](https://github.com/openai/codex-action) - 891 stars, GitHub Action

### Official Documentation
- [OpenAI Codex](https://openai.com/codex/)
- [Codex Developer Docs](https://developers.openai.com/codex)
- [Codex Pricing](https://developers.openai.com/codex/pricing)
- [ChatGPT Release Notes](https://help.openai.com/en/articles/6825453-chatgpt-release-notes)

### News & Analysis
- [Fast Company: Inside OpenAI's fast-growing Codex](https://www.fastcompany.com/91498841/openai-codex-growing-fast-agentic-engineering) (2026-02-27)
- [ByteByteGo: How OpenAI Codex Works](https://blog.bytebytego.com/p/how-openai-codex-works) (2026-03-18)
- [MacRumors: OpenAI Superapp to Merge ChatGPT, Codex, and Atlas](https://macrumors.com/2026/03/20/openai-super-app-in-development-chatgpt/) (2026-03-20)
- [WinBuzzer: OpenAI Acquires Astral](https://winbuzzer.com/2026/03/22/openai-acquires-astral-python-tools-codex-xcxwbn/) (2026-03-22)
- [HelpNetSecurity: AI coding agents repeat decade-old security mistakes](https://www.helpnetsecurity.com/2026/03/13/claude-code-openai-codex-google-gemini-ai-coding-agent-security/) (2026-03-13)
- [Simon Willison: Codex subagents](https://simonwillison.net/2026/Mar/16/codex-subagents/) (2026-03-16)
- [The Neuron: Codex 101 Beginner's Guide](https://www.theneuron.ai/explainer-articles/codex-101-a-beginners-guide-to-openais-coding-agent/) (2026-03-24)
- [NxCode: OpenAI Codex Review 2026](https://www.nxcode.io/resources/news/openai-codex-app-review-2026)
- [NxCode: Codex vs Cursor 2026](https://www.nxcode.io/resources/news/openai-codex-vs-cursor-which-coding-agent-2026)

### Reddit Threads
- [r/singularity: Introducing Codex](https://www.reddit.com/r/singularity/comments/1ko3mxq/openai_introducing_codex_software_engineering/)
- [r/ChatGPTPro: Inside Codex](https://www.reddit.com/r/ChatGPTPro/comments/1qmhubh/inside_codex_how_openais_coding_agent_really_works/)
- [r/artificial: Almost all new code at OpenAI from Codex](https://www.reddit.com/r/artificial/comments/1o07w54/almost_all_new_code_written_at_openai_today_is/)
- [r/singularity: GPT 5.2 Codex launch](https://www.reddit.com/r/singularity/comments/1ppz9ib/openai_just_launched_gpt_52_codex_the_most/)
- [r/ChatGPTCoding: Custom Skills guide](https://www.reddit.com/r/ChatGPTCoding/comments/1ptdtvg/openai_codex_guide_to_creating_and_using_custom/)

### LinkedIn
- [OpenAI for Business: GPT-5.2-Codex announcement](https://www.linkedin.com/posts/openai-for-business_were-introducing-gpt-52-codex-our-most-activity-7407518172204994560-6kIK)
- [Daily News AI Agents: Codex launch analysis](https://www.linkedin.com/pulse/daily-news-ai-agents-key-updates-0517-openai-coding-schwoebel-jkd6e)
- [Dino Cajic: Codex AI Agent Rethinking Software](https://www.linkedin.com/pulse/24-openais-codex-ai-agent-rethinking-software-again-time-dino-cajic-9yfxe)

### Benchmark Sources
- [MorphLLM: Codex vs Claude Code benchmarks](https://www.morphllm.com/comparisons/codex-vs-claude-code)
- [DEV Community: Benchmark Comparison](https://dev.to/shehzan/openai-codex-vs-claude-code-2026-benchmark-comparison-371m)
- [SmartScope: Codex CLI vs Claude Code 2026](https://smartscope.blog/en/generative-ai/chatgpt/codex-vs-claude-code-2026-benchmark/)

---
*Generated by Research Agent on 2026-03-25*
