# Excalidraw MCP

**Date:** 2026-02-19
**URL:** https://github.com/excalidraw/excalidraw-mcp
**Sentiment:** Positive

## TL;DR

Official MCP App server from the Excalidraw organization that streams hand-drawn diagrams directly into AI chat interfaces with interactive fullscreen editing. Built by Anton Pidkuiko (Anthropic) and transferred to the excalidraw org within one week. 2,544 stars in 15 days. The flagship showcase of the MCP Apps pattern -- cited by Chrome Web MCP W3C proposal, VS Code team, and InfoWorld as the reference implementation. Works best in Claude; Gemini CLI and ChatGPT support is nascent.

## What It Is

Excalidraw MCP is a Model Context Protocol server that goes beyond text-only tool responses by delivering interactive Excalidraw diagrams directly in the AI chat UI. It uses the MCP Apps extension (`@modelcontextprotocol/ext-apps`) to render interactive HTML (the Excalidraw editor) as an embedded widget, enabling users to view, edit, and export hand-drawn diagrams without leaving the conversation.

**Two tools:**
- `read_me` -- returns a cheat sheet with element format, color palettes, and layout tips (the model calls this first)
- `create_view` -- takes standard Excalidraw JSON and streams an animated SVG diagram with smooth draw-on effects

**Key capabilities:**
- Streaming SVG rendering with hand-drawn pencil stroke animations
- Smooth viewport camera panning and zoom during streaming
- Interactive fullscreen editing mode
- One-click export to excalidraw.com
- Checkpoint/restore for iterative diagram edits
- Screenshot feedback -- captures the rendered SVG as PNG and sends it back to the model so it can see and iterate on the diagram
- Pencil stroke audio effects (toggleable)

## Who Made It

