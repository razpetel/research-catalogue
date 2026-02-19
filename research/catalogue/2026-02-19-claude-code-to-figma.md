---
topic: Claude Code to Figma (Code to Canvas)
slug: claude-code-to-figma
date: 2026-02-19
sources: [github, reddit, twitter, linkedin, web]
---

# Claude Code to Figma (Code to Canvas) Research Report

## Overview

On February 17, 2026, Figma and Anthropic launched "Code to Canvas," a first-party integration that converts live browser UIs built with Claude Code into fully editable Figma design frames. The feature reverses the traditional design-to-code pipeline: developers type "Send this to Figma" in Claude Code, and the rendered browser state -- whether from production, staging, or localhost -- is translated into layered, auto-layout Figma frames that designers can annotate, duplicate, compare side-by-side, and refine. Changes can then be pulled back into code via Figma's MCP server, completing a round-trip workflow.

The announcement landed alongside Figma's strong Q4 2025 earnings ($303.8M revenue, 40% YoY growth, $1.056B annual revenue) and the simultaneous release of Claude Sonnet 4.6. CEO Dylan Field framed the integration as strategic necessity: "As AI gets better, Figma gets better -- and we're shipping faster than ever." He described the partnership as "pretty much purely organic," with engineers initiating contact before marketing involvement. The integration builds on an earlier January 2026 partnership that brought Claude into Figma's FigJam whiteboarding tool.

Figma's stock had fallen approximately 85% from its IPO highs to ~$23, caught in a brutal SaaS sell-off driven by AI disruption fears. A Morgan Stanley analyst directly asked if Figma was "letting the fox into the henhouse" through the Anthropic partnership. Field's counter-strategy: become infrastructure that AI agents depend upon rather than competing with them. The company plans to replicate the MCP architecture across multiple coding tools, not maintaining exclusive partnerships.

## Technical Analysis

### How Code to Canvas Works

The integration operates through Figma's Model Context Protocol (MCP) server using a four-step workflow:

1. **Build/Iterate:** Developer creates or modifies UI using Claude Code, previewing in the built-in browser
2. **Capture:** Typing "Send this to Figma" triggers the `generate_figma_design` tool, which captures the live browser state
3. **Convert:** The rendered state is converted into editable Figma frames with preserved layers, text, and auto-layout
4. **Collaborate:** Team annotates, compares variants, and refines on the Figma canvas without needing code access

**Setup (under 2 minutes):**
```bash
claude mcp add --transport http figma https://mcp.figma.com/mcp
```
Then authenticate via `/mcp` command in Claude Code, select figma server, and complete OAuth.

### Key Technical Details

- **Transport:** Remote MCP (HTTP), not local MCP -- this is a Figma-hosted service
- **Core tool:** `generate_figma_design` -- Claude Code exclusive, Remote MCP only
- **Bidirectional:** Figma MCP server reads components, variables, styles, and layout structure semantically (not just screenshots), enabling code regeneration from design changes
- **Handles complex UI:** Charts, lists, tables, filters, multi-page flows
- **Desktop MCP endpoint:** `http://127.0.0.1:3845/sse` for local Figma desktop integration

### Limitations (Builder.io Analysis)

- **Claude Code exclusive:** `generate_figma_design` does not work with Cursor, Codex, or other AI tools
- **Context loss in roundtrips:** Business logic, event handlers, and state management are lost when converting to Figma layers -- returning to code requires re-translation
- **Enterprise gating:** `get_code` (Code Connect) requires Organization/Enterprise plans
- **Bug:** `get_code` fails with annotated elements
- **Desktop only:** Requires Figma desktop app, not browser version
- **No WSL support** for Desktop MCP
- **Individual captures:** Multi-screen flows must be captured one at a time
- **Token consumption:** Scales with file complexity
- **MCP maturity:** Slow connections add delays; protocol still maturing

### GitHub Ecosystem

No official Figma GitHub repo exists for Code to Canvas -- it is a proprietary Remote MCP service. However, a significant community ecosystem has formed:

- **arinspunk/claude-talk-to-figma-mcp** -- Community-built MCP for bidirectional Figma interaction, predates official integration, actively maintained
- **markacianfrani/claude-code-figma ("Figma Friend")** -- Claude Code plugin for controlling Figma through browser automation
- **breschio/drawbridge** -- Browser overlay sending "Figma Comments" directly to Claude Code as prompts
- **scoobynko/claude-code-design-skills** -- Claude Code skills for automated design-to-code workflows

### Comparison with Related Tools

| Aspect | Code to Canvas | Figma Make | Builder.io Visual Copilot | Google Stitch |
|--------|---------------|------------|--------------------------|---------------|
| Direction | Code to design | Text/design to code | Bidirectional (single tool) | Prompt to UI |
| Primary users | Developers, technical designers | Designers, non-technical | Full-stack teams | Anyone (free) |
| AI model | Claude (Anthropic) | Claude Sonnet 4.6 (internal) | Proprietary | Gemini 3 |
| Best for | Prototype review on canvas | Direct code generation | No-context-switch workflow | Free rapid ideation |
| Platform | Figma (desktop) | Figma | Builder.io | Web + Figma export |

