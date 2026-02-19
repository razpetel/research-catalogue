---
topic: NotebookLM MCP CLI
slug: notebooklm-mcp-cli
date: 2026-02-19
sources: [github, reddit, twitter, linkedin, web]
---

# NotebookLM MCP CLI Research Report

## Overview

NotebookLM MCP CLI (jacob-bd/notebooklm-mcp-cli) is a unified Python package that provides both a command-line interface (`nlm`) and an MCP server (`notebooklm-mcp`) for programmatic access to Google's NotebookLM. Created by Jacob Ben-David and released on December 23, 2025, the project has rapidly grown to 1,415 GitHub stars and 307 forks, with ~19,400 PyPI downloads in the last month alone. It is the dominant open-source tool for NotebookLM automation, having spawned 75+ related repositories and multiple forks on GitHub.

The tool reverse-engineers NotebookLM's internal HTTP/RPC APIs to expose 29 MCP tools covering the full product surface: notebook CRUD, source management (URLs, text, Google Drive, file uploads), AI chat queries, studio content generation (audio podcasts, video explainers, slide decks, mind maps, quizzes, flashcards, infographics, reports, data tables), web/Drive research with source import, sharing/collaboration, and Google Workspace export. A single `pip install notebooklm-mcp-cli` gives users both the CLI and MCP server, with auto-configuration for 7+ AI tools via `nlm setup add <tool>`.

Notably, the author is transparent that this was "vibe coded" by a non-developer using AI coding assistants. Despite this origin, the project has matured significantly: v0.3.0 introduced a shared service layer with 10 domain modules, strict architectural layering, and 372 unit tests. The rapid release cadence (33 versions in ~8 weeks) and responsive community engagement (27 of 30 issues closed, 6 credited contributors) demonstrate genuine momentum. However, the reliance on undocumented internal APIs and cookie-based authentication means users should expect periodic breakage and re-authentication requirements.

## Technical Analysis

**Architecture:** The codebase follows a clean three-layer pattern introduced in v0.3.0: `cli/` and `mcp/` are thin wrappers that delegate all business logic to a shared `services/` layer (10 domain modules: errors, chat, downloads, exports, notebooks, notes, research, sharing, sources, studio). Neither CLI nor MCP imports from `core/` directly. The MCP server uses FastMCP and supports both stdio and HTTP transport modes.

**Authentication:** Uses Chrome DevTools Protocol to extract Google session cookies. Supports multi-profile authentication with isolated Chrome sessions per Google account. Three-layer auto-recovery: CSRF refresh, disk reload, headless Chrome re-auth. Cookies expire every 2-4 weeks. A `.mcpb` Claude Desktop Extension provides one-click installation.

**Key capabilities:**
- 29 MCP tools (consolidated from 45+ in earlier versions)
- All 9 NotebookLM Studio artifact types
- Web and Google Drive research with source import
- Sharing and collaboration management
- Skill installer for Claude Code, Gemini CLI, Cursor, Codex, OpenCode, Cline, Antigravity, OpenClaw
- `nlm doctor` for diagnostic troubleshooting
- `nlm setup` for zero-config AI tool integration
- Automatic retry on transient server errors (429, 5xx) with exponential backoff
- JSON output flag for scripting/piping

**Stack:** Python 3.11+, httpx, pydantic, typer, rich, websocket-client, fastmcp. Built with hatchling, uses uv for package management. Linted with ruff, typed with mypy.

**Testing:** 372 unit tests across all service modules, plus E2E lifecycle tests marked separately. pytest with asyncio support.

## User Sentiment

**Overall:** Positive

- **Reddit:** Strong positive reception across 5+ subreddits (r/MachineLearning, r/notebooklm, r/ClaudeAI, r/ClaudeCode, r/vibecoding, r/ArtificialInteligence). Users praise the utility ("I got tired of copy-pasting NotebookLM answers into Claude") and the responsive maintainer. Some prefer CLI over MCP for speed. Main friction points: auth cookie expiration and initial setup complexity for non-developers.

- **Twitter:** Negligible presence. No notable X/Twitter mentions found. Community activity is concentrated on Reddit, GitHub, and LinkedIn.

- **LinkedIn:** Active self-promotion by the author (4+ posts) with engagement from SEO and AI practitioners. Julian Goldie SEO posted "NotebookLM MCP + Claude Code: Build ANYTHING!" Several integration-focused posts from the community.

