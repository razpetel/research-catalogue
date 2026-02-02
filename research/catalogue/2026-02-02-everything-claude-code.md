---
topic: everything-claude-code
slug: everything-claude-code
date: 2026-02-02
sources: [github, reddit, twitter, linkedin, web]
---

# everything-claude-code Research Report

## Overview

**everything-claude-code** is the most comprehensive Claude Code configuration collection available, created by Affaan Mustafa (@affaanmustafa), an Anthropic hackathon winner. With 37,000+ GitHub stars and 4,500+ forks in just two weeks since its January 2026 release, it has become the de facto standard for Claude Code power users.

The repository provides production-ready agents, skills, hooks, commands, rules, and MCP configurations evolved over 10+ months of intensive daily use building real products. It covers the entire Claude Code ecosystem in a single, well-organized package that installs as a plugin or can be manually copied.

What sets this apart from other Claude Code resources is its battle-tested nature—these aren't theoretical configurations but workflows that won a hackathon and are used daily in production. The recent addition of Python/Django, Java Spring Boot, and Go support shows active multi-language expansion.

## Technical Analysis

### Repository Health
- **Stars**: 37,048 | **Forks**: 4,593
- **Last commit**: 2026-02-01 (daily commits)
- **Status**: Very Active
- **License**: MIT
- **Requires**: Claude Code CLI v2.1.0+

### Component Inventory

| Category | Count | Purpose |
|----------|-------|---------|
| Agents | 11+ | Specialized subagents for delegation |
| Skills | 14+ | Workflow definitions & domain knowledge |
| Commands | 17+ | Slash-invoked actions |
| Rules | 6 | Always-enforced constraints |
| Hooks | 5+ | Event-driven automations |

### Agents Reference

| Agent | Purpose |
|-------|---------|
| `planner` | Feature implementation planning |
| `architect` | System design decisions |
| `tdd-guide` | Test-driven development |
| `code-reviewer` | Quality and security review |
| `security-reviewer` | Vulnerability analysis |
| `build-error-resolver` | Build error resolution |
| `e2e-runner` | Playwright E2E testing |
| `refactor-cleaner` | Dead code cleanup |
| `doc-updater` | Documentation sync |
| `go-reviewer` | Go-specific code review |
| `go-build-resolver` | Go build error resolution |

### Skills Reference

| Skill | Purpose |
|-------|---------|
| `coding-standards/` | Language best practices |
| `backend-patterns/` | API, database, caching patterns |
| `frontend-patterns/` | React, Next.js patterns |
| `continuous-learning` | Auto-extract patterns from sessions |
| `continuous-learning-v2` | Instinct-based learning with confidence scoring |
| `iterative-retrieval` | Progressive context refinement for subagents |
| `strategic-compact` | Manual compaction suggestions |
| `tdd-workflow` | TDD methodology |
| `security-review` | Security checklist |
| `verification-loop` | Continuous verification |
| `eval-harness` | Verification loop evaluation |
| `golang-patterns/` | Go idioms and best practices |
| `golang-testing/` | Go testing patterns, TDD, benchmarks |

### Commands Reference

| Command | Purpose |
|---------|---------|
| `/tdd` | Test-driven development workflow |
| `/plan` | Implementation planning |
| `/e2e` | E2E test generation |
| `/code-review` | Quality review |
| `/build-fix` | Fix build errors |
| `/refactor-clean` | Dead code removal |
| `/learn` | Extract patterns mid-session |
| `/checkpoint` | Save verification state |
| `/verify` | Run verification loop |
| `/setup-pm` | Configure package manager |
| `/go-review` | Go code review |
| `/go-test` | Go TDD workflow |
| `/go-build` | Fix Go build errors |
| `/skill-create` | Generate skills from git history |
| `/instinct-status` | View learned instincts |
| `/instinct-import` | Import instincts |
| `/instinct-export` | Export instincts |
| `/evolve` | Cluster instincts into skills |

### Rules Reference

| Rule | Purpose |
|------|---------|
| `security.md` | Mandatory security checks |
| `coding-style.md` | Immutability, file organization |
| `testing.md` | TDD, 80% coverage requirement |
| `git-workflow.md` | Commit format, PR process |
| `agents.md` | When to delegate to subagents |
| `performance.md` | Model selection, context management |

### Hook System

| Hook Type | Purpose |
|-----------|---------|
| `PreToolUse` | Validation before execution (e.g., warn about console.log) |
| `PostToolUse` | Formatting/linting after execution |
| `Stop` | When Claude finishes overall response |
| `SubagentStop` | When subagent finishes work |
| Session lifecycle | Memory persistence across sessions |

### Architecture Highlights

