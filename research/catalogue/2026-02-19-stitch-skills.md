# Stitch Skills (google-labs-code)

**Date:** 2026-02-19
**URL:** https://github.com/google-labs-code/stitch-skills
**Sentiment:** Positive

## Summary

Google's official Agent Skills library for Stitch, providing 6 specialized skills that enable AI coding agents (Antigravity, Gemini CLI, Claude Code, Cursor) to automate the design-to-code pipeline. Uses Vercel's open Agent Skills standard (`npx skills add`), making it the first major Google adoption of this cross-vendor interoperability layer. Skills span the full workflow: design system documentation (design-md), prompt engineering (enhance-prompt), React component generation (react-components), autonomous site building (stitch-loop), video walkthroughs (remotion), and UI framework integration (shadcn-ui). 1,797 stars in 5 weeks with healthy community engagement but still early-stage. The stitch-loop "baton-passing" pattern for autonomous iterative building is architecturally novel. Part of Google's converging AI dev ecosystem: Stitch (design) -> Antigravity (code) -> Jules (backend) -> AI Studio (hub).

## Key Metrics

| Metric | Value |
|--------|-------|
| GitHub Stars | 1,797 |
| Forks | 199 |
| License | Apache-2.0 |
| Language | TypeScript |
| Created | Jan 16, 2026 |
| Last Commit | Feb 17, 2026 |
| Total Commits | 21 |
| Total Issues | 24 (6 open) |
| Skills Count | 6 |
| Installation CLI | `npx skills add` (Vercel ecosystem) |
| Compatible Agents | 37+ (Antigravity, Gemini CLI, Claude Code, Cursor, Codex, etc.) |

## What It Does

### The 6 Skills

| Skill | Purpose | Complexity |
|-------|---------|------------|
| **design-md** | Generates semantic DESIGN.md files from Stitch projects, creating a "source of truth" for consistent design language | Highest (6.6/10) |
| **enhance-prompt** | Transforms vague UI ideas into structured, Stitch-optimized prompts with design system integration | Medium (4.6/10) |
| **react-components** | Converts Stitch screens to modular React/Vite components with AST-based validation and design token consistency | Medium (2.5/10) |
| **stitch-loop** | Autonomous "baton-passing" loop for iterative multi-page website generation — orchestration-agnostic | Low (2.0/10) |
| **remotion** | Generates professional walkthrough videos from Stitch projects using Remotion with transitions, zoom, overlays | Low (2.0/10) |
| **shadcn-ui** | Expert guidance for shadcn/ui component integration with discovery, installation, and customization best practices | Low (2.0/10) |

### Skill Architecture (Agent Skills Open Standard)

Each skill follows a standardized structure:
```
skills/[name]/
  SKILL.md           — YAML frontmatter (name, description, allowed-tools) + instructions
  scripts/           — Executable validation and networking scripts
  resources/         — Checklists, style guides, templates
  examples/          — Gold standard references for few-shot learning
```

The `allowed-tools` field in SKILL.md controls what MCP tools and file operations each skill can access (e.g., `stitch*:*`, `Read`, `Write`, `Bash`).

### Installation

Uses Vercel's `skills` CLI — the open agent skills ecosystem:
```bash
# List all available skills
npx skills add google-labs-code/stitch-skills --list

# Install a specific skill globally
npx skills add google-labs-code/stitch-skills --skill design-md --global
```

The CLI auto-detects active coding agents and places skill files in the appropriate directory.

## Architectural Highlights

### The Stitch-Loop Baton Pattern

The most architecturally novel skill. Creates an autonomous building loop where:
1. Agent reads task from `next-prompt.md` (the "baton")
2. Generates a page using Stitch MCP tools
3. Integrates the page into site structure
4. Writes the next task to the baton file
5. Next iteration picks up the baton

Orchestration-agnostic — can be driven by CI/CD, human-in-the-loop review, agent chains, or manual repetition. Combined with `design-md` for visual consistency across iterations.

### Design-MD as Design System Source of Truth

The design-md skill is the ecosystem's foundation. It analyzes Stitch projects and synthesizes "Semantic Design Systems" using descriptive language + exact hex codes, optimized for how Stitch interprets prompts. Other skills (stitch-loop, enhance-prompt) depend on this output.

### React-Components with AST Validation

Goes beyond simple code generation — enforces:
- Modular component architecture
- Logic isolation in custom hooks
- Data decoupling to `mockData.ts`
- TypeScript Readonly interfaces
- AST-based validation via `npm run validate`

