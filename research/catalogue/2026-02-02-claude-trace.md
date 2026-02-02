---
topic: claude-trace
slug: claude-trace
date: 2026-02-02
sources: [github, reddit, twitter, linkedin, web]
---

# claude-trace Research Report

## Overview

claude-trace is a logging and analysis tool that intercepts Claude Code API calls to expose hidden internals—system prompts, tool definitions, extended thinking blocks, and raw request/response pairs. Created by Mario Zechner (badlogic), it's part of the larger "lemmy" monorepo, a TypeScript ecosystem for building AI applications.

The tool addresses a real gap: Claude Code deliberately hides its system prompts and internal operations. claude-trace uses monkey-patching on Node.js's fetch/HTTP libraries to capture everything, outputting to both JSONL logs and self-contained interactive HTML reports. Simon Willison called it "a missing manual" for understanding Claude Code capabilities.

With 1,434 stars on the parent repo and 219K+ views on the announcement tweet, claude-trace has become the go-to tool for power users who want to understand how Claude Code actually works. It's frequently recommended on Reddit for debugging, reverse engineering, and learning Claude Code internals.

## Technical Analysis

### Architecture
- **Interceptor:** Injects into Claude Code, patches fetch() calls
- **Output:** JSONL logs + interactive HTML viewer
- **Location:** `.claude-trace/log-YYYY-MM-DD-HH-MM-SS.{jsonl,html}`

### Capabilities
- System prompts (normally hidden)
- Tool definitions and parameters
- Extended thinking/reasoning blocks
- Token usage with cache statistics
- Complete request/response pairs
- AI-powered conversation summaries (via `--index`)

### Installation
```bash
npm install -g @mariozechner/claude-trace
claude-trace  # Start logging
```

### Key Commands
| Command | Purpose |
|---------|---------|
| `claude-trace` | Basic logging |
| `--include-all-requests` | Capture all API traffic |
| `--index` | Generate AI summaries |
| `--generate-html logs.jsonl report.html` | Manual HTML generation |

### Requirements
- Node.js 16+
- Claude Code CLI installed

### Known Issues (15 open)
- Windows compatibility problems
- macOS latest version issues
- Native binary install failures
- `--index` hangs on some conversations
- Dependency on `/usr/bin/which`

## User Sentiment

**Overall:** Very Positive

### Reddit
- Consistently recommended as THE tool for understanding Claude Code
- Used for serious reverse engineering work
- "Shows exactly how Claude is instructed via Claude Code"
- Fills a gap where no built-in alternative exists

### Twitter
- Announcement received 219K+ views
- High engagement from technical community
- International pickup (Japanese tech community)
- Author's @ClaudeCodeLog bot based on related tool is "tolerated" by Anthropic

### LinkedIn
- Author (Mario Zechner) has strong professional credibility
- Duke's Choice Award 2014 for libGDX
- Active in AI/LLM tooling space
- 500+ connections, technical thought leader

## Competitive Landscape

### Direct Alternatives
| Tool | Focus | Difference |
|------|-------|------------|
| ccusage | Token/cost tracking | Metrics only, no API transparency |
| Claude-Code-Usage-Monitor | Session management | Live tracking, no full logs |
| claude-code-otel | Team observability | Prometheus-based, enterprise focus |
| claude-trace-viewer | Visualization | Alternate UI for claude-trace logs |

### Related Ecosystem (by badlogic)
| Tool | Purpose |
|------|---------|
| cchistory | Track system prompt changes across versions |
| claude-bridge | Replace Claude backend with other LLMs |
| lemmy | TypeScript AI application framework |
| lemmy-tui | Terminal UI components |

### Key Differentiator
claude-trace is **unique** in providing full API transparency. Other tools track usage/costs; claude-trace shows the actual hidden system prompts and complete API traffic.

## Pros and Cons

| Pros | Cons |
|------|------|
| Reveals hidden system prompts | Windows/macOS compatibility issues |
| Interactive HTML reports | Some features hang (--index) |
| Easy npm install | No official license specified |
| Active community adoption | 15 open issues unaddressed |
| Author has strong track record | Last commit 6 months ago |
| Free and open source | Depends on Claude Code internals (fragile) |

## Recommendation

**For Claude Code power users:** Essential tool. Install it if you want to understand what Claude Code is actually doing, debug tool chains, or learn from Anthropic's system prompts.

**For casual users:** Probably overkill. The HTML reports are useful for debugging specific issues, but most users won't need this level of visibility.

**Caveats:** Watch for compatibility issues on Windows/macOS. The tool depends on Claude Code's internal structure, so breaking changes are possible with Claude Code updates.

## Sources

### GitHub
- https://github.com/badlogic/lemmy/tree/main/apps/claude-trace
- https://www.npmjs.com/package/@mariozechner/claude-trace
- https://github.com/bkrabach/claude-trace-viewer

### Reddit
- https://www.reddit.com/r/ClaudeCode/comments/1ogbwts/how_do_i_autosave_every_prompt_response_from/
- https://www.reddit.com/r/ClaudeAI/comments/1nefwic/claude_continue_myth_v_fact/
- https://www.reddit.com/r/ClaudeAI/comments/1lkhpmc/has_anyone_cracked_the_code_to_claude_code/

### Twitter/X
- https://x.com/badlogicgames/status/1929312803799576757 (announcement)
- https://x.com/badlogicgames (author profile)
- https://x.com/ClaudeCodeLog (automated changelog bot)

### Web
- https://simonwillison.net/2025/Jun/2/claude-trace/
- https://www.vibesparking.com/en/blog/ai/claude-code/2025-07-12-claude-code-debugging-tool-claude-trace-transparent-logging/
- https://mariozechner.at/posts/2025-08-03-cchistory/

### LinkedIn
- https://www.linkedin.com/in/mariozechner/

---
*Generated by Research Agent on 2026-02-02*
