# Stitch MCP (Google Stitch MCP Server Ecosystem)

**Date:** 2026-02-23
**URL:** https://github.com/davideast/stitch-mcp
**Sentiment:** Mixed-to-Positive

## Summary

The MCP server ecosystem for Google's Stitch AI UI design tool, enabling AI coding agents (Claude Code, Cursor, Antigravity, Gemini CLI, Codex) to generate, retrieve, and manage UI designs programmatically. Not a single repo but a multi-layered ecosystem: Google hosts the cloud MCP service at stitch.googleapis.com (free); davideast/stitch-mcp (305 stars) by a Google employee provides the leading CLI/proxy client with Vite preview, Astro site generation, and automatic token refresh; google-labs-code/stitch-skills (1,915 stars) provides 6 Agent Skills; gemini-cli-extensions/stitch (270 stars) provides Gemini CLI integration; and Kargatharaakash/stitch-mcp (60 stars) offers an alternative community client with 9 tools including `extract_design_context`. Setup friction (authentication complexity, state synchronization bugs) remains the primary adoption barrier, but the ecosystem is evolving rapidly with native MCP now built into Stitch's export menu and 20 commits/week on the leading client. Complementary to Figma MCP: Stitch generates designs from prompts while Figma reads existing designs.

## Key Metrics

| Metric | Value |
|--------|-------|
| **Google MCP Service** | stitch.googleapis.com (free, cloud-hosted) |
| **davideast/stitch-mcp** | 305 stars, 35 forks, Apache-2.0, TypeScript |
| **google-labs-code/stitch-skills** | 1,915 stars, 219 forks, Apache-2.0 |
| **gemini-cli-extensions/stitch** | 270 stars, 18 forks, Apache-2.0 |
| **Kargatharaakash/stitch-mcp** | 60 stars, 12 forks, Apache-2.0, JavaScript |
| **Stitch Pricing** | Free (unlimited Flash, 400 Pro uses/month) |
| **MCP Pricing** | Free |
| **Supported Clients** | VS Code, Cursor, Claude Code, Gemini CLI, Codex, OpenCode, Antigravity |
| **Created** | Jan 15-19, 2026 (clients); Dec 2, 2025 (Gemini extension) |
| **Last Commit (davideast)** | 2026-02-23 (20 commits in last week) |

## Ecosystem Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                 Google Cloud (Free)                          │
│  stitch.googleapis.com — Stitch MCP Server                  │
│  AI Models: Gemini 2.5 Pro/Flash, Gemini 3 Pro/Flash       │
└──────────────────┬──────────────────────────────────────────┘
                   │ MCP Protocol (HTTP/stdio)
        ┌──────────┼──────────┬──────────────────┐
        ▼          ▼          ▼                  ▼
  ┌──────────┐ ┌────────┐ ┌──────────┐ ┌────────────────┐
  │davideast/│ │Kargath-│ │gemini-cli│ │Native MCP      │
  │stitch-mcp│ │araakash│ │-ext/stitch│ │(Stitch export │
  │305★      │ │60★     │ │270★       │ │menu, Feb 2026)│
  └────┬─────┘ └───┬────┘ └────┬─────┘ └───────┬────────┘
       │           │           │                │
       ▼           ▼           ▼                ▼
  ┌──────────────────────────────────────────────────────┐
  │ AI Coding Agents                                      │
  │ Claude Code · Cursor · Antigravity · Gemini CLI ·     │
  │ Codex · OpenCode · VS Code                            │
  └──────────────────────────────────────────────────────┘
       │
       ▼
  ┌──────────────────────────────────────────────────────┐
  │ google-labs-code/stitch-skills (1,915★)               │
  │ 6 Agent Skills: design-md, react-components,          │
  │ stitch-loop, enhance-prompt, remotion, shadcn-ui      │
  └──────────────────────────────────────────────────────┘