## Team

| Person | Role |
|--------|------|
| **David East** | Primary author — most skills, security, infrastructure |
| **Dion Almaer** | Google DevRel — merge approvals, remotion skill |
| **Sam El-Husseini** | Stitch team (credited in prior Stitch product work) |
| **vinothsubramanian** | Community contributor — shadcn-ui skill, CLI fix |
| **AsadSumbul** | Community contributor — docs normalization |

## Ecosystem Context

### Google AI Dev Stack

| Tool | Role | Connection |
|------|------|------------|
| **Stitch** | AI UI design generation | Generates screens, exports HTML/CSS/Tailwind |
| **stitch-skills** | Agent skills for design automation | Bridge between design and code |
| **Stitch MCP Server** | Programmatic access to Stitch | Used by skills for screen retrieval |
| **Antigravity** | AI coding agent/IDE | Primary consumer of skills |
| **Jules** | AI backend development | Receives designs from Stitch |
| **AI Studio** | Integration hub | Orchestration layer |

### Agent Skills Open Standard

stitch-skills is the first major Google repo using Vercel's Agent Skills standard:
- **CLI:** `npx skills` (npm package: `skills`)
- **Standard:** SKILL.md with YAML frontmatter
- **Compatible agents:** 37+ including Claude Code, Codex, Cursor, Gemini CLI
- **Directory:** Listed on skills.sh
- **Significance:** Google adopting Vercel's standard validates cross-vendor interoperability

## User Sentiment

### Positive
- AI-Buzz: "transforms Stitch from text-to-UI generator into an extensible platform"
- Itai Ben Zeev (Medium): Successfully rebuilt portfolio using stitch-skills + Antigravity as real production workflow
- r/AISEOInsider: "AI agents can now see your designs in Stitch, write code in Antigravity, and deploy instantly"
- Department of Product: Featured in newsletter alongside Stripe CEO's AI commentary

### Neutral/Cautious
- Google graveyard risk persists (Stitch is still "Labs" status)
- DeepWiki analysis shows wide complexity range between skills
- No deep independent benchmarking of skill output quality

### Community Engagement
- 199 forks suggest active experimentation
- Community-contributed shadcn-ui skill accepted
- Open PRs for AdaL CLI compatibility
- Feature requests for Flutter/React Native skills
- No significant negative feedback or bugs reported

### Absent Signals
- Zero Twitter/X visibility (unusual for 1,797-star repo)
- No HN discussion found
- Coverage skews toward SEO-tutorial content (Julian Goldie) rather than deep technical analysis

## Strengths

| Strength | Details |
|----------|---------|
| First-party Google repo | Not community-built — official google-labs-code org |
| Open standard adoption | Uses Vercel's Agent Skills standard for cross-agent compatibility |
| Well-structured skills | Each skill follows consistent SKILL.md + scripts + resources + examples pattern |
| Pipeline coverage | Spans design docs -> prompt engineering -> code generation -> video |
| Apache-2.0 license | Permissive, enterprise-friendly |
| Novel patterns | stitch-loop baton system is genuinely new |
| Free ecosystem | All of Stitch + skills are free to use |

## Limitations

| Limitation | Details |
|------------|---------|
| Early stage | Only 21 commits, 5 weeks old |
| Stitch dependency | Skills are tightly coupled to Stitch MCP Server |
| No quality benchmarks | No published evaluation of skill output quality vs manual |
| Google Labs status | Stitch itself could be discontinued |
| Limited skill count | 6 skills vs broader ecosystems (obra/superpowers: 196) |
| No CI/testing | No automated tests or CI pipeline visible |
| Tutorial-heavy coverage | Most content is promotional rather than critical analysis |

## Comparison

| Feature | stitch-skills | Vercel Agent Skills | obra/superpowers |
|---------|--------------|-------------------|-----------------|
| **Focus** | Stitch design-to-code | General frontend/AI | Workflow discipline |
| **Skills count** | 6 | ~15 | 196 |
| **Stars** | 1,797 | 21,500+ | 42,400 |
| **Standard** | Agent Skills (SKILL.md) | Agent Skills (SKILL.md) | Claude Code plugins |
| **Agent support** | 37+ via CLI | 37+ (native) | Claude Code only |
| **License** | Apache-2.0 | MIT | MIT |
| **Unique value** | Design system automation | Frontend best practices | TDD, debugging, review |