- **Plugin system**: `/plugin marketplace add affaan-m/everything-claude-code`
- **Cross-platform**: Full Windows, macOS, Linux support (Node.js rewrite)
- **Package manager detection**: Auto-detects npm, pnpm, yarn, bun with priority chain
- **Continuous learning**: Auto-extracts patterns from sessions
- **Memory persistence**: Hooks save/load context across sessions
- **Instinct system**: Confidence-scored learning with `/evolve` clustering
- **Three-layer config**: Plugin (read-only) → User (~/.claude/) → Project (./.claude/)

### Context Window Management

Critical consideration: The plugin's components compete for Claude Code's 200k token budget. Enabling too many MCPs simultaneously can reduce usable conversation context from ~160k to ~70k tokens.

**Best practice**: Configure 20-30 MCPs total but enable fewer than 10 per project, keeping total active tools under 80.

### Recent Updates (Last Week)
1. Python/Django support added
2. Java Spring Boot skills
3. Unified commands/skills (v1.2.0)
4. CLAUDE_PLUGIN_ROOT path fixes

## User Sentiment

**Overall: Very Positive** across all platforms

### Reddit
- "Just yesterday and already 1.2k stars wow" (now 37k+)
- GPU driver developer uses it daily
- Django community created adapted version
- Strong engagement in r/ClaudeCode, r/ClaudeAI

### Twitter
- Original guide thread went viral
- Associated with Boris Cherny's workflow reveal (5x productivity)
- Andrew Ng endorsement via Claude Code course

### LinkedIn
- Featured in enterprise contexts (healthcare AI at Fallgard)
- Andrew Ng course integration
- Growing professional adoption

## Competitive Landscape

| Resource | Comparison |
|----------|------------|
| SkillsMP (96,751 skills) | Broader but less curated |
| Individual .claude/ shares | Less comprehensive, inconsistent |
| Official Anthropic docs | Reference vs practical workflows |
| Cursor configs | Different tool ecosystem |

### Unique Value
1. Hackathon-proven (won Anthropic hackathon)
2. 10+ months of production refinement
3. Complete ecosystem coverage
4. Multi-language support expanding
5. Plugin + manual installation options
6. Active maintenance (daily commits)

## Pros and Cons

| Pros | Cons |
|------|------|
| Battle-tested in production | Requires Claude Code v2.1.0+ |
| Hackathon-winning pedigree | Rules require manual copy (plugin limitation) |
| Comprehensive coverage | May be overwhelming for beginners |
| Multi-language support | Single maintainer bottleneck risk |
| Plugin architecture | Some features are advanced |
| MIT license (free) | Token optimization requires learning curve |

## Installation

```bash
# Step 1: Install the Plugin
/plugin marketplace add affaan-m/everything-claude-code
/plugin install everything-claude-code@everything-claude-code

# Step 2: Install Rules (Required - Manual)
git clone https://github.com/affaan-m/everything-claude-code.git
cp -r everything-claude-code/rules/* ~/.claude/rules/
```

## Recommendations

**For new Claude Code users**: Start with the [Shorthand Guide](https://x.com/affaanmustafa/status/2012378465664745795) to understand philosophy, then install the plugin.

**For existing users**: Compare against your current setup—the verification loops, continuous learning, and eval harness are particularly valuable additions.

**For teams**: The security rules, testing requirements (80% coverage), and code-review agents provide immediate governance value.

## Sources

### Primary
- https://github.com/affaan-m/everything-claude-code
- https://deepwiki.com/affaan-m/everything-claude-code

### Twitter/X
- https://x.com/affaanmustafa/status/2012378465664745795 (Shorthand Guide)
- https://x.com/affaanmustafa/status/2014040193557471352 (Longform Guide)

### Reddit
- https://www.reddit.com/r/ClaudeCode/comments/1qg5l1a/
- https://www.reddit.com/r/ClaudeCode/comments/1qag5bu/
- https://www.reddit.com/r/django/comments/1q6aok6/
- https://www.reddit.com/r/ClaudeAI/comments/1qcwckg/

### News & Tutorials
- https://blog.devgenius.io/the-claude-code-setup-that-won-a-hackathon-a75a161cd41c
- https://blog.devgenius.io/the-advanced-claude-code-setup-guide-358f7b69334d
- https://venturebeat.com/orchestration/claude-code-2-1-0-arrives-with-smoother-workflows-and-smarter-agents
- https://www.scriptbyai.com/claude-code-resource-list/
- https://www.oreateai.com/blog/beyond-the-slash-unlocking-claudes-power-with-skills-hooks-and-subagents/

### LinkedIn
- https://www.linkedin.com/posts/andrewyng_im-thrilled-to-announce-the-definitive-course-activity-7358863230011625472-3oww

---
*Generated by Research Agent on 2026-02-02 | Updated with Longform Guide details*
