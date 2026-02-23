---
topic: Vercel Agent Skills Architecture
slug: vercel-agent-skills-architecture
date: 2026-02-06
sources: [github, reddit, twitter, linkedin, web]
---

# Vercel Agent Skills Architecture Research Report

## Overview

This report covers a complete intellectual arc in Vercel's agent skills work: first, an empirical evaluation exposing a critical failure mode in on-demand skill retrieval; then, an architectural response that directly addresses that failure.

**Part 1 (2026-02-02):** Vercel published a controlled study comparing AGENTS.md (passive, always-available context) against Skills (on-demand retrieval) for guiding AI coding agents on Next.js 16 APIs absent from model training data. The headline finding: **AGENTS.md achieved 100% pass rate vs Skills' 53%**. The deeper finding was more troubling — skills weren't invoked at all 56% of the time. Agents simply didn't bother looking them up.

**Part 2 (2026-02-06):** Vercel's AI SDK cookbook guide (`ai-sdk.dev/cookbook/guides/agent-skills`) provided the architectural response: a three-phase **progressive disclosure** model where skill descriptions are always present in the system prompt (like AGENTS.md), but full content loads lazily only when triggered (like skills). This is an explicit architectural answer to their own evaluation findings.

Together, these form a case study in AI system design: measure failure → understand the mechanism → engineer a structural fix. The result is the most rigorous vendor-neutral specification for agent skills to date, part of the broader Vercel AI SDK (21.5K GitHub stars, TypeScript).

---

## Part 1: Evaluation Findings

### Methodology

Vercel designed an evaluation targeting a scenario where agents have no prior knowledge: **Next.js 16 APIs absent from model training data**.

- **APIs tested**: `connection()`, `'use cache'` directives, `cacheLife()`, `forbidden()`
- **Approach**: Behavior-based assertions with retries to account for model variance
- **Configurations tested**: 4 (baseline, skills default, skills with explicit instructions, AGENTS.md)

### Results

| Configuration | Pass Rate | Build | Lint | Test |
|---------------|-----------|-------|------|------|
| Baseline (no docs) | 53% | — | — | — |
| Skills (default) | 53% | — | — | — |
| Skills + explicit instructions | 79% | — | — | — |
| AGENTS.md docs index | 100% | 100% | 100% | 100% |

The baseline and default skills configurations performed identically at 53% — meaning skills provided zero benefit when agents weren't explicitly instructed to use them. AGENTS.md with explicit retrieval instructions achieved 100% across all assertion categories.

### Why AGENTS.md Won

1. **No retrieval decision**: Always present means agents never skip it
2. **Consistent availability**: Every interaction has the same context
3. **Compressed efficiency**: Vercel used an 8KB index pointing to framework files rather than 40KB of full docs — focused pointers outperform exhaustive documentation
4. **No sequencing issues**: Skills require correct invocation order; AGENTS.md has no such dependency

### The 56% Non-Invocation Finding

The most significant finding was not the pass rate gap itself, but the mechanism behind it. Skills weren't invoked 56% of the time — agents defaulted to their training data rather than retrieving available guidance. This is a fundamental property of on-demand retrieval systems: the agent must first decide a skill is relevant before loading it. If that decision fails (due to task framing, confidence in existing knowledge, or prompt structure), the skill might as well not exist.

### AGENTS.md Architecture

```
project-root/
├── AGENTS.md           ← Always loaded
│   ├── Dev environment tips
│   ├── Testing instructions
│   └── PR guidelines
```

### Skills Architecture (as evaluated)

```
.claude/skills/
├── skill-name/
│   ├── SKILL.md        ← Loaded on-demand
│   ├── references/
│   └── scripts/
```

The problem is the "loaded on-demand" step — the agent must choose to load it.

---

## Part 2: Architectural Response — Progressive Disclosure

### The Core Innovation

The AI SDK Agent Skills guide formalizes a three-phase context management strategy that resolves the tension identified in Part 1:

| Phase | What loads | Token cost | When |
|-------|-----------|------------|------|
| Discovery | Skill names + descriptions | ~100 tokens total | Agent startup |
| Activation | Full `SKILL.md` instructions | Variable (hundreds to thousands) | Task matches a skill |
| Execution | Scripts, templates, references | On-demand via existing tools | Agent needs bundled resources |

This is a structural middle ground between AGENTS.md (always-loaded, high token cost, 100% availability) and naive skills (on-demand, low token cost, 53% invocation failure). Descriptions are always present at startup — so agents always know what skills exist — but full content only loads when a skill is actually triggered. The 56% non-invocation problem is addressed at the architecture level, not through prompting.

### SKILL.md Format

```yaml
---
name: react-performance
description: Use when optimizing React component rendering, reducing re-renders, or improving bundle size
---

[Unrestricted markdown instructions...]
```

Key design decisions:
- No mandatory structure beyond frontmatter — maximum flexibility for skill authors
- Skill directory can contain any supporting files (scripts, templates, configs)
- Agent constructs relative paths from the skill directory path returned by `loadSkill`
- "First wins" duplicate resolution enables project-level overrides of global skills

### Implementation Components

The guide provides a complete reference implementation:

1. **Sandbox interface**: Generic abstraction with `readFile()`, `readdir()`, `exec()` — adaptable to Node.js, Docker, cloud storage, or WebContainers
2. **Skill discovery**: Scans configured directories for valid `SKILL.md` files
3. **System prompt builder**: Injects available skill names/descriptions into agent instructions at startup
4. **`loadSkill` tool**: Uses `experimental_context` to read full skill content; returns both skill directory path and stripped content
5. **Resource access**: Agents use existing `readFile` and `bash` tools to access bundled resources

### TypeScript Integration

The guide targets AI SDK v5+/v6 using `ToolLoopAgent`:

```typescript
const agent = new ToolLoopAgent({
  model: yourModel,
  tools: { loadSkill, readFile, bash },
  prepareCall: ({ options, ...settings }) => ({
    ...settings,
    instructions: `${settings.instructions}\n\n${buildSkillsPrompt(options.skills)}`,
    experimental_context: { sandbox: options.sandbox, skills: options.skills },
  }),
});
```

Note: `experimental_context` is marked experimental in the AI SDK — the pattern may evolve as the API stabilizes.

### Ecosystem

The architecture is attracting third-party adoption:

- **Bluebag.ai**: Commercial `@bluebag/ai-sdk` package providing "three lines of code" integration with hosted skill repositories — fills the gap of remote skill loading that the reference implementation deliberately omits
- **agent-skills.md**: Community registry listing skills compatible with this format including a Vercel AI SDK v5 implementation guide skill
- **claude-plugins.dev**: Additional community skill discovery surface
- **claude-nextjs-skills**: Community-contributed Next.js skill available on both registries

---

## Competitive Landscape

### Agent Guidance Approaches

| Approach | Repository | Stars | Use Case |
|----------|------------|-------|----------|
| AGENTS.md (open format) | agentsmd/agents.md | 16,553 | Project-level persistent context |
| Vercel AI SDK Agent Skills | vercel/ai cookbook | 21,500 (SDK) | Vendor-neutral progressive disclosure |
| Vercel skills.sh | vercel-labs/skills | — | Package manager for agent skills |
| Claude Code Skills | Native Claude Code | — | On-demand specialized workflows |
| obra/superpowers | jesse-vincent/superpowers | 42,400 | Workflow-enforcing skills for Claude Code |
| Microsoft agent-skills | microsoft/agent-skills | 232 | SDK grounding for agents |

### Framework Comparison