## User Sentiment

**Overall:** Mixed-to-Positive

- **Reddit:** Mixed. 44-upvote thread on r/ClaudeAI praised "fully editable design frames." r/AIGuild called it "agents as drafting partners." However, r/FigmaDesign questioned differentiation from Figma Make: "How is this any different to generating in Figma Make using Opus 4.6?" Some users reported MCP reliability issues and "Image too large" errors. A recurring theme: designers who iterate directly in the browser wonder if they need Figma at all.

- **Twitter/X:** Positive. Dylan Field's tweet framing "code AND canvas" (not "code OR canvas") resonated widely. Figma's official tweet was widely shared. Thariq's demo tweet was cited across 15+ news outlets. International engagement (French tech community on Threads).

- **LinkedIn:** Professional coverage focused on strategic implications. The Morgan Stanley "fox in the henhouse" question captured Wall Street's ambivalence. Multiple step-by-step guides published within 24 hours by product managers and design leads.

- **News/Finance:** Massive coverage (CNBC, Fortune, Seeking Alpha, Digg, Dataconomy, TechBriefly). Framed as both AI strategy play and earnings catalyst. Stock rose 15% after-hours post-earnings. Fortune highlighted tension between $1B+ revenue growth and 85% stock decline.

## Competitive Landscape

Figma's Code to Canvas occupies a unique position as the only first-party integration from a major design platform that ingests AI-generated code as editable design artifacts. The competitive dynamics:

- **Figma Make** is the closest internal competitor -- it generates code from text/design prompts and is seeing 70%+ WAU growth with 60% of files created by non-designers. Some Reddit users see Code to Canvas as redundant given Make's capabilities.
- **Builder.io** positions itself as a "single-tool alternative" that eliminates the 3-tool context-switching problem inherent in Code to Canvas roundtrips.
- **Google Stitch** offers free UI generation with Figma export but lacks the bidirectional MCP integration.
- **v0 by Vercel** generates React code from prompts with Figma import but does not create editable Figma layers from running code.
- **Community MCP tools** (arinspunk/claude-talk-to-figma-mcp) offered bidirectional Figma interaction before the official integration but lack the polish and first-party support.

Field's strategy is explicitly non-exclusive: he plans to replicate the MCP architecture across multiple AI coding tools, positioning Figma as the "canvas layer" that all agents converge on.

## Pros and Cons

| Pros | Cons |
|------|------|
| First-party integration between $1B design platform and leading AI coding tool | Claude Code exclusive -- no Cursor, Codex, or other tool support yet |
| Real editable layers, not screenshots -- preserves text, auto-layout, structure | Business logic, event handlers, state management lost in code-to-design conversion |
| Sub-2-minute setup via Remote MCP | Requires Figma desktop app (not browser) |
| Enables non-engineers to review and annotate AI-generated UIs | `get_code` (Code Connect) requires enterprise-tier Figma plans |
| Round-trip workflow: code to Figma to code via MCP | Multi-screen flows require individual captures |
| Strategic alignment with Figma's $1B+ platform | Token consumption scales with complexity |
| "Start anywhere, go anywhere" philosophy breaks linear design-to-code assumption | MCP protocol still maturing (slow connections, bugs with annotations) |
| Builds on broader Figma AI push (Make, FigJam + Claude) | Some designers question need for Figma if iterating directly in browser |

## Sources

### Official
- https://www.figma.com/blog/introducing-claude-code-to-figma/
- https://www.figma.com/blog/the-future-of-design-is-code-and-canvas/
- https://x.com/zoink/status/2023760388530307167
- https://x.com/figma/status/2023759565029003769
- https://www.youtube.com/watch?v=riFFyTRljic

### News Coverage
- https://www.cnbc.com/2026/02/17/figma-anthropic-ai-code-designs.html
- https://fortune.com/2026/02/18/fig-stock-q4-earnings
- https://diginomica.com/figma-crosses-1-billion-revenue-its-whos-doing-designing-matters
- https://sources.news/p/figmas-answer-to-the-ai-software
- https://gigazine.net/gsc_news/en/20260218-figma-code-to-canvas/
- https://techbriefly.com/2026/02/18/figma-and-anthropic-partner-on-code-to-canvas-ai-feature/
- https://dataconomy.com/2026/02/18/figma-and-anthropic-launch-code-to-canvas-for-ai-design-editing/

### Analysis
- https://www.builder.io/blog/claude-code-to-figma
- https://muz.li/blog/claude-code-to-figma-how-the-new-code-to-canvas-integration-works/
- https://medium.com/product-powerhouse/claude-code-to-figma-what-the-new-launcher-means-for-designers-developers-and-pms-step-by-step-1df3d1322953

### Community
- https://www.reddit.com/r/ClaudeAI/comments/1r7vvmr/
- https://www.reddit.com/r/FigmaDesign/comments/1r7ca3v/
- https://www.reddit.com/r/AIGuild/comments/1r7rnts/
- https://github.com/arinspunk/claude-talk-to-figma-mcp
- https://github.com/markacianfrani/claude-code-figma
- https://composio.dev/toolkits/figma/framework/claude-code

---
*Generated by Research Agent on 2026-02-19*
