---
topic: OpenCode
slug: opencode-cli
date: 2026-03-25
sources: [github, reddit, twitter, linkedin, web]
---

# OpenCode Research Report

## Overview

OpenCode is a fully open-source AI coding agent designed for the terminal, currently developed by the Anomaly team (the organization behind SST, the popular serverless framework). The project lives at [anomalyco/opencode](https://github.com/anomalyco/opencode) with its website at [opencode.ai](https://opencode.ai), and has accumulated approximately 95K-112K GitHub stars as of March 2026, making it one of the most popular open-source coding agents in the ecosystem. It is available as an npm package (`opencode-ai`), via Homebrew, Scoop, Chocolatey, pacman, Nix, and a direct install script. A desktop app (BETA) is also available for macOS, Windows, and Linux.

The project has a notable origin story. The name "OpenCode" was originally used by Kujtim Hoxha's Go-based TUI tool (at `opencode-ai/opencode`), which earned 11K+ stars. When the Anomaly/SST team launched their own project under the same name, the original was archived, and the original author joined the Charm team, continuing development as [Crush](https://github.com/charmbracelet/crush). The current OpenCode is a TypeScript + Go rewrite with a substantially different architecture -- a client/server model where the server runs as a daemon that persists between terminal sessions, meaning you can SSH back in and resume exactly where you left off.

OpenCode positions itself as a provider-agnostic alternative to Claude Code, supporting 75+ LLM providers through the AI SDK and Models.dev, including Anthropic Claude, OpenAI, Google Gemini, Groq, AWS Bedrock, Azure OpenAI, OpenRouter, GitHub Copilot, and local models via Ollama. It features built-in LSP (Language Server Protocol) integration, custom commands, a rules system (with fallback support for Claude Code's file conventions), hooks, themes, and IDE extensions for VS Code and Cursor. The project also offers "OpenCode Go," its own subscription plan providing access to models for international users.

## Technical Analysis

**Architecture:** OpenCode employs a client/server architecture that is a key differentiator. The server exposes an OpenAPI 3.1 spec, enabling programmatic interaction. This design supports multiple frontends: the TUI (primary), a web interface (`opencode --server`), IDE extensions, a desktop app, and even a community-built iOS client. The ACP (Agent Client Protocol) server support enables integration with JetBrains IDEs and other tools.

**Agents:** The current version ships with three agents: **build** (default, full-access development agent), **plan** (read-only analysis agent that denies file edits and prompts for bash permission), and **general** (a subagent for complex searches and multistep tasks, invokable via `@general`). Users can create custom agents with specific prompts, models, and tool access. The community has developed specialized configurations for architect, reviewer, and planning roles.

**Tool Integration:** OpenCode provides file and code tools (glob, grep, ls, view, write, edit, patch, diagnostics), shell execution (bash), URL fetching, Sourcegraph code search across public repos, Exa AI web search, and a sub-agent tool. MCP (Model Context Protocol) support enables extensibility through external tool servers via stdio and SSE transports.

**Installation & Platform Support:** Multiple installation paths are available -- npm, Homebrew, Scoop, Chocolatey, pacman, Nix, Go, and direct curl install. Windows support is via WSL. The desktop app uses platform-native packaging (.dmg, .exe, .deb, .rpm, AppImage).

**Codebase:** Per Hacker News discussion, the TypeScript codebase is described as "extremely large and complex" and "fairly resource inefficient (often uses 1GB of RAM or more for a TUI)." Reddit users report 12-15W power draw compared to 7W for lighter alternatives like Qwen Code/Gemini CLI.

## User Sentiment

**Positive:**
- Provider flexibility is the most praised feature -- users value being able to use any LLM without vendor lock-in
- TUI quality is considered best-in-class among terminal coding agents
- Client/server architecture with session persistence is a unique and appreciated feature
- Built-in LSP support is a differentiator that competitors lack
- Free and open-source nature (only pay API costs) appeals to cost-conscious developers
- Active community with r/opencodeCLI subreddit, Discord, and 60.2K X/Twitter followers
- Growing ecosystem: awesome-opencode list, iOS client, desktop app, Neovim plugin, monitoring tools

**Negative/Mixed:**
- Resource consumption is the most common complaint -- 1GB+ RAM and high CPU usage for a terminal app
- The name controversy with the original OpenCode project (now Crush) left some community members uneasy
- Anthropic briefly blocked OpenCode from accessing the Claude API in early 2026, raising questions about dependence on commercial APIs for an open-source tool (access was later restored)
- Some users report configuration complexity, especially with non-Anthropic providers (multiple "agent coder not found" issues on GitHub)
- Copilot integration has authentication issues (open PRs attempting fixes)
- Context window limitations on large codebases are not always communicated gracefully

**Reddit Consensus:** OpenCode is considered the strongest free terminal coding agent for developers who want model flexibility. Many users combine it with other tools -- Aider for systematic refactoring, Claude Code for the best single-model experience, and OpenCode for interactive sessions and exploratory work.

## Competitive Landscape

| Tool | Provider Lock-in | Open Source | Stars | Strengths | Weaknesses |
|------|-----------------|-------------|-------|-----------|------------|
| **OpenCode** | None (75+ providers) | Yes | ~95-112K | Provider flexibility, TUI quality, LSP, client/server | Resource heavy, complex codebase |
| **Claude Code** | Anthropic only | No | N/A | Best single-model experience, deep integration | Vendor lock-in, subscription required |
| **Codex CLI** | OpenAI only | Yes | N/A | GPT-5.3 Codex-Spark, lightweight | Provider lock-in |
| **Aider** | Multiple | Yes | High | Git-native workflows, systematic refactoring | Less polished TUI |
| **Crush** | Multiple | Yes | Growing | Lightweight Go binary, Charm ecosystem | Smaller community, newer |
| **Gemini CLI** | Google only | Yes | N/A | Free tier, low resource usage | Provider lock-in |
| **GitHub Copilot CLI** | GitHub/MS | No | N/A | Native GitHub integration, GA 2026 | Subscription required |

OpenCode occupies a unique niche as the most popular provider-agnostic, open-source terminal coding agent. Its main competition comes from Claude Code (which dominates on quality for Anthropic models) and lighter-weight alternatives (Aider, Crush, Qwen Code) that trade features for efficiency.

## Pros and Cons

| Pros | Cons |
|------|------|
| 100% open source, MIT licensed | High resource consumption (1GB+ RAM, 12-15W power draw) |
| 75+ LLM providers including local models | Complex TypeScript codebase may deter contributors |
| Client/server architecture with session persistence | Name controversy with original OpenCode/Crush project |
| Built-in LSP support for code intelligence | Configuration can be complex for non-Anthropic providers |
| Polished TUI with themes and customizable keybinds | Anthropic API blocking incident raises dependency concerns |
| Desktop app (BETA) and IDE extensions | Large codebase for what is fundamentally a TUI tool |
| Active community (60K+ X followers, dedicated subreddit) | Context window handling on large codebases needs improvement |
| Custom agents, commands, hooks, and rules | IDE integration is still secondary to terminal experience |
| MCP and ACP protocol support for extensibility | Some open issues around Copilot auth and provider config |
| Free to use (pay only API costs) | Desktop app is still in beta |

## Sources

### GitHub
- [anomalyco/opencode](https://github.com/anomalyco/opencode) -- Current active repository (TypeScript rewrite by Anomaly/SST team)
- [opencode-ai/opencode](https://github.com/opencode-ai/opencode) -- Original Go-based repo (archived, continued as Crush)
- [charmbracelet/crush](https://github.com/charmbracelet/crush) -- Continuation of original project by Charm team
- [awesome-opencode/awesome-opencode](https://github.com/awesome-opencode/awesome-opencode) -- Curated resource list
- [openchamber/openchamber](https://github.com/openchamber/openchamber) -- Desktop/web interface
- [grapeot/opencode_ios_client](https://github.com/grapeot/opencode_ios_client) -- iOS client

### Reddit
- [r/opencodeCLI](https://www.reddit.com/r/opencodeCLI/) -- Dedicated subreddit
- [r/LocalLLaMA: Is opencode the best free coding agent?](https://www.reddit.com/r/LocalLLaMA/comments/1rcjzsk/is_opencode_the_best_free_coding_agent_currently/)
- [r/LocalLLaMA: OPENCODE - Like Claude Code but works with local models](https://www.reddit.com/r/LocalLLaMA/comments/1lv9yhq/opencode_like_claude_code_or_gemini_cli_but_works/)
- [r/programming: How Coding Agents Actually Work: Inside OpenCode](https://www.reddit.com/r/programming/comments/1q2aqyn/how_coding_agents_actually_work_inside_opencode/)

### Twitter/X
- [@opencode](https://x.com/opencode) -- 60.2K followers, primary account
- [@OpenCode_AI](https://x.com/opencode_ai) -- Original project account (inactive, redirects to Crush)

### LinkedIn
- [Introducing Opencode: An Open-Source AI Coding Agent](https://www.linkedin.com/posts/shubhamsaboo_i-found-an-open-source-ai-coding-agent-built-activity-7352162027827617792-9pCN)
- [OpenCode with Docker Model Runner for Private AI Coding](https://www.linkedin.com/pulse/opencode-docker-model-runner-private-ai-coding-docker-mmv9c)

### Web
- [OpenCode Official Docs](https://opencode.ai/docs/)
- [OpenCode Review: Go CLI Terminal Coding Agent With 75+ Models](https://www.openaitoolshub.org/en/blog/opencode-review-terminal-ai-coding)
- [We Tested 15 AI Coding Agents (2026)](https://www.morphllm.com/ai-coding-agent)
- [Aider vs OpenCode: Best Open-Source AI Coding CLI in 2026](https://www.nxcode.io/resources/news/aider-vs-opencode-ai-coding-cli-2026)
- [OpenCode vs Codex CLI (2026)](https://www.morphllm.com/comparisons/opencode-vs-codex)
- [Claude Code vs OpenCode CLI Comparison](https://docs.bswen.com/blog/2026-03-23-claude-code-vs-opencode-comparison/)
- [Claude Code vs OpenCode (2026)](https://www.infralovers.com/blog/2026-01-29-claude-code-vs-opencode/)
- [Setup OpenCode AI Coding Agent](https://computingforgeeks.com/setup-opencode-ai-coding-agent/)
- [OpenCode -- Grokipedia](https://grokipedia.com/page/opencode)
- [OpenCode on Hacker News](https://news.ycombinator.com/item?id=47460525)
- [Can This Open Source AI Coding Agent Replace Claude Code?](https://www.heyuan110.com/posts/ai/2026-03-13-opencode-ai-coding-agent-review/)
- [Top 5 CLI Coding Agents in 2026](https://dev.to/lightningdev123/top-5-cli-coding-agents-in-2026-3pia)
- [The 2026 Guide to Coding CLI Tools](https://www.tembo.io/blog/coding-cli-tools-comparison)

---
*Generated by Research Agent on 2026-03-25*
