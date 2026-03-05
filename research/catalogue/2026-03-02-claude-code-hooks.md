---
topic: Claude Code Hooks
slug: claude-code-hooks
date: 2026-03-02
sources: [github, reddit, twitter, linkedin, web]
---

# Claude Code Hooks Research Report

## Overview

Claude Code hooks are user-defined shell commands, HTTP endpoints, or LLM prompts that execute automatically at specific points in Claude Code's lifecycle. Introduced in mid-2025 and rapidly iterated since, hooks provide **deterministic control** over an inherently probabilistic AI coding assistant — the crucial distinction being that unlike CLAUDE.md instructions (which are advisory and may be ignored), hooks are guaranteed to execute every time their trigger fires. The system exposes 13 lifecycle events spanning session management, tool execution, subagent orchestration, and context compaction, making it arguably the most powerful extensibility mechanism in any AI coding tool today.

The feature has generated substantial community enthusiasm. A Reddit post by Karan Bansal calling hooks "Claude Code's Most Underrated Feature" was cross-posted across r/ClaudeCode, r/ClaudeAI, and r/Anthropic, sparking extensive discussion about practical use cases. The ecosystem has matured rapidly: disler's claude-code-hooks-mastery repo (3.2K stars) provides a complete reference implementation, a TypeScript SDK exists for type-safe development, a Ruby gem eliminates JSON parsing pain, and HookLab (Feb 2026) offers a live dashboard for the newest HTTP hook type. However, a recent Check Point Research disclosure (CVE-2025-59536, CVE-2026-21852) revealed that malicious hooks in cloned repositories could auto-execute, highlighting that hooks' power demands security awareness.

## Technical Analysis

### The 13 Hook Lifecycle Events

| Event | When It Fires | Can Block? | Key Use Case |
|-------|--------------|------------|-------------|
| **Setup** | Repo init or periodic maintenance | No | Environment persistence, context injection |
| **SessionStart** | New/resumed/cleared session | No | Load dev context, git status |
| **SessionEnd** | Exit, sigint, or error | No | Session logging, cleanup |
| **UserPromptSubmit** | User submits prompt (before Claude processes) | Yes (exit 2) | Prompt validation, context injection, security filtering |
| **PreToolUse** | Before tool execution | Yes (exit 2 or JSON decision) | Block dangerous commands, parameter validation |
| **PostToolUse** | After successful tool completion | Feedback only | Auto-formatting, logging, result validation |
| **PostToolUseFailure** | After tool execution fails | No | Error logging, structured diagnostics |
| **PermissionRequest** | Permission dialog shown | Yes (auto-allow/deny) | Auto-approve read-only ops, audit logging |
| **Notification** | Claude sends notification | No | Sound alerts, Slack/voice notifications |
| **Stop** | Claude finishes responding | Yes (force continuation) | Task completion validation, TDD enforcement |
| **SubagentStart** | Subagent spawns | No | Spawn logging, resource tracking |
| **SubagentStop** | Subagent finishes | Yes | Subagent completion validation |
| **PreCompact** | Before context compaction | No | Transcript backup, context preservation |

### Three Hook Handler Types

1. **Command hooks** (`"type": "command"`): Execute shell commands. Receive JSON on stdin, communicate via exit codes and stdout/stderr. Most common and flexible.
2. **Prompt hooks** (`"type": "prompt"`): LLM-evaluated prompts that assess tool calls. Claude evaluates the prompt and returns a decision. Useful for nuanced safety checks.
3. **HTTP hooks** (`"type": "http"`): POST to URL endpoints. Newest addition enabling external service integration and dashboards like HookLab.

### Flow Control Mechanisms

- **Exit code 0**: Success, stdout shown in transcript
- **Exit code 2**: Blocking error — stderr fed back to Claude (PreToolUse blocks tool, UserPromptSubmit blocks prompt, Stop forces continuation)
- **JSON output**: Structured decisions (`"decision": "approve"|"block"|"ask"`) with reasons, input modification, and system messages
- **Async mode**: Hooks can run in background without blocking Claude's execution
- **60-second timeout** per hook, all matching hooks run in parallel

### Key GitHub Repositories

