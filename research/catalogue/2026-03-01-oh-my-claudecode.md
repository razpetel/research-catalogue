---
topic: oh-my-claudecode
slug: oh-my-claudecode
date: 2026-03-01
sources: [github, reddit, twitter, linkedin, web]
prior: 2026-02-02
---

# oh-my-claudecode Research Report

**Date:** 2026-03-01
**Sentiment:** Positive
**Summary:** The dominant community orchestration plugin for Claude Code, now at 7.8K stars with a full v4 architectural rewrite in 27 days. Teams-first multi-agent orchestration with tri-model support (Claude+Codex+Gemini), notifications engine, and 28 specialized agents. Exceptional velocity (37 commits/day) from a single-maintainer Seoul-based quant trader. ToS-compliant (native Hooks), but facing existential pressure from Anthropic's Agent Teams and persistent token-burn criticism.

---

## Overview

oh-my-claudecode (OMC) by Yeachan Heo (@Yeachan-Heo, alias "Bellman") is a multi-agent orchestration plugin for Claude Code that provides parallel execution, smart model routing, and 28 specialized agents covering architecture, research, design, testing, and data science. Originally forked from oh-my-opencode as "oh-my-claude-sisyphus," it was rebranded at v3.0.0 and has since undergone a full v4 architectural rewrite.

Since the prior report (2026-02-02), OMC has nearly doubled its stars (4K → 7.8K), tripled its commit count (439 → 1,439), and shipped 67 releases including 3 breaking-change versions. The v4 rewrite made Team the canonical orchestration surface, removed MCP servers in favor of tmux CLI workers, and added tri-model orchestration (Claude+Codex+Gemini via `/ccg`), a full notifications engine, and OpenClaw webhook integration.

The project benefited enormously from Anthropic's January 9, 2026 OAuth block on third-party tools. Because OMC uses Claude Code's native Hooks system rather than unauthorized OAuth tokens, it became the ToS-compliant alternative to oh-my-opencode — driving a surge of migration adoption.

However, Anthropic's official Agent Teams launch (February 5, 2026) creates direct competition for OMC's core value proposition. OMC retains advantages in pre-built agent specialization and notifications, but native Agent Teams offers zero-setup, officially maintained multi-agent coordination. The bus factor remains critical: Yeachan Heo authored 93% of commits since February 2, making this effectively a single-maintainer project built as a side project by a quant trader.

## Technical Analysis

### Repository Health

| Attribute | Value |
|-----------|-------|
| **GitHub** | [Yeachan-Heo/oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) |
| **Stars** | 7,801 |
| **Forks** | 542 |
| **License** | MIT |
| **Language** | TypeScript (82%) |
| **Version** | v4.5.1 (released 2026-02-26) |
| **Created** | 2026-01-09 |
| **Last commit** | 2026-03-01 |
| **Total commits** | 1,439 |
| **Releases** | 177 |
| **Contributors** | 30 (1 core) |
| **Issues (all time)** | 1,182+ |
| **Open issues** | 2 |
| **npm package** | `oh-my-claude-sisyphus` |
| **Website** | ohmyclaudecode.com |
| **Context7** | 3,396 snippets indexed, 81.3 benchmark |
| **Status** | **Very Active** |

### Architecture (v4.x)

**Core rewrite since Feb 2:** Team is now the canonical orchestration surface. Legacy modes (swarm, ultrapilot) are compatibility facades routing to Team.

**Orchestration model:**
- **Team** — Primary multi-agent surface (`/omc-teams`)
- **Autopilot** — Autonomous single-agent execution
- **Ecomode** — 30-50% token savings via smart routing
- **Pipeline** — Sequential agent chains

**Key v4 changes:**
- MCP servers (Codex/Gemini) removed entirely, replaced by tmux CLI workers
- Tri-model orchestration via `/ccg` skill (Claude + Codex + Gemini in parallel)
- 34 agents consolidated to 28 unified agents (removed tier suffixes)
- Context Safety: threshold-based blocking to prevent context bloat
- Deliverable Gates: automated verification before task completion
- Notifications engine: Telegram, Discord, Slack, webhooks
- OpenClaw webhook gateway for external automation
- i18n: README in 7 languages (EN, KO, ZH, JA, ES, VI, PT)
- Security: shell interpolation replaced with array-form spawn

### Development Velocity