- **Anton Pidkuiko** ([@antonpk1](https://github.com/antonpk1)) -- engineer at Anthropic, one of the main engineers behind MCP Apps. Built the original as a weekend project at `antonpk1/excalidraw-mcp-app`, which was transferred to the official `excalidraw/excalidraw-mcp` within days.
- **David Luzar** ([@dwelle](https://github.com/dwelle)) -- co-founder of Excalidraw, active contributor to the repo. Handles infrastructure work (pnpm migration, cross-OS builds, root path MCP).

The Excalidraw org (117K stars on the main repo) giving this official status lends significant credibility.

## Technical Architecture

### Rendering Pipeline
The server uses pure SVG rendering via Excalidraw's `exportToSvg` -- no `<Excalidraw>` React canvas component. This eliminates the blink that would occur swapping from SVG preview to canvas on final render.

**Streaming flow:**
1. Partial JSON is parsed incrementally, dropping the last (potentially incomplete) element
2. Re-renders only when element count changes (not every partial update)
3. morphdom diffs the new SVG against the existing DOM, preserving nodes and preventing re-animation
4. New elements get CSS animations: shapes fade in (0.5s), lines get stroke-dashoffset draw-on (0.6s)
5. Final render uses original seeds for stable hand-drawn style

**Progressive element ordering:** The cheat sheet instructs the model to emit elements as shape-then-label groups (not all shapes then all labels), so each node appears complete during streaming.

### Checkpoint System
Two-tier storage for diagram persistence:
- **Server-side:** `FileCheckpointStore` (local), `MemoryCheckpointStore` (Vercel fallback), `RedisCheckpointStore` (Upstash KV, 30-day TTL)
- **Widget-side:** localStorage cache for fast reload within sessions
- Checkpoints resolve references server-side so the model never re-sends full element arrays

### Stack
- TypeScript, Vite, React 19, pnpm
- @excalidraw/excalidraw ^0.18.0
- @modelcontextprotocol/sdk 1.25.2
- @modelcontextprotocol/ext-apps ^0.4.0
- morphdom for SVG DOM diffing
- Express 5 + Bun runtime
- Vercel deployment (remote) or stdio (local)

### Design Decisions
- **Standard Excalidraw JSON** -- no skeleton API (`convertToExcalidrawElements`). Any `.excalidraw` file's elements array works as input. Trade-off: labels require manually computed coordinates.
- **CSP: esm.sh allowed** -- Excalidraw loads the Virgil hand-drawn font from esm.sh at runtime
- **4:3 viewport nudging** -- camera aspect ratio check encourages models to use 4:3 ratios

## Installation

### Remote (recommended)
```
https://mcp.excalidraw.com
```
Add as a custom MCP connector in any supporting client (Claude, ChatGPT, VS Code, Goose).

### Claude Desktop
Download `excalidraw-mcp-app.mcpb` from Releases and double-click to install.

### Local build
```bash
git clone https://github.com/excalidraw/excalidraw-mcp.git
cd excalidraw-mcp
pnpm install && pnpm run build
node dist/index.js --stdio
```

## GitHub Activity

| Metric | Value |
|--------|-------|
| Stars | 2,544 |
| Forks | 168 |
| Open Issues | 19 |
| Commits | ~30 in 15 days |
| Contributors | 4+ (antonpk1, dwelle, sachinsmc, debu-sinha) |
| Created | 2026-02-04 |
| Last Push | 2026-02-18 |
| License | MIT |
| Version | 0.3.2 |

**Notable open issues:**
- #9: VS Code support (3 comments, active discussion)
- #31: Export as PNG
- #32-33: Bound arrow support for AI agents
- #21: Gemini CLI rendering
- #20: ChatGPT canvas sizing
- #22: `export_to_excalidraw` drops text elements
- #25: Mute/unmute toggle for pencil sounds

**Assessment:** Very active. Rapid iteration with strong institutional backing from both Excalidraw and Anthropic.

## Community Reception

### Reddit
- **r/mcp:** Original announcement generated discussion about open-source requirements for MCP servers (it was initially closed-source, then rapidly open-sourced)
- **r/ClaudeAI:** "Excalidraw mcp is kinda cool" -- positive reception, shared alongside SVG alternatives
- **r/Excalidraw:** Community tracking the integration with Claude

### Twitter/X
- **@excalidraw (official):** "Thanks to good people at @AnthropicAI we now have an official MCP for Excalidraw! From weekend project to official server in less than a week."
- **Liad Yosef:** "Amazing work by Anton Pidkuiko from Anthropic. Every product in the world can get instant chat and AI abilities, by building itself as an MCP App to be embedded in any chat."
- **Harald Kirschner (VS Code team):** "Brainstorming, planning and mockups with an agent will never be the same now that we can both use @excalidraw as whiteboard."
- **Ruben Casas (dev.to):** "These are the type of MCP Apps I'm really excited for! The canvas multi-turn agent to human collaboration is going to be a great use case."

### LinkedIn
- Anton Pidkuiko announcing remote deployment
- Multiple tutorial posts for installation and use cases
- Network diagram and architecture diagram practitioners sharing practical workflows

### Blogs & Media
- **InfoWorld:** Cited in "WebMCP API extends web apps to AI agents" (W3C proposal coverage)
- **Dev.to:** Referenced as "a great example" in Chrome Web MCP article
- **Stephen Turner Blog:** Practical review noting diagrams are "roughly right" but need human review -- "YMMV, check its work"
- **CodeNote.net:** Detailed walkthrough highlighting real-time AI-human collaboration workflow
- **Medium (Debu Sinha):** Security analysis led to PR #18 (path traversal hardening), which was merged
- **Threads:** "Insanely good for diagrams. 100% Opensource."
- **Smithery.ai:** Listed with 90/100 quality score

## Ecosystem & Alternatives

The Excalidraw MCP space is crowded with 37+ repos on GitHub, but excalidraw/excalidraw-mcp is clearly the canonical one:

| Project | Stars | Approach | Status |
|---------|-------|----------|--------|
| **excalidraw/excalidraw-mcp** | 2,544 | MCP App (interactive HTML in chat) | Official, active |
| yctimlin/mcp_excalidraw | ~100 | Full canvas + REST API + agent skill | Active, community |
| lesleslie/excalidraw-mcp | ~50 | Dual Python/TS, live canvas | Active, community |
| debu-sinha/excalidraw-mcp-server | ~10 | Security-hardened, 14 tools | Active, community |
| bassimeledath/excalidraw-render-mcp | ~20 | Headless rendering, no data sent to third parties | Active, community |

**Non-MCP alternatives for AI diagramming:**
- draw.io MCP (project instructions or MCP server approach)
- Mermaid diagrams (text-based, rendered by many tools)
- Custom Claude Code skills generating .excalidraw files directly

## Strengths

1. **Official status** -- backed by both Excalidraw (117K stars) and Anthropic. Not a community hack.
2. **MCP Apps pioneer** -- interactive HTML in chat, not just text responses. This is the pattern that Chrome Web MCP and others are building toward.
3. **Streaming with animations** -- the draw-on effect during generation is genuinely delightful and provides progress feedback.
4. **Screenshot feedback loop** -- the model can see its own output and iterate. This is a meaningful UX innovation for visual tools.
5. **Zero-config remote** -- `mcp.excalidraw.com` means no local setup required.
6. **Clean architecture** -- standard Excalidraw JSON, morphdom diffing, no React canvas overhead.
7. **Rapid development** -- 30 commits in 15 days with security hardening already merged.

## Weaknesses

1. **Diagrams need human review** -- "roughly right" per Stephen Turner. AI-generated layouts often have alignment issues and the model sometimes places labels incorrectly (manual coordinates, not auto-positioned).
2. **Cross-platform gaps** -- VS Code support is in-progress (#9), Gemini CLI has rendering issues (#21), ChatGPT sizes diagrams for chat canvas (#20).
3. **No bound arrows yet** -- arrow-to-shape binding requires manual positioning; issues #32-33 are open to make this easier for AI agents.
4. **Export drops text** -- issue #22 reports `export_to_excalidraw` loses text elements.
5. **esm.sh dependency** -- Virgil font loaded from esm.sh at runtime; if esm.sh is down, fallback is system font. CSP implications in locked-down environments.
6. **15 days old** -- impressive traction but still very early. API surface may change.

## Who Should Use This

**Ideal for:**
- Claude Desktop and claude.ai users wanting visual diagramming in conversations
- Developers needing architecture diagrams, flowcharts, sequence diagrams during planning
- Teams using AI-assisted design where the "draw rough draft, then refine" workflow fits
- Anyone wanting to try MCP Apps as a pattern

**Wait if:**
- You need production-stable cross-platform support (VS Code, Gemini, ChatGPT)
- You need pixel-perfect diagram output without manual refinement
- You need bound arrows and complex layout relationships that AI currently struggles with

## Verdict

Excalidraw MCP is the most impressive MCP App to date -- a genuine showcase of what interactive AI tool responses can look like. The streaming animations, fullscreen editing, and screenshot feedback loop represent a meaningful step beyond text-only tool outputs. With official backing from both Excalidraw (117K stars) and Anthropic, plus 2,544 stars in 15 days, it has clear momentum and institutional support.

The practical caveat is that AI-generated diagrams still need human refinement. The tool excels as a "first draft generator" for visual thinking, not a finished-product tool. But that is exactly the right framing -- and the interactive editing mode makes refinement seamless.

Highly recommended for Claude users. Watch the cross-platform issues for VS Code and other clients.