## Competitive Landscape

NotebookLM MCP CLI is the clear market leader in the NotebookLM automation space:

| Competitor | Stars | Approach | Difference |
|-----------|-------|----------|------------|
| **jacob-bd/notebooklm-mcp-cli** | 1,415 | Python, unified CLI+MCP | Full API surface, 29 tools, multi-profile auth, skill installer |
| PleasePrompto/notebooklm-mcp | ~100 | TypeScript, browser automation | Stateless queries, persistent auth, library management, Claude Code Skill option |
| Pantheon-Security/notebooklm-mcp-secure | ~50 | Fork with security | 14 security hardening layers |
| joeseesun/anything-to-notebooklm | ~30 | Claude Skill | Multi-source processor (WeChat, YouTube, PDF) |
| AutoContent API | N/A | Commercial | Paid API with NotebookLM MCP setup guides |

The broader NotebookLM ecosystem is vibrant: 75+ GitHub repos reference NotebookLM MCP, numerous forks and derivative projects exist, and blog/newsletter coverage is extensive (Medium, Substack, UX Planet, Analytics Vidhya, Geeky Gadgets). The Antigravity (Google AI IDE) integration narrative is particularly strong, with multiple dedicated tutorials.

## Pros and Cons

| Pros | Cons |
|------|------|
| Most complete NotebookLM API coverage (29 tools, all 9 studio types) | Uses undocumented internal APIs -- may break without notice |
| Unified CLI + MCP in one package | Cookie auth expires every 2-4 weeks, requires re-extraction |
| Auto-setup for 7+ AI tools (zero manual JSON editing) | 29 MCP tools consume significant context window (disable when not in use) |
| Active development (33 releases in 8 weeks) | Free tier rate limited (~50 queries/day) |
| 372 unit tests, proper service layer architecture | "Vibe coded" by non-developer -- code quality improving but started rough |
| Responsive maintainer, healthy community (17 contributors) | No official Google API -- entire ecosystem at risk if Google changes internals |
| .mcpb one-click Claude Desktop extension | Windows had JSON parse errors (fixed in v0.2.16) |
| MIT license, free | Single maintainer dependency despite community contributions |
| ~19K PyPI downloads/month showing real adoption | |

## Sources

### GitHub
- https://github.com/jacob-bd/notebooklm-mcp-cli
- https://pypi.org/project/notebooklm-mcp-cli/

### Reddit
- https://www.reddit.com/r/MachineLearning/comments/1qs7y7v/
- https://www.reddit.com/r/notebooklm/comments/1qs7v2s/
- https://www.reddit.com/r/ClaudeAI/comments/1o84y0r/
- https://www.reddit.com/r/vibecoding/comments/1o8b2fo/
- https://www.reddit.com/r/ArtificialInteligence/comments/1qiu7j6/

### LinkedIn
- https://www.linkedin.com/posts/jacobbd_notebooklm-mcp-activity-7413236450781163520-7mkw
- https://www.linkedin.com/posts/jacobbd_mcp-notebooklm-superassistant-activity-7416516073824473088-JnF1

### Web
- https://agentnativedev.medium.com/automate-google-notebooklm-from-your-ai-agent-with-notebooklm-mcp-3c513a37396a
- https://medium.com/the-context-layer/superpower-notebooklm-with-an-mcp-server-fe4d6038c3db
- https://aimaker.substack.com/p/notebooklm-mcp-claude-setup-guide-research-workflow
- https://uxplanet.org/how-to-use-notebooklm-to-guide-coding-via-mcp-06822778746e
- https://lobehub.com/mcp/jacob-bd-notebooklm-mcp-cli
- https://pypistats.org/packages/notebooklm-mcp-cli

### Video
- https://www.youtube.com/watch?v=d-PZDQlO4m4 (General MCP Overview)
- https://www.youtube.com/watch?v=PU8JhgLPxes (Claude Desktop demo)
- https://www.youtube.com/watch?v=XyXVuALWZkE (CLI Overview)
- https://www.youtube.com/watch?v=ZQBQigFK-E8 (CLI, MCP & Skills Deep Dive)
- https://www.youtube.com/watch?v=5tOUilBTJ3Q (Setup, Doctor & One-Click Install)

---
*Generated by Research Agent on 2026-02-19*