| Period | Commits | Releases | Stars/Day |
|--------|---------|----------|-----------|
| Jan 9 – Feb 1 (24 days) | 439 | 110 | 168 |
| Feb 2 – Mar 1 (27 days) | 1,000 | 67 | 139 |

Commit velocity doubled (18/day → 37/day) during the v4 rewrite. Release cadence moderated (4.6/day → 2.5/day), reflecting larger, more stable releases. Star growth slightly declining but still 139/day.

### Ecosystem

| Project | Stars | Author | Description |
|---------|-------|--------|-------------|
| **oh-my-claudecode** | 7,801 | Yeachan-Heo | Main project |
| **oh-my-codex** | 1,079 | Yeachan-Heo | Port for OpenAI Codex CLI (launched Feb 2) |
| **oh-my-opencode** | 35,675 | code-yeongyu | Upstream progenitor (OpenCode) |
| **oh-my-droid** | New | MeroZemory | Port for Factory AI Droid CLI |
| **oh-my-openclaw** | New | happycastle114 | Port for OpenClaw |
| **oh-my-opencode-slim** | New | alvinunreal | Token-efficient fork |

## User Sentiment

**Overall: Positive (55% positive, 25% neutral, 20% negative)**

### Reddit (~30 relevant mentions)

- **Power users:** "Multi-session workflow is where I've seen the biggest productivity gains. Running oh-my-claudecode changed my whole approach" — engineer coding 100% with AI for 1+ year
- **Complementary positioning:** Users frequently pair OMC with other frameworks — OMC for session management, GSD/Superpowers for workflow structure
- **Token burn criticism:** "Oh My Opencode plugin is known to be token burner... extra burn doesn't make any difference at all" — criticism from the broader oh-my-* family
- **Skeptics:** "Most of it is just extra steps you don't need" — systematic tester who switched to oh-my-opencode-slim
- **Agent Teams dynamic:** OMC mentioned alongside native Agent Teams, validating the multi-agent thesis but raising the question of whether community tools will be subsumed
- **oh-my-claude-sisyphus** fork generates more Reddit discussion than OMC in some contexts, especially around model routing

### Twitter/X & Threads

- **Author is NOT on Twitter** — primary social platform is Meta Threads (@bellman.pub)
- **Threads activity:** Multiple posts per week, casual developer voice, actively engages in replies
- **Twitter buzz:** Low direct mentions; indirect references through Claude Code ecosystem discussions
- **Notable gap:** No dedicated YouTube videos for OMC (sister project oh-my-opencode has multiple)

### LinkedIn

