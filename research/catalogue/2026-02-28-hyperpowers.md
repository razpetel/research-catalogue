---
topic: Hyperpowers
slug: hyperpowers
date: 2026-02-28
sources: [github, reddit, twitter, linkedin, web]
---

# Hyperpowers Research Report

**Date:** 2026-02-28
**Sentiment:** Mixed (Cautiously Positive)
**Summary:** Actively maintained Claude Code plugin by security researcher Ryan Stortz that extends Superpowers with Beads task tracking, hooks, specialized agents, and Codex compatibility. Technically solid with 58 stars and steady development, but near-zero marketing and minimal community visibility limit adoption.

---

## Overview

Hyperpowers is a Claude Code plugin by Ryan Stortz (GitHub: withzombies), a security researcher formerly at Trail of Bits, now at Vigilant Labs. Created in October 2025, the plugin combines obra/superpowers-style structured development workflows with Steve Yegge's Beads task tracking system, adding hooks, specialized agents, and OpenAI Codex compatibility.

At 58 stars and 73 commits across 4 months, Hyperpowers is actively maintained (last commit February 27, 2026) and showing accelerating interest — 5 of its 9 forks were created in February 2026 alone. It went through a major v2.0 rewrite in November 2025 and now sits at v2.8.1 with monthly feature additions. The author is responsive to community issues (replying within hours) though slow on PR reviews.

Despite its technical substance, Hyperpowers has near-zero public visibility. There are no blog posts, reviews, news articles, or tutorials about it. Reddit has exactly 2 comment-level mentions (from the same user). The author has not promoted it on Twitter/X or LinkedIn. Discovery happens almost entirely through GitHub, plugin registries (claude-plugins.dev), and occasional organic Reddit recommendations.

## Technical Analysis

### Repository Health

