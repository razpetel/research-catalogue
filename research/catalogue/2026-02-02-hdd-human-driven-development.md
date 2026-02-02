# HDD: Human-Driven Development

> A methodology for building AI agents that actually work by observing human experts and iteratively diagnosing failures.

| Field | Value |
|-------|-------|
| **Date** | 2026-02-02 |
| **Author** | Sahar Carmel |
| **Source** | [Squid Club Blog](https://www.squid-club.com/blog/hdd-human-driven-development-how-i-build-ai-agents-that-actually-work) |
| **Category** | AI Agent Development Methodology |
| **Sentiment** | Positive - Practical, battle-tested approach |

---

## Summary

Human-Driven Development (HDD) is a methodology for building production-ready AI agents proposed by Sahar Carmel, Director of AI Enablement. The core insight: instead of designing agents through upfront architecture or prompt engineering, observe how human experts complete tasks, then iteratively improve agent performance through systematic failure diagnosis.

## The HDD Workflow

```
┌─────────────────────────────────────┐
│ 1. Watch domain experts do the task │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│ 2. Request Claude Code replicate it │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│ 3. Diagnose failure cause:          │
│    • Missing tools (capability gap) │
│    • Missing context (info gap)     │
│    • Missing constraints (too open) │
│    • Unclear task (ambiguous req)   │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│ 4. Add the missing capability       │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│ 5. Repeat until expert-level output │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│ 6. Migrate to Claude Agent SDK      │
└─────────────────────────────────────┘
```

## Core Principles

### 1. Observation-First Approach
> "Before writing any code, spend time with the human experts who do this task today. Watch them work."

### 2. Constraints Enable Better Output
Paradoxically, limiting LLM freedom improves results. The "SafeSpec" schema example restricts chart outputs to 10 valid types rather than allowing freeform generation.

### 3. Domain Artifacts as Gold
Organizational knowledge (dbt semantic layers, coding standards, playbooks) encodes institutional wisdom more valuable than sophisticated prompting. In Carmel's analytics dashboard case study, surfacing the dbt governance layer fixed incorrect queries that were hitting raw tables instead of governed metrics.

### 4. Subagents Preserve Focus
Decomposing complex tasks into specialized agents with clean interfaces prevents context pollution. Each agent does one thing well.

## Technology Stack

| Layer | Tool |
|-------|------|
| Development | Claude Code CLI |
| Production | Claude Agent SDK |
| Validation | Zod schemas |
| Data Governance | dbt Semantic Layer |
| Data Warehouse | BigQuery |

## Case Study: Analytics Dashboard

Initial failure: Claude queried outdated data tables rather than the organization's dbt semantic layer.

**Diagnosis:** Missing context (agent didn't know about data governance layer)

**Fix:** Surfaced dbt semantic layer as available context

**Result:** Agent produced correct queries validated by human stakeholders

## Author Background

**Sahar Carmel**
- Principal AI Engineer
- GitHub: [SaharCarmel](https://github.com/SaharCarmel) (57 repos, 137 stars)
- Notable project: TheAlmanac (MCP tool for documentation)
- LinkedIn: [saharcarmel](https://www.linkedin.com/in/saharcarmel/)
- Currently at Mixtiles
- Twitter: [@augu144](https://x.com/augu144)

## Community Context

### Reddit Alignment
The AI agent development community has converged on similar principles independently:
- Specialized agents outperform general-purpose ones
- Iterative refinement beats upfront design
- Human judgment remains critical
- "All you need is a good Claude.md and then a plan and status file"

### Competing Approaches

| Methodology | Starting Point | Focus |
|-------------|----------------|-------|
| **HDD** | Observe human experts | Diagnose specific failures |
| Prompt Engineering | Design prompts | Optimize instructions |
| Multi-Agent Orchestration | Design architecture | Coordinate specialists |
| TDD for Agents | Write tests first | Enforce discipline |
| Ralph Wiggum Technique | PRD → tasks | Autonomous loops |

### Industry Trend (2026)
- IEEE Spectrum: "2025 was the year AI agents became part of daily workflows"
- CIO: Hidden costs of agent evaluation due to non-deterministic output
- Consensus: "AI drafts. Engineers decide."

## HDD Differentiation

| Aspect | HDD | Typical Approaches |
|--------|-----|-------------------|
| Starting Point | Observe experts | Design prompts/architecture |
| Failure Response | Diagnose specific cause | Retry/expand prompts |
| Constraints | Enable better output | Limit creativity |
| Domain Knowledge | First-class citizen | Afterthought |
| Success Metric | Expert-level performance | Task completion |

## The "Compiler" Metaphor

HDD positions itself as a "compiler" for AI development—transforming high-level intent into correct implementation through systematic methodology rather than assembly-code-style manual prompting.

## Practical Takeaways

1. **Start by watching** - Don't architect, observe
2. **Categorize failures** - Tools, context, constraints, or clarity
3. **Surface domain artifacts** - Existing organizational knowledge beats prompt engineering
4. **Constrain output schemas** - Smaller valid output space = better results
5. **Use subagents** - One agent, one job, clean interfaces
6. **Iterate in Claude Code** - Then productionize via Agent SDK

## Related Resources

- [Squid Club](https://www.squid-club.com/) - Community for AI agent integration
- [Building an AI-Powered Trip Planning System](https://www.squid-club.com/blog/building-an-ai-powered-trip-planning-system-a-deep-dive-into-multi-agent-architecture-with-claude-code) - Author's multi-agent case study
- [TheAlmanac](https://github.com/SaharCarmel) - Author's MCP documentation tool

## Assessment

**Strengths:**
- Battle-tested methodology from production experience
- Clear diagnostic framework for agent failures
- Emphasizes domain knowledge over prompt tricks
- Practical toolchain (Claude Code → Agent SDK)

**Limitations:**
- Requires access to domain experts
- May not scale to novel tasks without human precedent
- Documentation limited to blog posts (no formal spec)

**Verdict:** A pragmatic, observation-driven methodology that aligns with emerging community practices. The failure categorization framework (tools/context/constraints/clarity) provides actionable debugging guidance missing from most agent development approaches.

---

*Researched: 2026-02-02 | Sources: Squid Club, GitHub, Reddit, LinkedIn, industry news*
