# obra/superpowers

**Date:** 2026-02-02
**URL:** https://github.com/obra/superpowers
**Sentiment:** 🟢 Very Positive

## Summary

Superpowers is an agentic skills framework for Claude Code that transforms AI coding assistants from reactive helpers into autonomous development partners. Created by Jesse Vincent (obra), it enforces structured workflows—brainstorming, planning, TDD, debugging, and code review—that prevent AI agents from "jumping straight to implementation without thinking." With 42.4k GitHub stars and official inclusion in Anthropic's Claude plugins marketplace, it has become the most popular skills library for AI-assisted development.

## Key Metrics

| Metric | Value |
|--------|-------|
| GitHub Stars | 42.4k |
| Forks | 3.2k |
| License | MIT |
| Languages | Shell (70.5%), JavaScript (19.0%), Python (5.2%) |
| Context7 Snippets | 728 |
| Official Status | Anthropic Marketplace (PR #148) |

## What It Does

Superpowers works by loading markdown "SKILL.md" files that instruct Claude Code how to approach specific tasks. The system auto-triggers when relevant, enforcing discipline that developers often skip:

1. **Brainstorming** - Socratic design refinement before any code
2. **Planning** - Breaks work into bite-sized tasks (2-5 min each) with file paths and verification steps
3. **Test-Driven Development** - RED-GREEN-REFACTOR methodology enforced
4. **Systematic Debugging** - 4-phase root cause analysis
5. **Code Review** - Subagent reviews between task executions
6. **Verification** - Evidence-based completion checks

### The Iron Law
> "NO SKILL WITHOUT A FAILING TEST FIRST. This applies to NEW skills AND EDITS to existing skills."

## Installation

```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

## Ecosystem

| Repository | Purpose |
|------------|---------|
| `obra/superpowers` | Core framework |
| `obra/superpowers-skills` | Community-editable skills |
| `obra/superpowers-marketplace` | Curated plugin distribution |
| `obra/superpowers-lab` | Experimental features (tmux, etc.) |
| `superpowers-laravel` | Laravel-specific fork |
| `superpowers-symfony` | Symfony-specific fork |

## Creator

**Jesse Vincent** (obra)
- 30-year software engineering veteran
- Creator of Keyboardio ergonomic keyboards
- Created Jifty Perl framework
- Company: Prime Radiant, Inc
- Blog: blog.fsck.com
- LinkedIn: linkedin.com/in/jessevincent

Wikipedia notes his work on "Architect/Implementer" patterns for parallel agent development.

## Community Reception

### Reddit (r/ClaudeCode, r/ClaudeAI)
- "Superpowers enforces the workflow you'd follow yourself if you had infinite patience"
- "The brainstorm, plan, execute loop is incredibly powerful"
- Killer feature: session-independent development—close Claude, return days later, continue seamlessly

### LinkedIn
- Active professional adoption
- Product managers writing about it (not just developers)
- Multiple "getting started" tutorials

### Tech Press
- **Scientific American:** "How Claude Code is bringing vibe coding to everyone"
- **Vox:** "Why this AI tool has tech people freaking out"
- **ByteIota:** "GitHub's #1 Skills Library for Autonomous Coding"
- **Medium:** "Claude Code Got 100x Better With Superpowers"

### Notable Endorsements
- Simon Willison covered the launch
- Deemed Wikipedia-worthy (entry exists)

## Unique Technical Approach

Vincent uses principles from Cialdini's *Influence* to ensure skill compliance—pressure-testing skills with psychological scenarios (urgency, sunk cost) to verify Claude actually uses them instead of relying on training knowledge.

Reference: METR study found experienced developers are 19% slower with AI tools. Superpowers provides "structural guardrails" to avoid this trap.

## Criticisms & Limitations

- **Learning curve:** Some users struggle with plugin installation and optimal usage
- **Performance:** GitHub issue #189 noted slowdowns
- **Not for simple tasks:** Overhead unnecessary for quick fixes

## Alternatives & Comparisons

- Often compared to "Ralph Loop" (rated less favorably)
- Combined with `oh-my-opencode` for multi-model orchestration
- Context7 plugin recommended as companion for documentation access

## Sources

### Primary
- [GitHub Repository](https://github.com/obra/superpowers)
- [Creator's Blog Post](https://blog.fsck.com/2025/10/09/superpowers/)
- [Jesse Vincent LinkedIn](https://www.linkedin.com/in/jessevincent/)

### Press Coverage
- [Scientific American - Vibe Coding](https://scientificamerican.com/article/how-claude-code-is-bringing-vibe-coding-to-everyone)
- [Vox - Claude Code Explained](https://www.vox.com/future-perfect/475370/anthropic-claude-code-artificial-intelligence-coder-jobs)
- [ByteIota - GitHub #1](https://byteiota.com/claude-code-superpowers-githubs-1-skills-library-for-autonomous-coding/)
- [Dev.to - Agentic Development 2026](https://dev.to/chand1012/the-best-way-to-do-agentic-development-in-2026-14mn)
- [Medium - Superpowers Explained](https://blog.devgenius.io/superpowers-explained-the-claude-plugin-that-enforces-tdd-subagents-and-planning-c7fe698c3b82)

### Community
- [Reddit - Official Marketplace Inclusion](https://www.reddit.com/r/ClaudeCode/comments/1qgkupf/superpowers_is_now_on_the_official_claude/)
- [Simon Willison's Coverage](https://simonwillison.net/2025/Oct/10/superpowers/)
