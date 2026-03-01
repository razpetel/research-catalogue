---
topic: SuperBeads
slug: superbeads
date: 2026-02-28
sources: [github, reddit, twitter, linkedin, web]
prior_report: 2026-02-04-superbeads.md
---

# SuperBeads Universal Framework — Updated Research Report

**Date:** 2026-02-28
**Prior report:** 2026-02-04
**Sentiment:** Negative (downgraded from Mixed)
**Summary:** Meta-framework combining Beads, Superpowers, and Ralph Wiggum for Claude Code. Development stalled after initial 6-day burst, adoption flat at 24 stars, and platform risk increased as Anthropic absorbed Beads into native Tasks.

---

## Overview

SuperBeads Universal Framework (with "Wiggum Flavour") by Elia Alberti remains a well-documented meta-framework that unifies Steve Yegge's Beads (task tracking), obra's Superpowers (workflows), and Anthropic's Ralph Wiggum (iteration) into a single Claude Code methodology with domain-specific packs.

Since our last report (2026-02-04), the project has shown clear signs of stagnation. No code has been committed since January 19 — 40 days of inactivity. Stars grew from 21 to 24, a pace of roughly one per week with no marketing effort. Zero issues and zero pull requests have been filed in the project's entire history, suggesting that the 24 stargazers are bookmarkers, not active users.

Most critically, the competitive landscape has shifted against SuperBeads. Anthropic has absorbed Beads-style task tracking into native Claude Code Tasks, Superpowers is now on the official Claude plugin marketplace, and a competing project (Hyperpowers) independently combines the same tools. The rationale for a meta-framework weakens as the components become first-party or trivially installable.

## What Changed Since 2026-02-04

| Metric | Feb 4 | Feb 28 | Change |
|--------|-------|--------|--------|
| Stars | 21 | 24 | +3 |
| Forks | 2 | 2 | 0 |
| Issues/PRs (ever) | 0 | 0 | 0 |
| Last commit | Jan 19 | Jan 19 | **40 days dormant** |
| Version | 1.1.0 | 1.1.0 | No change |
| Twitter presence | None | None | No change |
| LinkedIn presence | None | None | No change |
| Web coverage | None | None | No change |

**New developments:**
- Anthropic's native Tasks feature absorbed Beads concepts (existential platform risk)
- Hyperpowers (withzombies/hyperpowers) independently combines Beads + Superpowers
- Listed in majiayu000/claude-skill-registry (third-party indexing)
- Unattributed copy at dannystuart/superbeads (v1.0.0, 0 stars)
- GSD (Get Shit Done) movement gaining traction as anti-framework backlash

## Technical Analysis

### Repository Health