```

## The Four Implementations

### 1. davideast/stitch-mcp (Leading Client)

**Author:** David East -- Google employee working on Stitch & Jules at google-labs-code (carries "not affiliated with Google" disclaimer for legal reasons).

**Key Features:**
- MCP proxy for coding agents with automatic token refresh
- Local Vite dev server for design preview
- Astro site generation from Stitch projects (maps screens to routes)
- Interactive terminal resource browser
- One-command `init` wizard (handles gcloud, OAuth, MCP config)
- Virtual MCP tools: `build_site`, `get_screen_code`, `get_screen_image`

**Recent Development (last week):**
- Zod input validation across all CLI commands
- Security hardening (CSP headers, project ID validation)
- Complete architectural refactor (command autoloading, modular services)
- Comprehensive test coverage
- `PREVENT_CONFLICTS.md` guide for agentic workflows

**Setup:**
```bash
npx @_davideast/stitch-mcp init     # Guided setup
npx @_davideast/stitch-mcp proxy    # MCP proxy mode
```

### 2. Kargatharaakash/stitch-mcp (Community Alternative)

**Author:** Aakash Kargathara -- independent developer who built it for personal workflow.

**Key Differentiators:**
- Claims the bare `stitch-mcp` npm package name
- 9 MCP tools (vs davideast's 3 virtual tools)
- `extract_design_context` tool for "Design DNA" extraction (fonts, colors, layouts)
- `generate_screen_from_text` for creating screens
- Simpler setup but requires gcloud auth
- Promoted across 6+ subreddits (r/ClaudeCode, r/cursor, r/UXDesign, etc.)

**Setup:**
```bash
npx -y stitch-mcp  # In MCP config
```

### 3. gemini-cli-extensions/stitch (Official Gemini CLI)

- Natural language Stitch interaction via `/stitch` commands
- Supports API key auth (simpler than OAuth)
- Screen generation with Gemini 3 Pro/Flash
- Requires Gemini CLI v0.19.0+

### 4. Native MCP (Stitch Export Menu, Feb 2026)

- Built directly into Stitch's web interface
- API key generation in Settings
- Step-by-step client instructions in Exports panel
- Officially in Antigravity's MCP catalog ("just search 'Stitch'")
- New tools: edit screens, generate screen variants

## Authentication Options

| Method | Complexity | Token Refresh | Best For |
|--------|-----------|---------------|----------|
| API Key (`STITCH_API_KEY`) | Low | N/A | Quick start (but unreliable) |
| gcloud ADC (`gcloud auth application-default login`) | Medium | Automatic | Most reliable |
| Service Account JSON | Medium | Automatic | Automated pipelines |
| Official Remote MCP (OAuth) | High | Manual (hourly) | Enterprise audit trail |
| `init` wizard (davideast) | Low | Automatic | Recommended |

**Known authentication issues:** API keys fail with "error bad request," "API keys are not supported by this API," and "server name stitch not found" errors. Community workaround: use gcloud ADC with local proxy instead.

## Critical Bugs

### State Synchronization (High-Priority, Acknowledged by Google)

Screens generated via `generate_screen_from_text` are invisible to `list_screens` and `get_screen` until the project is manually opened in a browser. Google confirmed "state synchronization latency between the Stitch generative backend and the MCP API layer." This blocks any automated pipeline that generates then immediately reads screens.

**Impact:** "Any automated pipeline following generate -> list -> get -> download requires manual browser intervention per screen."

## Team

| Person | Role | Context |
|--------|------|---------|
| **David East** | Creator of davideast/stitch-mcp & top contributor to stitch-skills | Google employee at google-labs-code (Stitch & Jules) |
| **Dion Almaer** | PR reviewer on stitch-skills | Google, "democratizing software creation with AI" |
| **Sam El-Husseini** | Stitch team | Credited in prior Stitch work |
| **Aakash Kargathara** | Creator of Kargatharaakash/stitch-mcp | Independent developer |
| **GreenSheep01201** | Creator of stitch-mcp-auto | Automated installer wrapper |

## User Sentiment

### Positive
- **Design-to-code workflow revolution:** "Now that Stitch has plugged into MCP, design is no longer a static export. It's live, queryable, programmable infrastructure." (r/AISEOInsider)
- **Discovery delight:** "Woah! How am I just hearing about this??? I just gave it a shot now, and let me just say I CANNOT BELIEVE MY EYES!" (r/ClaudeAI)
- **Free and fast:** "absolute amazing!!! I had used, smarter than gemini3 than chatgpt, just a simple prompt, it can give me 3 Prototypes" (r/UXDesign)
- **Enterprise potential:** RediMinds framed Stitch MCP as "governed context" for regulated industries, reducing "interface drift" in agent-built UIs
- **Better than Figma AI:** "way better than Figma AI, and super easy to use" (LinkedIn comment by Jasper Ruijs)

### Negative
- **Setup nightmare:** "I'm still encountering the 'server name stitch not found' error when attempting to access the stitch server" (r/mcp)
- **Launch was terrible:** "This app fuckin sucks man. Like seriously, you give it a design system and it shits the bed" (r/singularity, May 2025 -- now significantly improved)
- **Web design lags mobile:** "Creates stunning mobile app designs but still lacks on web design" (r/UXDesign)
- **Generic output:** "all these UI examples and generators create the most generic AI design possible" (r/ClaudeCode)
- **Not production-grade design:** "a fun toy -- but not a tool for enterprise-grade product design" (Pedro Bacelar, LinkedIn)
- **Commoditization risk:** "Everyone's racing to adopt Figma's MCP server [and Google Stitch]... fighting over table scraps" (Dave Benton, Metajive founder)

### Sentiment Arc
- **May 2025 (Google I/O launch):** Very negative. Service quality issues, empty images, broken design systems
- **Sep-Dec 2025:** Improving. Gemini 3 Pro, Prototypes, responsive support
- **Jan 2026 (MCP Server launch):** Strongly positive. "Developer Week" shipped MCP Server, Agent Skills, Gemini CLI extension, API keys in rapid succession
- **Feb 2026 (current):** Mixed-to-positive. Enthusiasm for MCP integration tempered by authentication friction and state sync bug

## Comparison to Related Tools

| Feature | Stitch MCP | Figma MCP | v0 (Vercel) |
|---------|-----------|-----------|-------------|
| **Design source** | AI-generated from prompts | Existing human designs | AI-generated (React) |
| **MCP approach** | Generate + read designs | Read existing designs | No MCP (web app) |
| **Output** | HTML/CSS/Tailwind | Design specs + code | React/Next.js components |
| **Cost** | Free | Figma subscription | Credit-based |
| **Mobile quality** | Excellent | N/A (design tool) | N/A (web-focused) |
| **Web quality** | Weak-to-moderate | N/A | Strong |
| **Ecosystem** | Google (Stitch, Jules, Antigravity) | Figma plugins | Vercel platform |
| **Best for** | Rapid prototyping + agent workflows | Production design refinement | React UI components |

**Consensus positioning:** Stitch MCP and Figma MCP are complementary, not competitive. Stitch generates designs from scratch via AI; Figma MCP reads from professionally-crafted designs. Optimal workflow: Stitch (ideate) -> Figma (refine) -> Claude Code (implement).

## Strengths

| Strength | Details |
|----------|---------|
| Free ecosystem | Stitch, MCP server, all tools -- completely free |
| Rapid evolution | 20 commits/week on davideast's client; native MCP, Hatter agent, API keys all shipped in weeks |
| Semi-official backing | David East is a Google Stitch team member; stitch-skills is under google-labs-code org |
| Multi-client support | Works with Claude Code, Cursor, Antigravity, Gemini CLI, Codex, OpenCode |
| Agent Skills standard | First major Google adoption of Vercel's open skills standard |
| Mobile design quality | Consistently praised for stunning mobile app UI generation |
| Design context injection | `extract_design_context` enables visual consistency across agent-generated screens |

## Limitations

| Limitation | Details |
|------------|---------|
| Authentication complexity | API keys unreliable; GCP OAuth workaround is non-trivial for non-GCP users |
| State sync bug (critical) | Generated screens invisible until manually opened in browser |
| Web design quality | Mobile praised; web layouts feel generic compared to competitors |
| Google Labs risk | Experimental product; could be discontinued |
| Naming confusion | 4+ implementations, similar names, unrelated "StitchAI" and "Stytch" products |
| No official open-source server | Google's MCP service is cloud-only; all repos are clients/proxies |
| Coverage skews promotional | Most content from SEO-focused creators (Julian Goldie); limited critical technical analysis |
| No Google LinkedIn presence | No Google employees promoting Stitch MCP on LinkedIn despite being Google's product |

## Bottom Line

Stitch MCP is the most accessible design-to-code MCP integration available -- free, AI-native, and backed by Google's infrastructure -- but adoption is gated by authentication friction and a critical state synchronization bug. The ecosystem is genuinely multi-layered: David East's client (a Google employee's side project with semi-official backing) is the most full-featured option for Claude Code and Cursor users, while the native Stitch MCP (in the export menu) is simplifying setup for Antigravity users. The Agent Skills library adds modular design automation on top.

The dramatic improvement from the disastrous May 2025 launch to today's MCP-enabled workflows is real, but professional designers still find the output quality insufficient for enterprise work, and the "Google Labs" label creates justified anxiety about longevity. For rapid prototyping and agent-assisted development, Stitch MCP is the strongest free option; for production design quality, continue to use Figma.

**Recommended for:** Developers using Claude Code, Cursor, or Antigravity who want AI-generated UI designs integrated directly into their coding workflow. Best for mobile app prototyping and multi-agent pipelines.

**Skip if:** You need production-grade design quality, work in environments where GCP authentication is impossible, or require fully automated pipelines (state sync bug blocks these).

**Setup recommendation:** Use `npx @_davideast/stitch-mcp init` for the smoothest setup with automatic token refresh. For Claude Code specifically:
```json
{
  "mcpServers": {
    "stitch": {
      "command": "npx",
      "args": ["@_davideast/stitch-mcp", "proxy"]
    }
  }
}
```

## Sources

### GitHub
- [davideast/stitch-mcp](https://github.com/davideast/stitch-mcp) -- Leading CLI/proxy client (305 stars)
- [google-labs-code/stitch-skills](https://github.com/google-labs-code/stitch-skills) -- Agent Skills library (1,915 stars)
- [gemini-cli-extensions/stitch](https://github.com/gemini-cli-extensions/stitch) -- Gemini CLI extension (270 stars)
- [Kargatharaakash/stitch-mcp](https://github.com/Kargatharaakash/stitch-mcp) -- Community alternative (60 stars)
- [GreenSheep01201/stitch-mcp-auto](https://github.com/GreenSheep01201/stitch-mcp-auto) -- Automated installer

### Official
- [Stitch by Google](https://stitch.withgoogle.com/)
- [Stitch MCP Setup Docs](https://stitch.withgoogle.com/docs/mcp/setup)
- [Stitch Pricing](https://stitch.withgoogle.com/pricing)

### News & Analysis
- [Geeky Gadgets: Stitch MCP, Agent Skills, CLI Support](https://www.geeky-gadgets.com/google-stitch-mcp-gemini-agent-skills/)
- [TestingCatalog: Hatter Agent and App Store Tools](https://www.testingcatalog.com/google-tests-hatter-agent-and-app-store-tools-in-stitch-update/)
- [Fresh Brewed Science: Google Stitch MCP test](https://freshbrewed.science/2026/02/19/stitch.html)
- [SOTAAZ: Stitch MCP with Claude Code](https://blog.sotaaz.com/post/stitch-mcp-integration-en)

### Reddit
- [r/mcp: Google Stitch MCP Server](https://www.reddit.com/r/mcp/comments/1q5vgnb/google_stitch_mcp_server/)
- [r/AISEOInsider: Stitch MCP Gave AI Agents "Eyes"](https://www.reddit.com/r/AISEOInsider/comments/1qlrh3l/the_stitch_mcp_update_that_gave_ai_agents_eyes/)
- [r/ClaudeAI: Struggling with Polished UI](https://www.reddit.com/r/ClaudeAI/comments/1m43nk2/struggling_to_generate_polished_ui_with_claude/)
- [r/Bard: Google connected Stitch and Jules](https://www.reddit.com/r/Bard/comments/1ok0avr/google_just_connected_its_ai_agents_stitch_and/)

### Twitter/X (via Brave snippets)
- [@stitchbygoogle: MCP Server announcement (Developer Week Day 2)](https://x.com/stitchbygoogle/status/2013752422058074518)
- [@stitchbygoogle: API Keys launch](https://x.com/stitchbygoogle/status/2016567646180041166)
- [@stitchbygoogle: MCP ecosystem level-up](https://x.com/stitchbygoogle/status/2024605622302625923)
- [@stitchbygoogle: Agent Skills (Developer Week Day 4)](https://x.com/stitchbygoogle/status/2014478393170133139)

### LinkedIn
- [RediMinds: Stitch MCP Server enterprise framing](https://www.linkedin.com/posts/rediminds_stitch-mcp-server-give-your-coding-agent-activity-7419765946434867200-hGKC)
- [Pedro Bacelar: Critical assessment](https://www.linkedin.com/pulse/google-stitch-ai-you-had-so-much-potential-pedro-bacelar-7j66f)
- [Dave Benton: Commoditization warning](https://www.linkedin.com/posts/metajive_everyones-racing-to-adopt-figmas-mcp-server-activity-7378443972723142656-uzhK)

### Google AI Developers Forum
- [Stitch MCP not working with API key](https://discuss.ai.google.dev/t/stitch-mcp-not-working-with-api-key/120933)
- [list_screens returns empty after generate](https://discuss.ai.google.dev/t/list-screens-returns-empty-after-generate-screen-from-text-until-project-is-opened-in-browser/123348)

### dev.to
- [Kargatharaakash: The "Designer Flow" for AI](https://dev.to/kargatharaaakash/the-designer-flow-for-ai-why-i-built-a-bridge-to-google-stitch-423k)

### Related Reports
- [Stitch by Google (2026-02-05)](catalogue/2026-02-05-stitch-by-google.md) -- Stitch product overview
- [Stitch Skills (2026-02-19)](catalogue/2026-02-19-stitch-skills.md) -- Agent Skills library deep-dive
- [AI Wireframe Tools (2026-02-06)](catalogue/2026-02-06-ai-wireframe-tools.md) -- Stitch in context of AI design tools
- [Antigravity + Opus 4.6 (2026-02-19)](catalogue/2026-02-19-antigravity-opus-46-workflow.md) -- Antigravity integration context

---
*Generated by Research Agent on 2026-02-23*