| System | Approach | vs AI SDK Agent Skills |
|--------|----------|----------------------|
| Claude Code Skills | `SKILL.md` in `.claude/skills/` | Nearly identical format; Claude-specific runtime |
| Cursor Rules | `.cursor/rules/` with YAML frontmatter | Similar concept; IDE-specific, no sandbox abstraction |
| OpenAI Agents SDK | Custom actions/tools | Tool-oriented, not knowledge-oriented |
| LangChain/LangGraph | Chains and agent executors | More complex; skills are a simpler primitive |
| Mastra | Agent framework with memory | Competing framework; different skill abstraction |
| CrewAI | Multi-agent crews with roles | Role-based, not skill-based knowledge injection |
| AGENTS.md | Passive context in repo | Always-loaded vs on-demand; different tradeoff |

**Key differentiator of the AI SDK guide**: It is the only vendor-neutral, framework-agnostic specification for agent skills. It provides the architectural blueprint without tying to a specific AI provider, IDE, or platform. The same `SKILL.md` format used here is used by Claude Code Skills and obra/superpowers — suggesting convergence on a standard.

---

## Community Sentiment

**Overall: Mixed-positive (Useful finding + architectural response, with acknowledged limitations)**

### Evaluation Findings Reception

- **Reddit (r/ClaudeCode)**: Active debate. Community view: "AGENTS.md is project memory, skills are reusable tools." Concern about skill invocation overhead (~200 lines for skill instructions).
- **Twitter/X**: Limited dedicated discussion; conversation concentrated on Reddit/LinkedIn.
- **LinkedIn**: Professional interest from Vercel's Assaf Arkin and developer educators. Comparison guides emerging.

### Key Community Quotes
- "Passive context beats active retrieval"
- "Skills weren't invoked 56% of the time"
- "AGENTS.md and skills criss-cross — you need both"
- "Community plugins never fully fit my opinionated standards"

### AI SDK Architecture Reception

- **Reddit (r/LLMDevs)**: Interest in the progressive disclosure model — noted it "shifts agentic workflows from probabilistic prompting to deterministic engineering judgment." Initial skills encode 40+ React performance checks, 100+ web design/accessibility rules, and a deployment skill.
- **Reddit (r/ClaudeAI)**: Community awareness of the agent skills guide but skepticism about whether frameworks (Mastra, LangChain, AI SDK) should dictate skill implementation.
- **LinkedIn**: Steve Flitcroft posted about "Vercel AI SDK v6 Released with Custom Agent Skills," suggesting enterprise awareness.
- **Ecosystem signals**: Bluebag.ai building commercial product on this pattern; community registries forming.

---

## Pros and Cons

### AGENTS.md

| Pros | Cons |
|------|------|
| Always available (100% invocation) | Project-specific (not reusable) |
| No retrieval decision needed | Requires per-project maintenance |
| Simpler architecture | Limited to static content |
| Proven 100% pass rate | No scripting/automation support |

### Naive Skills (pre-progressive disclosure)

| Pros | Cons |
|------|------|
| Reusable across projects | 56% non-invocation rate |
| Supports scripts/automation | Complex retrieval logic |
| Growing ecosystem (20K+ installs) | Token overhead for instructions |
| Encapsulated workflows | Sequencing dependencies |

### Progressive Disclosure (AI SDK pattern)

| Pros | Cons |
|------|------|
| Vendor-neutral, framework-agnostic | "Cookbook guide" not a library — no npm package |
| Descriptions always present (addresses 56% problem) | Uses `experimental_context` — API may change |
| Full content loads lazily (controls token cost) | No built-in skill registry or marketplace |
| Complete reference implementation in TypeScript | Discovery limited to local directories |
| Same SKILL.md format as Claude Code | No remote skill loading (Bluebag fills this gap commercially) |
| "First wins" enables project-level overrides | Agent still must choose to invoke `loadSkill` after seeing description |
| Sandbox abstraction works across environments | No versioning, dependency management, or conflict resolution |

---

## Bottom Line and Recommendations

### The Unified Finding