| Attribute | Value |
|-----------|-------|
| **GitHub** | [withzombies/hyperpowers](https://github.com/withzombies/hyperpowers) |
| **Stars** | 58 |
| **Forks** | 9 (5 created in Feb 2026) |
| **License** | MIT (declared in plugin.json; no LICENSE file in repo) |
| **Language** | Shell 56.1%, Python 26.8%, JavaScript 17.1% |
| **Version** | 2.8.1 |
| **Created** | 2025-10-27 |
| **Last commit** | 2026-02-27 |
| **Total commits** | 73 |
| **Contributors** | 1 (Ryan Stortz) + 3 external PR/issue contributors |
| **CI/CD** | None |
| **Issues/PRs** | 3 total (1 open issue, 1 open PR, 1 closed PR) |
| **Status** | **Active** |

### Architecture

Hyperpowers is a pure markdown/documentation plugin — "prompt engineering as configuration." No executable code in the traditional sense; instead, detailed workflow instructions in markdown files guide Claude's behavior at runtime.

**Components:**

| Component | Count | Implementation |
|-----------|-------|----------------|
| Skills | 24 | Markdown with YAML frontmatter |
| Slash commands | 9 | Markdown expansion |
| Agents | 5 | Markdown subagent prompts |
| Hooks | 9 | Python, Shell, JavaScript |

**Skills coverage:**
- Feature development: brainstorming (Socratic method), writing-plans, executing-plans, review-implementation, finishing-a-development-branch
- Bug fixing: debugging-with-tools, root-cause-tracing, fixing-bugs
- Refactoring: refactoring-diagnosis, refactoring-design, refactoring-safely
- Quality: test-driven-development, testing-anti-patterns, verification-before-completion, analyzing-test-effectiveness
- Task management: managing-bd-tasks
- Meta: dispatching-parallel-agents, writing-skills, building-hooks, skills-auto-activation

**Specialized agents:**
- **code-reviewer** — reviews implementations against plans and standards
- **codebase-investigator** — explores codebase state and patterns
- **internet-researcher** — researches APIs, libraries, best practices
- **test-runner** — runs tests in separate context using Haiku (avoids context pollution)
- **test-effectiveness-analyst** — analyzes test quality and coverage

**Hooks system (key differentiator):**
- **UserPromptSubmit** — analyzes prompts and auto-suggests relevant skills before Claude responds
- **PreToolUse** — blocks direct reads of `.beads/issues.jsonl`, blocks edits to pre-commit hooks
- **PostToolUse** — tracks file edits, blocks bd task truncation, blocks pre-commit modifications
- **Stop** — gentle reminders for TDD, verification, commits
- **SessionStart** — initialization on startup/resume/clear/compact

**Beads integration (defining feature):**
- Automatic bead open/close during development
- `bd` CLI integration for task/issue tracking
- `.beads/issues.jsonl` with 81KB of tracked issues in the repo itself
- Task-by-task execution with documented findings between tasks

**Codex compatibility:**
- Ships `.agents/skills/` directory adapted for OpenAI Codex
- Maps Claude-specific concepts (Skill tool, TodoWrite, Task()) to Codex equivalents

### Development Velocity

| Period | Commits | Activity |
|--------|---------|----------|
| Oct 27-30, 2025 | ~42 | Initial creation burst |
| Nov 5-18, 2025 | ~6 | v2.0.0 complete rewrite to XML structure |
| Dec 5-26, 2025 | ~5 | v2.3.0-v2.6.0: design rationale, test effectiveness |
| Jan 21, 2026 | ~3 | v2.7.0-v2.8.0: Trail of Bits insights, dead code audit |
| Feb 9-27, 2026 | ~3 | Refactoring skills, Codex pack, v2.8.1 fix |

Pattern: Initial burst, then steady monthly updates. Healthy cadence for a solo project.

### What Hyperpowers Adds Over Superpowers

| Feature | Superpowers | Hyperpowers |
|---------|-------------|-------------|
| Structured workflows/skills | Yes | Yes (expanded) |
| Beads task tracking | No | Yes (deep integration) |
| Hooks system | Yes (basic) | Yes (9 hooks, auto-skill activation) |
| Specialized agents | Yes (basic) | Yes (5 agents, Haiku-based test runner) |
| Refactoring skills | No | Yes (3 dedicated skills) |
| SRE task refinement | No | Yes (uses Opus 4.1) |
| Codex compatibility | No | Yes |
| TDD enforcement | Yes | Yes (with hooks) |
| Pre-commit protection | No | Yes (hooks block modifications) |

## User Sentiment

**Overall: Mixed (Cautiously Positive)**

### Reddit
- **Sentiment:** Neutral-to-Positive (very low confidence — insufficient data)
- **Mentions:** 2 comments, both by user isakota in r/ClaudeCode
- **Key praise:** "good results," "basically Superpowers but with beads support," handles "iterative implementations" better than Claude Plan Mode
- **Key concerns:** None specific; general plugin fatigue and "ultrapowers" joke suggest Superpowers-derivative fatigue
- **Notable threads:**
  - [Beads vs. Plan Mode](https://www.reddit.com/r/ClaudeCode/comments/1qup2x7/claude_code_beads_vs_plan_mode/) — substantive recommendation
  - [Why does superpowers ask way better questions](https://www.reddit.com/r/ClaudeCode/comments/1qv6i38/why_does_superpowers_ask_way_better_questions/) — bare link recommendation

### Twitter/X
- **Buzz level:** None
- Author (@withzombies) has a Twitter account but posts about security research (Trail of Bits, iVerify, Binary Ninja), not Claude Code tooling
- Superpowers and Beads ecosystems are very active on X; Hyperpowers has not crossed over

### LinkedIn
- **Professional adoption:** None visible
- Author: Ryan Stortz, linkedin.com/in/rstortz, 737 followers
- Trail of Bits has significant LinkedIn presence around Claude Code skills (85-244 likes on related posts), but Hyperpowers itself is not mentioned
- No LinkedIn posts, articles, or professional endorsements for Hyperpowers

### Web
- **Coverage:** None
- No blog posts, articles, reviews, tutorials, news coverage
- Auto-indexed on claude-plugins.dev (writing-skills entry has 24 upvotes)
- Not in any curated awesome-claude-code lists
- Not on official Anthropic marketplace
- No Context7 documentation

## Author Profile

| Field | Value |
|-------|-------|
| **Name** | Ryan Stortz |
| **GitHub** | [withzombies](https://github.com/withzombies) |
| **Twitter** | [@withzombies](https://x.com/withzombies) |
| **LinkedIn** | [rstortz](https://www.linkedin.com/in/rstortz/) |
| **Location** | New York, NY |
| **Current role** | Vigilant Labs (title obscured) |
| **Previous** | Trail of Bits — Head of Product & Principal Security Researcher |
| **Earlier** | Raytheon, Allstate |
| **Education** | Ferris State University (network admin, C/C++, reverse engineering) |
| **Notable** | DEFCON CTF (Binary Ninja exploit generation for 2,000 binaries), Blackhat Ethereum, Rattle EVM binary analysis, iVerify Pegasus detection |

**Assessment:** Deeply credible security researcher with systems-level expertise. The verification-first, structured-rigor philosophy of Hyperpowers clearly reflects his security auditing background. Hyperpowers is a side project — his professional identity is in security, not developer tooling.

## Competitive Landscape

| Plugin | Stars | Status | Beads? | Marketplace? | Differentiator |
|--------|-------|--------|--------|-------------|----------------|
| **Superpowers** | 42.4K+ | Active | No | Official Anthropic | Dominant standard, broadest adoption |
| **Hyperpowers** | 58 | Active | Yes (deep) | Own only | Beads integration, hooks, Codex compat |
| **SuperBeads** | 24 | Dormant | Yes (partial) | No | Domain packs (iOS, Python, Web, etc.) |
| **GSD** | 10.5K+ | Active | No | No | Anti-complexity, ships fast |
| **BMAD** | Established | Active | No | No | Heavy planning, role-based agents |
| **Native Tasks** | N/A | First-party | Native | N/A | Zero setup, Anthropic-maintained |

**Key dynamics:**
- Hyperpowers is healthier than SuperBeads (active development vs. 40-day dormancy, 73 vs. 10 commits)
- Much smaller than Superpowers but adds genuine features not available upstream
- Anthropic native Tasks (inspired by Beads) is the long-term platform risk — if native task tracking becomes sufficient, the Beads differentiator weakens
- Not on the official Anthropic marketplace, limiting discoverability

## Pros and Cons

| Pros | Cons |
|------|------|
| Actively maintained with monthly updates | Single maintainer (bus factor 1) |
| Deep Beads integration (auto open/close) | Near-zero public visibility/marketing |
| Comprehensive hooks system (9 hooks) | Only 2 Reddit mentions, 0 tweets/articles |
| 5 specialized agents with context efficiency | Not on official Anthropic marketplace |
| Codex cross-platform support | No LICENSE file in repo (MIT in plugin.json only) |
| Credible author (Trail of Bits background) | No CI/CD or formal release process |
| Refactoring and SRE skills unique to Hyperpowers | Heavy dependency on Beads (bd) CLI |
| Accelerating fork growth (5 of 9 in Feb 2026) | Low community engagement (3 issues/PRs total) |
| Through v2.0 rewrite, architecturally mature | Platform risk from Anthropic native Tasks |

## Verdict

Hyperpowers is the technically strongest option in the "Superpowers + Beads" niche — more actively maintained than SuperBeads, more feature-rich (hooks, agents, Codex support), and authored by a credible security researcher. The verification-first philosophy and structured hooks system reflect genuine engineering rigor.

However, it remains a niche plugin with extremely low visibility. The 58 stars and 2 Reddit mentions mean the community has barely noticed it. The author has made zero effort to market it — no blog posts, no Twitter promotion, no marketplace submission, no tutorial content. This means adoption is limited to users who actively search for "Superpowers + Beads" combinations.

**Best for:**
- Developers already using both Superpowers and Beads who want seamless integration
- Users who value structured hooks for quality enforcement (auto-skill activation, pre-commit protection)
- Teams wanting both Claude Code and Codex compatibility
- Users who appreciate security-researcher-grade methodical workflows

**Consider alternatives if:**
- You want broad community support (use Superpowers directly)
- You don't use Beads (Superpowers alone is lighter and better supported)
- You need official marketplace availability (Superpowers is officially listed)
- You prefer minimal tooling (GSD or vanilla Claude Code)

**Recommendation:** Cautiously positive for the right audience. If you already use Beads and want Superpowers-style workflows, Hyperpowers is the best available integration. Watch for whether Anthropic's native Tasks feature reduces the need for Beads integration. The accelerating fork growth in February 2026 suggests growing word-of-mouth — this could gain meaningful traction if the author invests in marketing or achieves marketplace listing.

## Sources

- [GitHub: withzombies/hyperpowers](https://github.com/withzombies/hyperpowers)
- [GitHub: obra/superpowers](https://github.com/obra/superpowers)
- [GitHub: steveyegge/beads](https://github.com/steveyegge/beads)
- [Reddit: Beads vs. Plan Mode](https://www.reddit.com/r/ClaudeCode/comments/1qup2x7/claude_code_beads_vs_plan_mode/)
- [Reddit: Why does superpowers ask way better questions](https://www.reddit.com/r/ClaudeCode/comments/1qv6i38/why_does_superpowers_ask_way_better_questions/)
- [Reddit: Superpowers VS. GSD VS. Others](https://www.reddit.com/r/ClaudeCode/comments/1qlsdjb/superpowers_vs_gsd_vs_others/)
- [Reddit: Superpowers plugin actually delivers](https://www.reddit.com/r/ClaudeCode/comments/1r9y2ka/claude_codes_superpowers_plugin_actually_delivers/)
- [LinkedIn: Trail of Bits Claude Code Skills](https://www.linkedin.com/posts/snyff_github-trailofbitsskills-trail-of-bits-activity-7418868331828490240-9kB6)
- [LinkedIn: Clint Gibler on Trail of Bits Skills](https://www.linkedin.com/posts/clintgibler_trail-of-bits-claude-code-skills-for-activity-7417679372691845120-wDN0)
- [claude-plugins.dev: Hyperpowers skills](https://claude-plugins.dev/skills/@withzombies/hyperpowers/)
- [Prior report: SuperBeads (2026-02-28)](catalogue/2026-02-28-superbeads.md)
- [Prior report: Beads (2026-02-03)](catalogue/2026-02-03-beads-steve-yegge.md)
- [Prior report: Superpowers (2026-02-02)](catalogue/2026-02-02-obra-superpowers.md)

---
*Generated by Research Agent on 2026-02-28*