## Bottom Line

stitch-skills is Google's first official entry into the Agent Skills open standard ecosystem, providing 6 well-structured skills that automate the Stitch design-to-code pipeline. The repo is significant for two reasons: (1) it validates Vercel's Agent Skills standard as cross-vendor — if Google adopts it, it's becoming the de facto way to package agent capabilities; and (2) the stitch-loop baton-passing pattern demonstrates a genuinely novel approach to autonomous iterative building.

The skills themselves are well-architected (especially design-md and react-components with AST validation), but the repo is only 5 weeks old with 21 commits and no quality benchmarks. Coverage is more promotional than critical. The tight coupling to Stitch means these skills are only useful if you're in Google's AI dev ecosystem (Stitch + Antigravity).

**Recommended for:** Developers already using Google Stitch who want to automate design-to-code workflows, especially with Antigravity. Also worth studying the stitch-loop baton pattern and SKILL.md architecture for anyone building agent skills.

**Skip if:** You're not using Stitch, or you need production-validated skill outputs. The Google Labs status means this entire ecosystem could be deprecated.

## Sources

### Official
- [GitHub: google-labs-code/stitch-skills](https://github.com/google-labs-code/stitch-skills)
- [Stitch by Google](https://stitch.withgoogle.com/)
- [Stitch Prompting Guide](https://stitch.withgoogle.com/docs/learn/prompting/)

### Skills Ecosystem
- [Vercel: Introducing skills](https://vercel.com/changelog/introducing-skills-the-open-agent-skills-ecosystem)
- [GitHub: vercel-labs/skills](https://github.com/vercel-labs/skills)
- [npm: skills](https://www.npmjs.com/package/skills)
- [skills.sh Directory](https://skills.sh/google-labs-code/stitch-skills/design-md)

### News & Analysis
- [AI-Buzz: Google Stitch Agent Skills Update](https://www.ai-buzz.com/google-stitch-agent-skills-update-automates-design-to-code)
- [Department of Product: Google Stitch gets Skills](https://departmentofproduct.substack.com/p/google-stitch-gets-skills-and-stripes)
- [Geeky Gadgets: Stitch MCP Server, Agent Skills](https://www.geeky-gadgets.com/google-stitch-mcp-gemini-agent-skills/)
- [DeepWiki: stitch-skills analysis](https://deepwiki.com/google-labs-code/stitch-skills)

### Tutorials & Case Studies
- [Itai Ben Zeev: Agentic Engineering with Stitch](https://medium.com/@itaibenzeev/agentic-engineering-how-i-rebuilt-my-portfolio-with-stitch-ai-d9c889ed5887)
- [Julian Goldie: Google Stitch Agent Skills](https://juliangoldie.com/google-stitch-agent-skills/)
- [Codeagents Alpha: Agent Skills Guide](https://codeagentsalpha.substack.com/p/claude-agent-skills-complete-getting)

### Reddit
- [r/StitchAI: Stitch Agent Skills repo](https://www.reddit.com/r/StitchAI/comments/1r1yf7a/stitch_agent_skills_repo_for_designtocode/)
- [r/AISEOInsider: Stitch Skills AI](https://www.reddit.com/r/AISEOInsider/comments/1qs6q1z/stitch_skills_ai_googles_free_update_that_builds/)
- [r/AISEOInsider: Google Stitch Agent Skills](https://www.reddit.com/r/AISEOInsider/comments/1qoasu2/google_stitch_agent_skills_automate_design_docs/)

### LinkedIn
- [Julian Goldie: Stitch Agent Skills](https://www.linkedin.com/posts/juliangoldieseo_new-stitch-agent-skills-update-is-insane-activity-7421866516511612928-GtRb)
- [RediMinds: Stitch MCP Server](https://www.linkedin.com/posts/rediminds_stitch-mcp-server-give-your-coding-agent-activity-7419765946434867200-hGKC)

### Related Reports
- [Stitch by Google (2026-02-05)](catalogue/2026-02-05-stitch-by-google.md) — Stitch product overview
- [Vercel AI SDK Agent Skills (2026-02-06)](catalogue/2026-02-06-ai-sdk-agent-skills.md) — Agent skills standard
- [AGENTS.md vs Skills (2026-02-02)](catalogue/2026-02-02-agents-md-vercel-evals.md) — Skills vs context tradeoff

---
*Generated by Research Agent on 2026-02-19*