- **Author profile:** Self-employed quant trader in Seoul, leader of Quant.start() (Korea's biggest quant trading community)
- **Posting frequency:** 9+ LinkedIn posts in 6 weeks (up from "limited" in prior report)
- **Language shift:** Korean-only → mixed Korean/English content
- **Third-party mentions:** 2-3 direct mentions from professionals (Dohyun Jung, John Sasser)
- **Enterprise signals:** Weak but emerging — no corporate deployments found

### Web & Blogs

- **8+ dedicated blog posts** in English, Korean, and Chinese
- **Key review:** Kendrick B. Jung's "Legal Doping for Claude Code" — $200 in 4 days of intensive use, only a handful of 40+ features see regular use
- **ROBOCO comparison:** OMC = "automatic orchestration, system-driven" vs Everything Claude Code = "quality-centered, user-driven"
- **Hacker News:** Mixed reception (52 points, 38 comments) — skepticism about multi-agent value, security concerns about auto-upgrade
- **Awesome lists:** Listed in 4+ curated Claude Code collections
- **Context7:** 3,396 code snippets indexed (4.3x more than official Claude Code docs)

### Korean Developer Community

Strong adoption signal — multiple Korean-language blog posts, Korean LinkedIn activity, and the author's Korean background drive disproportionate adoption in Korea. Anthropic's Seoul office opening in early 2026 provides favorable context.

## Competitive Landscape

| Tool | Stars | Type | Key Differentiator |
|------|-------|------|--------------------|
| **oh-my-claudecode** | 7.8K | Plugin orchestrator | 28 agents, tri-model, notifications, ToS-compliant |
| **oh-my-opencode** | 35.7K | Plugin orchestrator | Multi-provider, larger ecosystem, ToS risk |
| **Agent Teams** | N/A | First-party Anthropic | Native, zero-setup, officially maintained |
| **Superpowers** | 42.4K | Skills/workflows | Implementation discipline, different layer |
| **BMAD Method** | 38.5K | Spec-driven framework | Heavy planning, multi-IDE, most comprehensive |
| **GSD** | 10.5K | Minimal/anti-framework | Fast shipping, declining post-Opus 4.6 |
| **Everything Claude Code** | ~2K | Quality-focused | User-driven, sequential, steeper learning curve |
| **Dorothy** | New | Desktop orchestrator | Visual session management, direct competitor |

**Key dynamics:**
- Agent Teams is the primary competitive threat — validates OMC's thesis but overlaps its core value proposition
- OMC's ToS compliance (native Hooks) is a moat against oh-my-opencode
- Token burn is the ecosystem-wide achilles heel — "a three-agent team burns your daily allocation ~3x faster"
- OMC occupies a distinct niche: session management + pre-built agent specialization

## Pros and Cons

| Pros | Cons |
|------|------|
| Explosive growth (7.8K stars in 51 days) | Bus factor of 1 (93% of commits) |
| Full v4 rewrite shows architectural maturity | Side project of a quant trader |
| 28 specialized agents with smart model routing | Token-intensive (critics call it "token burner") |
| Tri-model orchestration (Claude+Codex+Gemini) | Hacker News reception mixed/skeptical |
| Notifications engine (Telegram/Discord/Slack) | No YouTube content (discovery gap) |
| ToS-compliant (native Hooks, not OAuth) | Agent Teams may subsume core value |
| Context7: 3,396 snippets, 81.3 benchmark | Only 2 open issues = single reviewer bottleneck |
| 8+ blog posts, multi-language coverage | npm name (oh-my-claude-sisyphus) is confusing |
| Korean dev community stronghold | 177 releases in 51 days = API instability |
| MIT license, GitHub Sponsors funding | Rapid breaking changes (3 in v4.x alone) |

## Verdict

oh-my-claudecode is the most feature-rich community orchestration plugin for Claude Code, with exceptional growth and development velocity. The v4 rewrite — from MCP servers to tmux CLI workers, Team-first architecture, and tri-model orchestration — shows genuine architectural thinking, not just feature accumulation. The ToS compliance via native Hooks is a genuine moat against competing community tools.

**Best for:**
- Power users on Max 5x/20x plans who want parallel multi-agent execution
- Developers already in the oh-my-* ecosystem
- Teams wanting pre-built specialized agents without defining roles from scratch
- Cross-model orchestration (Claude + Codex + Gemini simultaneously)

**Consider alternatives if:**
- You want officially maintained tooling (use Agent Teams)
- You're on Claude Pro plan (token budget too tight for multi-agent)
- You prefer minimal overhead (use Superpowers or vanilla Claude Code + CLAUDE.md)
- You need implementation workflow structure, not session management (use BMAD or GSD)
- You're concerned about single-maintainer risk

**Recommendation:** The right tool for the power-user niche, but with a clear expiration risk. If Anthropic's Agent Teams matures to cover OMC's pre-built agent specialization and notifications, OMC's moat shrinks to the oh-my-* ecosystem network effect and Yeachan Heo's iteration speed. The single-maintainer bus factor is the biggest practical risk. Watch for: (1) sustained commit velocity after the v4 rewrite settles, (2) Agent Teams feature parity, and (3) whether community contributions diversify beyond the author.

## Sources

- [GitHub: Yeachan-Heo/oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode)
- [ohmyclaudecode.com](https://ohmyclaudecode.com)
- [Kendrick B. Jung: "Legal Doping for Claude Code"](https://sonim1.com/en/blog/oh-my-claudecode)
- [Jeongil Jeong: "The Ever-Changing AI Coding Agent Ecosystem"](https://jeongil.dev/en/blog/trends/claude-code-agent-teams/)
- [ROBOCO: Everything Claude Code vs Oh My ClaudeCode](https://roboco.io/posts/everything-claude-code-vs-oh-my-claude-code/)
- [Hacker News: "Sisyphus Now Lives in Oh My Claude"](https://news.ycombinator.com/item?id=46572032)
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)
- [Context7: oh-my-claudecode](https://context7.com/)
- [Prior report: oh-my-claudecode (2026-02-02)](catalogue/2026-02-02-oh-my-claudecode.md)

---
*Generated by Research Agent on 2026-03-01 (update to 2026-02-02 report)*