| Repository | Stars | Focus |
|-----------|-------|-------|
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 25.8K | Curated ecosystem list |
| [claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery) | 3.2K | Complete 13-event reference implementation |
| [claude-code-hooks-multi-agent-observability](https://github.com/disler/claude-code-hooks-multi-agent-observability) | 1.2K | Real-time agent monitoring via hooks |
| [claudekit](https://github.com/carlrannaberg/claudekit) | 617 | Custom commands, hooks, utilities toolkit |
| [claude-code-hook-sdk](https://github.com/mizunashi-mana/claude-code-hook-sdk) | — | TypeScript SDK for type-safe hooks |

### Security Vulnerabilities (Patched)

Check Point Research disclosed critical vulnerabilities in Feb 2026:
- **CVE-2025-59536** (CVSS 8.7): Code injection via malicious Hook commands in `.claude/settings.json` — auto-executed on project init
- **CVE-2026-21852**: Related RCE and API key exfiltration path
- **Fixed** in Claude Code v1.0.87+ (September 2025)
- **Implication**: Always review `.claude/settings.json` when cloning repositories; hooks execute with full user shell permissions

## User Sentiment

**Overall: Very Positive**

- **Reddit**: Enthusiastic adoption. Multiple threads describe hooks as "game changer" and "most underrated feature." Community actively shares configurations. Pain points: initial confusion about 13 events (addressed by community guides), JSON parsing ergonomics (addressed by Ruby gem and TypeScript SDK). Top use cases: safety guards, auto-formatting, notification sounds, git automation.
- **Twitter/X**: Minimal presence. Claude Code discourse concentrated on Reddit and LinkedIn.
- **LinkedIn**: Professional educators and DevRel creating guides and courses. Andrew Ng promoted a Claude Code course covering hooks. Multiple comparison articles (hooks vs MCP, hooks vs Kiro steering).

## Competitive Landscape

Claude Code hooks have no direct equivalent in competing AI coding tools:

| Tool | Equivalent Feature | Gap |
|------|-------------------|-----|
| **Kiro (AWS)** | "Steering files" with natural language hooks | Fewer lifecycle events, IDE-only |
| **GitHub Copilot CLI** | No hook system | GA Feb 2026, no extensibility yet |
| **Cursor** | Rules files (.cursorrules) | Advisory only, not deterministic |
| **Windsurf** | Custom rules | No lifecycle event hooks |
| **Aider** | Pre-commit hooks only | Limited to git hooks |

The 13-event lifecycle with three handler types (command, prompt, HTTP) plus async support and JSON flow control is unique to Claude Code. This is a genuine competitive moat.

## Pros and Cons

| Pros | Cons |
|------|------|
| Deterministic control over AI behavior | 13 events can overwhelm beginners |
| Three handler types (command, prompt, HTTP) | JSON parsing ergonomics need improvement |
| Async hooks don't block execution | Security risk if .claude/settings.json not reviewed |
| Rich ecosystem of reference repos and guides | 60-second timeout may limit complex hooks |
| Can approve/block/modify tool calls | Stop hook blocking can cause infinite loops |
| Works with any language (Python, Bash, TS, Ruby) | No built-in hook marketplace/sharing mechanism |
| Unique competitive advantage — no rival matches it | Prompt hooks add latency (LLM evaluation) |

## Sources

### GitHub
- https://github.com/disler/claude-code-hooks-mastery
- https://github.com/disler/claude-code-hooks-multi-agent-observability
- https://github.com/hesreallyhim/awesome-claude-code
- https://github.com/carlrannaberg/claudekit

### Reddit
- https://www.reddit.com/r/ClaudeCode/comments/1qlzzzf/
- https://www.reddit.com/r/ClaudeAI/comments/1qlzxr1/
- https://www.reddit.com/r/ClaudeCode/comments/1p48uil/
- https://www.reddit.com/r/ClaudeCode/comments/1m865de/
- https://www.reddit.com/r/ClaudeCode/comments/1lx9oxp/
- https://www.reddit.com/r/ClaudeAI/comments/1m083kb/

### LinkedIn
- https://www.linkedin.com/pulse/claude-code-just-dropped-hooks-its-change-how-you-automate-cameron-giare
- https://www.linkedin.com/pulse/claude-code-primer-mcp-vs-hooks-raphael-sisa-5t00c

### Web
- https://code.claude.com/docs/en/hooks
- https://karanbansal.in/blog/claude-code-hooks/
- https://www.datacamp.com/tutorial/claude-code-hooks
- https://blog.gitbutler.com/automate-your-ai-workflows-with-claude-code-hooks
- https://www.oreilly.com/radar/auto-reviewing-claudes-code/
- https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/
- https://felipeelias.github.io/2026/02/28/hook-lab.html

---
*Generated by Research Agent on 2026-03-02*
