---
topic: Claude-Mem (thedotmack)
slug: claude-mem
date: 2026-02-19
sources: [github, reddit, twitter, linkedin, web]
---

# Claude-Mem Research Report

## Overview

Claude-Mem is the most popular Claude Code plugin by stars (29.2K), created by Alex Newman (@thedotmack). It provides persistent memory across coding sessions by automatically capturing tool usage observations via lifecycle hooks, compressing them into semantic summaries using the Claude Agent SDK, and storing everything locally in SQLite with hybrid search via Chroma vector database. The plugin's core value proposition is solving "agent amnesia" -- the loss of project context when Claude Code sessions end or context windows fill up.

Since our last mention in the Context Engineering report (Feb 2, 2026, when it had ~12.9K stars), claude-mem has more than doubled in popularity, reaching 29.2K stars after three consecutive days on GitHub trending (Feb 4-6). The project has evolved from v6.x to v10.3.1, adding Chroma vector search, MCP search tools with progressive disclosure, OpenClaw gateway integration, and a web viewer UI. However, this rapid growth has also surfaced serious stability issues (218 zombie processes, 51K+ duplicate observations), a controversial $CMEM Solana token prominently displayed in the README, and increasing competitive pressure from both Anthropic's built-in auto-memory features and a proliferating field of 10+ alternative memory plugins.

The project is genuinely useful -- its hook-based architecture requires zero manual intervention, and the 3-layer progressive disclosure pattern is architecturally sound. But the combination of crypto token promotion, unresolved bugs, AGPL-3.0 licensing, and the threat of official feature parity makes the long-term picture uncertain.

## Technical Analysis

### Architecture (v5)

Claude-Mem's architecture centers on five lifecycle hooks that intercept Claude Code's operation:

| Hook | Trigger | Function |
|------|---------|----------|
| SessionStart | New session | Inject relevant context from past sessions |
| UserPromptSubmit | Each user prompt | Initialize session tracking |
| PostToolUse | After each tool call | Capture observation (tool name, input, output) |
| Stop | Turn end | Generate summary of turn |
| SessionEnd | Session close | Finalize and persist session data |

A Bun-powered worker service runs on port 37777, providing:
- HTTP API for hook communication
- Web viewer UI for real-time memory stream
- SQLite database for sessions, observations, and summaries
- Chroma vector database for hybrid semantic + keyword search
- 5 MCP tools for intelligent memory retrieval

### Progressive Disclosure (Token Efficiency)

The most architecturally interesting feature is the 3-layer retrieval pattern:

1. **`search`** -- Returns compact index with IDs (~50-100 tokens/result)
2. **`timeline`** -- Chronological context around specific observations
3. **`get_observations`** -- Full details only for filtered IDs (~500-1,000 tokens/result)

This achieves ~10x token savings compared to naive full-context injection, though the widely-cited "95% token reduction" claim was disputed by the creator himself on Reddit: "it shouldn't say it reduces token usage by 95%. That's pushing the upvote count higher than it should be."

### Stack

- **Language:** TypeScript
- **Runtime:** Bun (worker service) + Node.js >= 18
- **Storage:** SQLite (FTS5 search) + Chroma (vector embeddings)
- **AI:** @anthropic-ai/claude-agent-sdk for observation compression
- **Server:** Express on port 37777
- **License:** AGPL-3.0 (ragtime/ under PolyForm Noncommercial)

### Version Velocity

The project has iterated aggressively: from v6.5.0 (README badge, likely outdated) to v10.3.1 (package.json) in roughly 4 months. Recent commits are predominantly from Alex Newman with Claude Opus 4.6 co-authorship.

## User Sentiment

**Overall:** Mixed-to-Positive

- **Reddit:** High engagement across r/ClaudeCode and r/ClaudeAI. The original "CHANGED MY LIFE" post and "95% token reduction" post drove significant visibility. Common praise for automatic operation and hook-based design. Complaints center on exaggerated claims, increasing competition from built-in features, and confusion about differentiation. The creator actively engages in discussions and corrects misinformation.

- **Twitter/X:** Medium volume. Official @Claude_Memory account exists. The project was caught up in the January 2026 Claude Code token frenzy on Solana, with $CMEM climbing 543%. Coverage from CoinDesk, The Block, and Yahoo Finance focused on the Solana speculation angle rather than the tool's technical merits.

- **LinkedIn:** Professional posts from multiple developers sharing the tool. Alex Newman's introductory post and Tyler Folkman's "Overcoming Claude Code Amnesia" post represent typical professional engagement. No enterprise adoption signals found.

- **Web:** Extensive tutorial coverage (apidog.com, byteiota.com, corti.com, yuv.ai, Medium). DEV Community lists it as #2 in "10 top Claude Code plugins to use in 2026." GitHub Trending for 3 consecutive days with accelerating star gains.

## The $CMEM Token Situation

The most notable change since our prior coverage is the prominent placement of $CMEM Solana token links at the very top of the README, above the project logo. The README displays:

- Official CA (Contract Address) on Solana
- Links to bags.fm, Jupiter, Photon, and DEXScreener

This follows the pattern established by Steve Yegge's $GAS (Gas Town) and Geoffrey Huntley's $RALPH (Ralph Wiggum) tokens, where open-source AI tool creators have embraced Solana tokens launched by speculators on the bags.fm platform. CoinDesk and The Block reported this as part of a broader "Claude Code virality fueling a token launch frenzy."

