---
topic: AGENTS.md vs Skills (Vercel Evals)
slug: agents-md-vercel-evals
date: 2026-02-02
sources: [github, reddit, twitter, linkedin, web]
---

# AGENTS.md vs Skills: Vercel's Agent Evaluation Research Report

## Overview

Vercel published a study comparing AGENTS.md (passive, always-available context) against Skills (on-demand retrieval) for guiding AI coding agents. The headline finding: **AGENTS.md achieved 100% pass rate vs Skills' 53%** when testing Next.js 16 APIs absent from model training data.

The study reveals a counterintuitive insight: skills weren't even invoked 56% of the time. Agents simply didn't bother looking them up. By contrast, AGENTS.md content remains available throughout all interactions, eliminating the decision point of whether to retrieve guidance. Vercel compressed their documentation from 40KB to 8KB (a focused index pointing to framework files rather than full docs) while maintaining perfect scores.

This research has significant implications for the AI coding assistant ecosystem. The AGENTS.md format (16,500+ GitHub stars) is emerging as a standard for project-level agent instructions, with support across Claude Code, Codex, Cursor, OpenCode, and GitHub Copilot. Meanwhile, Vercel's skills.sh hit 20,000+ installs within hours of launch, suggesting developers want both: persistent context AND reusable workflows.

## Technical Analysis

### Evaluation Methodology
- **Target**: Next.js 16 APIs absent from model training data
- **APIs tested**: `connection()`, `'use cache'` directives, `cacheLife()`, `forbidden()`
- **Approach**: Behavior-based assertions, retries for model variance
- **Configurations**: 4 tested (baseline, skills default, skills explicit, AGENTS.md)

### Results

| Configuration | Pass Rate | Build | Lint | Test |
|---------------|-----------|-------|------|------|
| Baseline (no docs) | 53% | — | — | — |
| Skills (default) | 53% | — | — | — |
| Skills + explicit instructions | 79% | — | — | — |
| AGENTS.md docs index | 100% | 100% | 100% | 100% |

### Why AGENTS.md Won
1. **No retrieval decision**: Always present = no skipping
2. **Consistent availability**: Every interaction has context
3. **Compressed efficiency**: 8KB index vs 40KB full docs
4. **No sequencing issues**: Skills require correct invocation order

### AGENTS.md Architecture
```
project-root/
├── AGENTS.md           ← Always loaded
│   ├── Dev environment tips
│   ├── Testing instructions
│   └── PR guidelines
```

### Skills Architecture
```
.claude/skills/
├── skill-name/
│   ├── SKILL.md        ← Loaded on-demand
│   ├── references/
│   └── scripts/
```

## User Sentiment

**Overall:** Mixed (Useful finding, but nuanced application)

- **Reddit:** Active debate on r/ClaudeCode. Community view: "AGENTS.md is project memory, skills are reusable tools." Concern about skill invocation overhead (~200 lines for instructions).
- **Twitter/X:** Limited dedicated discussion; conversation concentrated on Reddit/LinkedIn.
- **LinkedIn:** Professional interest from Vercel's Assaf Arkin and developer educators. Comparison guides emerging.

### Key Community Quotes
- "Passive context beats active retrieval"
- "Skills weren't invoked 56% of the time"
- "AGENTS.md and skills criss-cross — you need both"
- "Community plugins never fully fit my opinionated standards"

## Competitive Landscape

| Approach | Repository | Stars | Use Case |
|----------|------------|-------|----------|
| AGENTS.md (open format) | agentsmd/agents.md | 16,553 | Project-level persistent context |
| Vercel skills.sh | vercel-labs/skills | — | Package manager for agent skills |
| Microsoft agent-skills | microsoft/agent-skills | 232 | SDK grounding for agents |
| Anthropic Skills | Native Claude Code | — | On-demand specialized workflows |

### Emerging Consensus
- **AGENTS.md**: Best for project-specific context, conventions, testing instructions
- **Skills**: Best for reusable, cross-project workflows (TDD, code review, deployment)
- **Hybrid**: Many teams using both—AGENTS.md for "what" and Skills for "how"

## Implications

### For Individual Developers
1. **Prioritize AGENTS.md** for project setup: Include dev environment, testing, PR guidelines
2. **Use skills selectively**: Only for workflows you'd reuse across projects
3. **Compress documentation**: Focus on indexes and pointers, not full docs

### For Framework Authors
1. **Ship AGENTS.md with your framework**: Users get better agent support immediately
2. **Skills for opt-in complexity**: Advanced patterns as installable skills
3. **Test with agent evals**: Verify your docs work for AI, not just humans

### For Enterprise Teams
1. **Standardize on AGENTS.md**: Consistent project context across repos
2. **Curate internal skills library**: Reusable patterns for your stack
3. **Measure skill invocation rates**: Are agents actually using them?

## Pros and Cons

| AGENTS.md Pros | AGENTS.md Cons |
|----------------|----------------|
| Always available (100% invocation) | Project-specific (not reusable) |
| No retrieval decision needed | Requires per-project maintenance |
| Simpler architecture | Limited to static content |
| Proven 100% pass rate | No scripting/automation support |

| Skills Pros | Skills Cons |
|-------------|-------------|
| Reusable across projects | 56% non-invocation rate |
| Supports scripts/automation | Complex retrieval logic |
| Growing ecosystem (20K+ installs) | Token overhead for instructions |
| Encapsulated workflows | Sequencing dependencies |

## Recommendation

**Use AGENTS.md as your foundation.** The Vercel evaluation demonstrates that passive context outperforms on-demand retrieval for core project knowledge. Put your dev environment setup, testing instructions, and PR guidelines in AGENTS.md.

**Layer skills for reusable workflows.** Skills remain valuable for cross-project patterns (TDD enforcement, security reviews, deployment automation) that you'd apply to multiple codebases.

**Compress aggressively.** Vercel achieved 100% with 8KB. Your AGENTS.md should be an index pointing to detailed docs, not the docs themselves.

## Sources

### Primary Source
- https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals

### GitHub
- https://github.com/agentsmd/agents.md (16,553★)
- https://github.com/vercel-labs/agent-skills
- https://github.com/vercel-labs/skills

### News & Analysis
- https://jpcaparas.medium.com/vercel-says-agents-md-matters-more-than-skills-should-we-listen-d83d7dc2d978
- https://www.marktechpost.com/2026/01/18/vercel-releases-agent-skills-a-package-manager-for-ai-coding-agents/
- https://medium.com/@richardhightower/supercharge-your-react-performance-with-vercels-best-practices-agent-skill-for-claude-code-codex-212d6d2c0d8e

### Reddit
- https://www.reddit.com/r/ClaudeCode/comments/1qrollq/vercel_says_agentsmd_matters_more_than_skills/
- https://www.reddit.com/r/ClaudeCode/comments/1qifgbl/vercel_just_launched_skillssh_and_it_already_has/

### LinkedIn
- https://www.linkedin.com/posts/assafarkin_agentsmdoutperforms-skills-in-our-agent-activity-7422122165958926336-IvQu

---
*Generated by Research Agent on 2026-02-02*