AGENTS.md and progressive-disclosure skills are not competing approaches — they solve different problems. The Vercel evaluation showed that passive context (AGENTS.md) beats naive on-demand retrieval when agents won't reliably invoke skills. The progressive disclosure architecture addresses the invocation failure by ensuring descriptions are always present, making skills self-advertising without loading their full content upfront.

### For Individual Developers

1. **Use AGENTS.md as your foundation**: Include dev environment setup, testing instructions, and PR guidelines. The evaluation proves passive context works.
2. **Use progressive disclosure skills for reusable workflows**: Cross-project patterns (TDD enforcement, security reviews, deployment automation) belong in skills — but implement them with the AI SDK pattern where descriptions are always in context.
3. **Compress aggressively**: Vercel achieved 100% with an 8KB index. AGENTS.md should point to details, not contain them.
4. **Measure invocation rates**: If you're using naive skills, check whether agents actually invoke them.

### For Framework Authors

1. **Ship AGENTS.md with your framework**: Users get immediate agent support.
2. **Publish skills using the SKILL.md format**: Compatibility with the emerging cross-platform standard (Claude Code, AI SDK, obra/superpowers).
3. **Test with agent evals**: Verify your docs work for AI agents, not just human readers.

### For Enterprise Teams

1. **Standardize on AGENTS.md**: Consistent project context across repos.
2. **Curate internal skills with progressive disclosure**: Use the AI SDK pattern to avoid the invocation failure rate.
3. **Adopt the SKILL.md format**: It's converging as a cross-platform standard — don't invest in proprietary skill formats.

---

## Sources

### Primary Sources
- https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals
- https://ai-sdk.dev/cookbook/guides/agent-skills

### GitHub
- https://github.com/agentsmd/agents.md (16,553 stars)
- https://github.com/vercel-labs/agent-skills
- https://github.com/vercel-labs/skills
- https://github.com/vercel/ai (21,500 stars)
- https://github.com/vercel/ai/issues/9595 (Support for Claude Agent Skills)

### News & Analysis
- https://jpcaparas.medium.com/vercel-says-agents-md-matters-more-than-skills-should-we-listen-d83d7dc2d978
- https://www.marktechpost.com/2026/01/18/vercel-releases-agent-skills-a-package-manager-for-ai-coding-agents/
- https://medium.com/@richardhightower/supercharge-your-react-performance-with-vercels-best-practices-agent-skill-for-claude-code-codex-212d6d2c0d8e
- https://www.telerik.com/blogs/building-ai-agents-typescript-ai-sdk
- https://dev.to/shue_zheng_a1d2e9cc33f6fd/sandagentsdk-run-claude-in-a-sandbox-with-vercel-ai-sdk-streams-1ed3

### Reddit
- https://www.reddit.com/r/ClaudeCode/comments/1qrollq/vercel_says_agentsmd_matters_more_than_skills/
- https://www.reddit.com/r/ClaudeCode/comments/1qifgbl/vercel_just_launched_skillssh_and_it_already_has/
- https://www.reddit.com/r/LLMDevs/comments/1qgu8qr/vercels_opensource_agent_skills_hint_at_the_next/
- https://www.reddit.com/r/ClaudeAI/comments/1qcwr6x/how_are_agent_skills_used_in_real_systems/

### LinkedIn
- https://www.linkedin.com/posts/assafarkin_agentsmdoutperforms-skills-in-our-agent-activity-7422122165958926336-IvQu
- https://www.linkedin.com/posts/steveflitcroft_aisdk-verce-ail-activity-7419875580894023680-zGrR

### Ecosystem
- https://www.bluebag.ai/blog/how-to-add-agent-skills-to-your-vercel-ai-sdk-agents
- https://claude-plugins.dev/skills/@wsimmonds/claude-nextjs-skills/vercel-ai-sdk
- https://agent-skills.md/skills/wsimmonds/claude-nextjs-skills/vercel-ai-sdk

---
*Generated by Research Agent — unified from reports dated 2026-02-02 and 2026-02-06*