While the creator has not been accused of launching the token (it appears third-party initiated, similar to Gas Town), actively promoting it in the README of an open-source tool raises questions about incentive alignment. The token rose 543% during the January frenzy. Users evaluating claude-mem should be aware of this dynamic and assess whether it affects their trust in the project's direction.

## Stability Concerns

Active open issues and PRs reveal significant operational problems:

| Issue | Severity | Status |
|-------|----------|--------|
| 218 zombie worker processes (15GB swap) | Critical | PR #1144 open |
| 51,140 duplicate observations per session | Critical | Issue #1158 open |
| Auth error infinite retry loop (57+ hrs blocked) | High | PR #1180 open |
| CLI subprocess timeout in proxy environments | Medium | Issue #1163 |
| Privacy tag bypass (case-insensitive) | Medium | PR #1151 open |
| SQL queries referencing non-existent columns | Medium | PR #1152 open |

The security hardening PR (#1157) from the maintainer himself addresses world-readable databases, unauthenticated local APIs, context injection vulnerabilities, and memory poisoning -- suggesting the previous versions had significant security gaps.

## Competitive Landscape

The Claude Code memory plugin space has exploded since early 2026:

| Competitor | Approach | Differentiator |
|------------|----------|---------------|
| **Claude Auto-Memory (built-in)** | Memory.md files, official | Zero setup, but basic scope |
| **Mem0 (MCP server)** | Universal memory layer | Cross-platform (Claude, ChatGPT, Gemini), 40K+ stars |
| **claude-supermemory** | Paid backend (supermemory.ai) | Dhravya Shah's universal memory product |
| **Nemp Memory** | Local JSON files, offline | Zero cloud dependency |
| **basic-memory** | MCP server, Markdown | Simple, local-first |
| **CORE Memory MCP** | MCP-based | Plugin-era packaging |
| **cc-obsidian-mem** | Obsidian vault | Existing vault integration |
| **MemTree.dev** | METR benchmark focus | Claims benchmark improvements |

Claude-mem's key advantage remains its hook-based automatic operation -- no manual save/recall commands needed. However, Claude Code v2.1.32's built-in auto-memory and Anthropic's Memory Tool beta are narrowing this gap. The long-term question is whether third-party memory plugins become unnecessary as official features mature.

## Pros and Cons

| Pros | Cons |
|------|------|
| Most popular Claude Code plugin (29.2K stars) | $CMEM Solana token promoted in README |
| Fully automatic via lifecycle hooks | Critical bugs: zombie processes, duplicate observations |
| Progressive disclosure saves ~10x tokens | AGPL-3.0 may deter enterprise adoption |
| Local-first (SQLite + Chroma) | Security gaps (being addressed in PR #1157) |
| Active development (v10.3.1, daily commits) | Official auto-memory features closing the gap |
| Web viewer UI for debugging/browsing | "95% token reduction" claim disputed by creator |
| Comprehensive MCP search tools | ragtime/ under PolyForm Noncommercial |
| 30+ language README translations | Single maintainer (sole committer) |
| OpenClaw gateway integration | Potential Anthropic ToS issues with OAuth usage |
| Strong community PRs (10+ open) | 105 open issues suggest maintenance backlog |

## Sources

### GitHub
- https://github.com/thedotmack/claude-mem
- https://github.com/thedotmack/claude-mem/issues
- https://github.com/thedotmack/claude-mem/pulls

### Reddit
- https://www.reddit.com/r/ClaudeAI/comments/1pn0h0h/
- https://www.reddit.com/r/ClaudeCode/comments/1peszsg/
- https://www.reddit.com/r/ClaudeAI/comments/1oegbwo/
- https://www.reddit.com/r/ClaudeCode/comments/1odoo3k/
- https://www.reddit.com/r/ClaudeAI/comments/1qrlsly/
- https://www.reddit.com/r/ClaudeAI/comments/1q7mp8m/
- https://www.reddit.com/r/ClaudeCode/comments/1qzmofn/

### LinkedIn
- https://www.linkedin.com/posts/alexnewman_github-thedotmackclaude-mem-a-claude-activity-7391306333355925504-p975
- https://www.linkedin.com/posts/tylerfolkman_you-know-that-feeling-when-you-open-claude-activity-7406706577254035457-ipj_

### Web / News
- https://docs.claude-mem.ai/
- https://yuv.ai/blog/claude-mem
- https://apidog.com/blog/how-to-use-claude-mem/
- https://byteiota.com/claude-mem-persistent-memory-for-claude-code/
- https://levelup.gitconnected.com/someone-built-memory-for-claude-code-and-people-are-actually-using-it-9f657be0f193
- https://dev.to/composiodev/10-top-claude-code-plugins-to-use-in-2026-4gn6
- https://medium.com/@lssmj2014/github-trending-february-6-2026-claude-mem-day-3-bytedance-enters-28a63d6137d2
- https://www.theblock.co/post/386376/solana-activity-jumps-claude-code-virality-token-launch-frenzy
- https://www.coindesk.com/markets/2026/01/21/solana-outpaces-crypto-market-as-claude-code-linked-token-frenzy-lifts-network-activity
- https://thedefiant.io/news/defi/bags-launchpad-activity-surges-after-gas-token-soars-700

### Related Reports
- [Context Engineering](2026-02-02-context-engineering.md) - Prior mention of claude-mem as community tool
- [OrchestKit](2026-02-02-orchestkit.md) - Referenced claude-mem's star count
- [Mem0](2026-02-02-mem0.md) - Competing universal memory layer

---
*Generated by Research Agent on 2026-02-19*