| Attribute | Value |
|-----------|-------|
| **GitHub** | [EliaAlberti/superbeads-universal-framework](https://github.com/EliaAlberti/superbeads-universal-framework) |
| **Stars** | 24 |
| **Forks** | 2 |
| **License** | MIT |
| **Language** | Shell |
| **Version** | 1.1.0 |
| **Created** | 2026-01-13 |
| **Last commit** | 2026-01-19 |
| **Total commits** | 10 (all in 6-day window) |
| **Contributors** | 1 (Elia Alberti) |
| **CI/CD** | None |
| **Tests** | None visible |
| **Issues/PRs ever** | 0 |
| **Status** | **Dormant** |

### Architecture (unchanged)

Four-agent system (Strategist/Executor/Specialist/Critic) with 5 domain packs (iOS, Python, Web, Design, PM). Uses Haiku for cost-optimized reviews, Sonnet for primary work. Session management via `/resume`, `/preserve`, `/wrapup`, `/compress` commands.

### Red Flags

1. **40-day development pause** after a 6-day initial burst — classic "weekend project" pattern
2. **Zero community interaction** — no issues, PRs, or discussions ever filed
3. **No CI/CD or test infrastructure** — quality assurance relies entirely on documentation
4. **Single contributor** with a UX design background, not software engineering
5. **No GitHub releases with assets** — version tracked only via README badge

## User Sentiment

**Overall: Negative** (stalled project with increasing platform risk)

### Reddit
- **Sentiment:** Cautious (Low confidence)
- **Common praise:** "Solves a real integration need" — multiple users independently combined the same tools before SuperBeads existed
- **Common complaints:** Framework fatigue; token cost concerns with four-agent architecture; "just use the components directly"
- **Notable threads:**
  - [SuperBeads launch post](https://www.reddit.com/r/ClaudeAI/comments/1qbsiw0/superbeads_universal_framework_wiggum_flavour/) — author's original announcement
  - [Is GSD feasible on Pro Plan?](https://www.reddit.com/r/ClaudeAI/comments/1qg6jvm/is_get_shit_done_gsd_via_claude_code_feasible_on/) — author explains motivation
  - [Superpowers VS. GSD VS. Others](https://www.reddit.com/r/ClaudeCode/comments/1qlsdjb/superpowers_vs_gsd_vs_others/) — users discuss combining tools (the problem SuperBeads solves)
- Most Reddit mentions are author self-promotion (4-5 threads); only 1 organic third-party mention found

### Twitter/X
- **Buzz level:** None
- **Trend:** N/A
- No tweets found referencing SuperBeads. Author has no identifiable Twitter/X account. The Claude Code ecosystem is very active on X, making this absence significant.

### LinkedIn
- **Professional adoption:** None
- No LinkedIn posts mention "SuperBeads" by name. Author (Elia Alberti) is active on LinkedIn as Lead UI/UX Product Designer at William Hill (~3,000 followers) with AI-related articles, but has not promoted SuperBeads there. Component tools (Beads, Superpowers, Ralph Wiggum) are each well-discussed on LinkedIn independently.

### Web
- **Coverage:** None
- No blog posts, articles, reviews, tutorials, or news coverage. Not listed in any curated awesome-claude-code collections. The only web mentions trace to author self-promotion on Reddit.

## Competitive Landscape

| Framework | Stars | Status | Differentiator |
|-----------|-------|--------|----------------|
| **Superpowers** | 42.4K+ | Active, marketplace-listed | Skills-based workflows (official plugin) |
| **Beads** | 14.5K+ | Active, concepts absorbed natively | Task tracking, context persistence |
| **everything-claude-code** | 37K+ | Active | Comprehensive configs, hackathon-validated |
| **GSD** | 10.5K+ | Active | Anti-complexity, minimal approach |
| **oh-my-claudecode** | 4K+ | Active | 32 specialized agents, 5 modes |
| **BMAD Method** | Established | Active, own subreddit | Heavy planning, role-based agents |
| **Hyperpowers** | New | Active | Similar Beads+Superpowers combo |
| **SuperBeads** | 24 | **Dormant** | Domain packs, unified methodology |
| **Native Tasks** | N/A | Anthropic first-party | Beads-inspired, zero setup |

**Key shift since Feb 4:** Anthropic's native Tasks feature directly threatens SuperBeads' value proposition. The [Todos are now Tasks in CC](https://www.reddit.com/r/ClaudeCode/comments/1qkddvz/todos_are_now_tasks_in_cc_inspired_by_beads/) thread documents this absorption. As Superpowers is now on the official marketplace and Beads concepts are native, the "meta-framework" rationale weakens — users can combine first-party features without a third-party wrapper.

## Pros and Cons

| Pros | Cons |
|------|------|
| Well-documented and comprehensive README | Development dormant 40+ days |
| Domain packs (iOS, Python, Web, Design, PM) add genuine value | Zero community contributions or interaction |
| Cost-optimized model selection (Haiku for reviews) | Single maintainer with uncertain commitment |
| Addresses a validated user need (tool integration) | Components becoming first-party (platform risk) |
| MIT licensed, fully open source | No Twitter/LinkedIn/web presence limits discovery |
| Listed in third-party skill registries | Framework fatigue pushback in community |
| | Token cost concerns with four-agent architecture |
| | No CI/CD, tests, or formal releases |

## Author Profile

- **Name:** Elia Alberti
- **Role:** Lead UI/UX Product & Interaction Designer at William Hill
- **Location:** London, UK
- **LinkedIn:** ~3,000 followers, active with AI content
- **Background:** 16+ years in product design (Shell, Vodafone, Sky, Depop)
- **Other projects:** "Cloddo" (Claude Desktop alternative)
- **Note:** Design background, not software engineering — explains the emphasis on documentation and methodology over code infrastructure

## Verdict

SuperBeads' trajectory since our last report confirms the early concerns: it was a well-conceived idea that failed to gain traction and now faces headwinds from platform-level changes. The project shows a classic "weekend project" arc — intense 6-day burst (Jan 13-19), then silence.

**What deteriorated:**
- Development stalled completely (40 days, no commits)
- Adoption barely moved (+3 stars in 24 days)
- Platform risk materialized (Anthropic native Tasks, Superpowers in marketplace)
- New competitor emerged (Hyperpowers)
- Still zero community interaction

**What held steady:**
- Documentation remains high-quality
- Domain packs still differentiated
- No negative user reports (but also no user reports at all)

**Recommendation: Avoid.** The project shows signs of abandonment, and its core value proposition — unifying Beads + Superpowers + Ralph Wiggum — is being eroded by first-party platform integration. Users wanting this combination should either use the native features directly or evaluate Hyperpowers as an actively maintained alternative. The domain packs remain SuperBeads' unique contribution; if the author resumes development and focuses on that differentiator, the assessment could change.

**For the prior report audience:** If you starred SuperBeads based on our Feb 4 "interesting for early adopters" recommendation, the wait-and-see period has not been encouraging. Consider the components individually instead.

## Sources

- [GitHub: EliaAlberti/superbeads-universal-framework](https://github.com/EliaAlberti/superbeads-universal-framework)
- [GitHub: withzombies/hyperpowers](https://github.com/withzombies/hyperpowers)
- [GitHub: majiayu000/claude-skill-registry](https://github.com/majiayu000/claude-skill-registry)
- [Reddit: SuperBeads launch post](https://www.reddit.com/r/ClaudeAI/comments/1qbsiw0/superbeads_universal_framework_wiggum_flavour/)
- [Reddit: Superpowers marketplace thread](https://www.reddit.com/r/ClaudeCode/comments/1qgkupf/superpowers_is_now_on_the_official_claude/)
- [Reddit: GSD feasibility on Pro Plan](https://www.reddit.com/r/ClaudeAI/comments/1qg6jvm/is_get_shit_done_gsd_via_claude_code_feasible_on/)
- [Reddit: Claude Code + Codex](https://www.reddit.com/r/ClaudeCode/comments/1qfu7ga/claude_code_codex_is_really_good/)
- [Reddit: Claude Code + Obsidian](https://www.reddit.com/r/ClaudeAI/comments/1qr19df/claude_code_obsidian_how_i_use_it_short_guide/)
- [Reddit: Superpowers VS. GSD VS. Others](https://www.reddit.com/r/ClaudeCode/comments/1qlsdjb/superpowers_vs_gsd_vs_others/)
- [Reddit: Todos are now Tasks (Beads-inspired)](https://www.reddit.com/r/ClaudeCode/comments/1qkddvz/todos_are_now_tasks_in_cc_inspired_by_beads/)
- [Reddit: Ralph Wiggum usage](https://www.reddit.com/r/ClaudeAI/comments/1qf85yh/ralph_wiggum_with_claude_code_how_people_are/)
- [Reddit: GSD framework](https://www.reddit.com/r/ClaudeCode/comments/1q4yi2u/get_shit_done_the_1_cc_framework_for_people_tired/)
- [Prior report: 2026-02-04-superbeads.md](catalogue/2026-02-04-superbeads.md)

---
*Generated by Research Agent on 2026-02-28 — Update of 2026-02-04 report*
