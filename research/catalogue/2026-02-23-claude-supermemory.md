---
topic: claude-supermemory (Supermemory)
slug: claude-supermemory
date: 2026-02-23
sources: [github, reddit, twitter, linkedin, web]
---

# claude-supermemory Research Report

## Overview

claude-supermemory is a Claude Code plugin by Dhravya Shah's venture-backed startup Supermemory ($2.6M seed from Jeff Dean, Susa Ventures, Browder Capital). It gives Claude Code persistent memory across sessions by connecting to the Supermemory cloud API -- a universal "Memory API for the AI era" that also serves OpenCode, OpenClaw, Cursor, Claude Desktop, and browser extensions. The plugin is intentionally thin (~200 lines of core logic) because all intelligence -- graph-based memory evolution, hybrid search, memory decay, user profiling -- lives server-side.

At 2,178 GitHub stars in 32 days (created Jan 22, 2026), the plugin is growing quickly but sits well behind claude-mem (29.2K stars) in the Claude Code memory space. The key differentiator is cross-platform team memory: supermemory remembers context across every tool your team uses, not just one editor. The key barrier is cost: the Claude Code plugin requires Supermemory Pro ($19/month), whereas claude-mem and Anthropic's built-in auto-memory are free.

Self-published benchmarks are strong -- 81.6% on LongMemEval (vs 40-60% for typical RAG) and 85.9% on their open-source MemoryBench (vs Claude Code's built-in at 54.2%) -- but no independent validation exists yet. The founder, a 20-year-old former Cloudflare developer relations lead and ASU student from Mumbai, is highly active on X and builds in public with genuine authenticity. The parent supermemory platform (16,585 stars, est. Feb 2024) has legitimate traction with consumer and developer products.

## Technical Analysis

### Plugin Architecture

The plugin uses two Claude Code lifecycle hooks plus two skills:

| Component | Type | Function |
|-----------|------|----------|
| `context-hook.cjs` | SessionStart hook (30s timeout) | Fetches personal + team memories from supermemory API, injects into context |
| `summary-hook.cjs` | Stop hook (30s timeout) | Reads session transcript, formats via signal extraction, saves to supermemory API |
| `super-search` | Skill | On-demand semantic memory search across personal and repo containers |
| `super-save` | Skill | Manual save of team/project knowledge |

**Data flow:**
1. On session start, the plugin fetches two "profiles" in parallel: a personal profile (tied to the developer's git email hash) and a repo profile (tied to the git remote URL). Each profile contains static facts, dynamic facts, and semantic search results.
2. These are formatted and injected as `additionalContext` into Claude's system prompt via the `SessionStart` hook output.
3. During the session, Claude can invoke `super-search` and `super-save` skills for on-demand memory operations.
4. On session stop, the plugin reads the session transcript, optionally applies signal extraction (keyword-triggered selective capture), and saves the formatted content to the personal memory container.

### Two-Tier Memory Model

The plugin separates personal and team memory using "container tags":

| Tier | Scope | Container Tag Source | Entity Context |
|------|-------|---------------------|----------------|
| Personal | Individual developer | Derived from cwd | Extracts user actions, preferences, decisions, learnings |
| Project/Team | Shared across team | Derived from git remote URL | Extracts architecture, conventions, patterns, setup |

The entity contexts are carefully crafted prompts embedded in `supermemory-client.js` that guide the server-side memory extraction. Personal context focuses on user intent ("researched whisper.cpp", "prefers Tailwind"), while repo context captures project knowledge ("uses monorepo with turborepo", "chose Drizzle over Prisma").

### Signal Extraction

Configurable via `signalExtraction` setting:
- **Off (default):** Captures full transcript with formatting
- **On:** Only captures turns around signal keywords ("remember", "architecture", "decision", "bug", "fix") with configurable context window (`signalTurnsBefore: 3`)

### Backend: Supermemory API

The plugin depends entirely on the `supermemory` npm package (v4.0.0+) which calls `https://api.supermemory.ai`. Key API operations:
- `client.add()` -- Add memory with container tag, metadata, entity context
- `client.search.memories()` -- Hybrid search (semantic + keyword) with container filtering
- `client.profile()` -- Get user/project profile with static/dynamic facts and search results

The API handles all heavy lifting: memory extraction, graph-based linking, decay of irrelevant information, contradiction resolution, and temporal grounding.

### Stack

- **Language:** JavaScript (CommonJS)
- **Runtime:** Node.js >= 18
- **Build:** esbuild
- **Linting:** Biome
- **API:** `supermemory` npm SDK v4.0.0
- **Auth:** Browser-based OAuth flow or `SUPERMEMORY_CC_API_KEY` env var
- **License:** MIT
- **Config:** `~/.supermemory-claude/settings.json` (global), `.claude/.supermemory-claude/config.json` (project)

### Comparison with claude-mem Architecture

| Aspect | claude-supermemory | claude-mem |
|--------|-------------------|------------|
| **Core logic** | ~200 lines (thin client) | ~10K+ lines (full stack) |
| **Storage** | Cloud (supermemory API) | Local (SQLite + Chroma) |
| **Hooks** | 2 (SessionStart, Stop) | 5 (SessionStart, UserPromptSubmit, PostToolUse, Stop, SessionEnd) |
| **Search** | Hybrid (server-side) | Progressive disclosure (3-layer local) |
| **Team memory** | Built-in (repo container tag) | Not supported |
| **Cross-platform** | Claude Code + OpenCode + Cursor + OpenClaw + Desktop | Claude Code only |
| **Privacy** | Cloud-stored (supermemory servers) | Fully local |
| **Cost** | $19/mo Pro required | Free (AGPL-3.0) |
| **Memory decay** | Automatic (server-side) | None (accumulates) |
| **Token promotion** | None | $CMEM Solana token in README |

## Founder & Funding

**Dhravya Shah** is a 20-year-old entrepreneur from Mumbai, now based in San Francisco as an ASU student. He previously interned at and led developer relations at Cloudflare, where mentors encouraged him to build supermemory into a company. TechCrunch covered his $2.6M seed round in October 2025.

**Investors:**
- Lead: Susa Ventures, Browder Capital, SF1.vc
- Angels: Jeff Dean (Google AI chief), Logan Kilpatrick (DeepMind PM), executives from OpenAI, Meta, and Google

The broader supermemory organization has 18 repositories on GitHub, with the main supermemory repo at 16,585 stars and a total ecosystem including markdowner (1,813 stars), apple-mcp (3,007 stars), and the cloudflare-saas-stack (3,707 stars). This is a legitimate, funded startup with real products -- not a weekend project.

## Pricing

### Developer API (Required for Claude Code plugin)

| Plan | Cost | Tokens | Queries |
|------|------|--------|---------|
| Free | $0/mo | 1M | 10K |
| **Pro** | **$19/mo** | 3M | 100K |
| Scale | $399/mo | 80M | 20M |

Overages: $0.01/1K tokens, $0.10/1K queries

The Claude Code plugin explicitly requires Pro or above. The free tier is usable for the MCP integration but not the Claude Code plugin.

### Consumer App

| Plan | Cost | Memories |
|------|------|----------|
| Free | $0/mo | 10 |
| Pro | $9/mo | 500 + 10 connections |

### Startup Program
$1,000 in Pro credits for 6 months for qualifying startups.

## Performance Benchmarks

All benchmarks are self-published by the supermemory team:

| Benchmark | Supermemory | RAG (OpenClaw) | Filesystem (Claude Code) | Typical RAG |
|-----------|------------|----------------|-------------------------|-------------|
| **MemoryBench** | 85.9% | 58.3% | 54.2% | -- |
| **LongMemEval** | 81.6% | -- | -- | 40-60% |

Additional claims from AIFounderKit review:
- Sub-300ms recall latency
- Claims 10x faster than Zep, 25x faster than Mem0
- Overall score: 9.2/10

**Important caveat:** MemoryBench is Supermemory's own open-source benchmark (161 stars). LongMemEval is an established academic benchmark, but the 81.6% result is self-reported. No independent verification of any claims.

## User Sentiment

**Overall:** Mixed-to-Positive

### Reddit (Moderate volume, ~10 threads)
- **Positive:** "Best memory layer I've tested" (MCP integration), clean architecture praised in dissection post
- **Neutral:** Questions about whether paid external memory is needed vs free built-in features
- **Negative:** Paid backend requirement noted as barrier; some "isn't this what Projects is for?" skepticism

### Twitter/X (Primary channel)
- Dhravya highly active, genuine builder-in-public style
- Claims 500k views on OpenClaw plugin announcement
- Builder community engagement (levelsio, pedrodias)
- No controversy or backlash found

### LinkedIn (Professional presence)
- Solid for seed-stage startup
- Coverage skews toward founder story (young, Indian origin) vs technical depth
- No enterprise adoption signals

### Web/Blogs
- Dev Genius dissection was fair and transparent about paid dependency
- AIFounderKit gave 9.2/10 rating
- Coverage growing but still primarily from supermemory's own blog

## Competitive Landscape

| Solution | Stars | Cost | Storage | Cross-Platform | Team Memory | Memory Quality |
|----------|-------|------|---------|----------------|-------------|----------------|
| **claude-supermemory** | 2,178 | $19/mo | Cloud | Yes (5+ tools) | Yes | 85.9% (self-reported) |
| **claude-mem** | 29.2K | Free | Local (SQLite+Chroma) | No | No | ~10x token savings |
| **Mem0 MCP** | 40K+ | Free (self-host) or paid | Cloud/local | Yes | Yes | +26% over OpenAI |
| **Claude Auto-Memory** | Built-in | Free | File-based | No | No | 54.2% (per supermemory) |
| **basic-memory** | ~1K | Free | Local markdown | No | No | N/A |
| **OpenMemory (Cavira)** | ~1K | Free | Local | Yes | No | N/A |

### Supermemory's positioning:
- **vs claude-mem:** Cross-platform + team memory + memory decay, but paid and cloud-dependent
- **vs Mem0:** Both are universal memory layers, but supermemory claims 25x faster recall; Mem0 has 40K+ stars and $24M Series A funding
- **vs built-in:** Significantly better benchmark scores (85.9% vs 54.2%), but adds cost and cloud dependency
- **vs local solutions:** Better quality but requires internet connection and trusting a third party with your code context

## Pros and Cons

| Pros | Cons |
|------|------|
| Cross-platform memory (5+ tools) | Pro plan ($19/mo) required for Claude Code |
| Team/project memory shared across devs | Cloud-only -- no local/self-hosted option for plugin |
| Intentionally thin plugin (~200 lines, easy to audit) | All code context sent to supermemory servers |
| Legitimate VC-backed startup ($2.6M, Jeff Dean) | Benchmarks are self-published, no independent validation |
| Strong benchmark claims (81.6% LongMemEval) | 2,178 stars vs claude-mem's 29.2K (less community validation) |
| Memory decay eliminates stale context | Windows bug (readStdin hangs indefinitely, #25) |
| Signal extraction for selective capture | /index command shallow for non-JS/TS ecosystems (#32, #33) |
| MIT license (plugin code) | Backend API is proprietary -- vendor lock-in risk |
| Active development (30 commits in 32 days) | Small team (2-3 contributors) |
| No crypto token / no Solana promotion | Free tier does NOT work with Claude Code plugin |
| Browser-based auth for easy onboarding | Cursor plugin brand-new (11 stars, Feb 17) |

## Key Takeaways

1. **The real product is the platform, not the plugin.** claude-supermemory is a distribution channel for supermemory's Memory API. The plugin's simplicity is a feature, not a limitation -- it means fewer bugs, easier auditing, and consistent behavior because the intelligence lives in a maintained API.

2. **Cross-platform team memory is genuinely differentiated.** No other Claude Code memory solution offers shared team context that follows developers across Claude Code, Cursor, OpenCode, and OpenClaw. For teams using multiple AI coding tools, this is compelling.

3. **The $19/mo paywall is both a filter and a barrier.** It ensures committed users and funds ongoing development, but it also means most casual users will choose claude-mem (free) or stick with built-in auto-memory. The pricing is reasonable for professionals but alienates hobbyists.

4. **Trust the benchmarks cautiously.** The 81.6% LongMemEval and 85.9% MemoryBench scores are plausible given the architecture (cloud-side graph processing vs local file search), but both are self-reported. MemoryBench is their own benchmark. Wait for independent validation.

5. **Privacy trade-off is explicit.** Unlike claude-mem (fully local), supermemory sends your session context to their servers. The `<private>` tag redaction is a mitigation, not a solution. Enterprise teams with strict data policies may not be able to use it.

## Sources

### GitHub
- https://github.com/supermemoryai/claude-supermemory
- https://github.com/supermemoryai/supermemory
- https://github.com/supermemoryai (organization page)

### Reddit
- https://www.reddit.com/r/ClaudeCode/comments/1qtejgh/dissecting_the_claudesupermemory_plugin/
- https://www.reddit.com/r/ClaudeAI/comments/1p8l6wz/supermemoryai_mcp_works_flawlessly_with_claude/
- https://www.reddit.com/r/ClaudeAI/comments/1odirm4/you_can_actually_give_claude_desktop_memory_now/
- https://www.reddit.com/r/ClaudeAI/comments/1l8ayzr/i_made_a_memory_mcp_server_and_made_it_open/
- https://www.reddit.com/r/LocalLLaMA/comments/1q86tz8/why_is_ai_memory_still_all_hype/

### Twitter/X
- https://x.com/DhravyaShah/status/2017039283367137690
- https://x.com/DhravyaShah/status/2016027476787679598
- https://x.com/supermemoryai

### LinkedIn
- https://www.linkedin.com/in/dhravyashah/
- https://www.linkedin.com/posts/dhravyashah_github-supermemoryaiclaude-supermemory-activity-7423238259562160129-a134
- https://www.linkedin.com/company/supermemory
- https://www.linkedin.com/posts/raphaelsisa_supermemory-is-a-tool-that-enables-llms-activity-7345968034202775553-6b_e
- https://www.linkedin.com/posts/lioralex_you-can-now-give-infinite-memory-to-claude-activity-7417158901122383872-k0je

### Web / Blogs
- https://supermemory.ai/blog/we-added-supermemory-to-claude-code-its-insanely-powerful-now/
- https://blog.supermemory.ai/infinitely-running-stateful-coding-agents/
- https://blog.supermemory.ai/why-everyone-is-complaining-about-openclaws-memory-it-sucks-and-why-supermemory-fixes-it/
- https://blog.devgenius.io/dissecting-the-claude-supermemory-plugin-d2bea6a94c25
- https://aifounderkit.com/tool/supermemory-review-features-pricing-alternatives/
- https://supermemory.ai/docs/integrations/claude-code

### News / Funding
- https://techcrunch.com/2025/10/06/a-19-year-old-nabs-backing-from-google-execs-for-his-ai-memory-startup-supermemory/
- https://dataconomy.com/2025/10/07/young-founders-supermemory-raises-2-6m-from-cloudflare-and-google-execs/
- https://www.founderstoday.news/dhravya-shah-secures-over-2m-funding/

### Related Reports
- [Claude-Mem](2026-02-19-claude-mem.md) -- Most popular Claude Code memory plugin (free, local)
- [Mem0](2026-02-02-mem0.md) -- Competing universal memory layer ($24M Series A)
- [Claude Code Memory System](2026-02-19-claude-code-memory.md) -- Official 6-tier memory hierarchy
- [Context Engineering](2026-02-02-context-engineering.md) -- Broader context management guide
- [Cognee](2026-02-19-cognee.md) -- Open-source knowledge graph memory engine

---
*Generated by Research Agent on 2026-02-23*
