---
topic: Data Israel
slug: data-israel
date: 2026-03-10
sources: [github, reddit, twitter, linkedin, web]
---

# Data Israel Research Report

## Overview

Data Israel is a full-stack web application that lets anyone ask questions about Israeli public data in Hebrew and receive answers grounded in official government sources — with charts, tables, and source attribution. Built by solo developer Lior Vainer, the project launched in January 2026 and is live at [data-israel.org](https://data-israel.org). It connects in real-time to two primary APIs: [data.gov.il](https://data.gov.il) (Israel's national open data portal, CKAN-based) and the Central Bureau of Statistics (CBS), covering 1,100+ government datasets and 95,000+ statistical series spanning 75+ years.

The core architecture is a multi-agent network built on [Mastra](https://mastra.ai/) (a TypeScript AI agent framework from the team behind Gatsby, YC-backed). A routing agent orchestrates two specialized sub-agents — one for data.gov.il (16 tools) and one for CBS (9 tools) — plus 4 direct client tools for chart rendering and follow-up suggestions. Each sub-agent runs autonomously with its own tools and memory thread stored in Convex. The system uses Google Gemini 3 Flash via OpenRouter as its LLM, with a guard model (Gemini 2.5 Flash Lite) for prompt injection protection and content filtering.

The project is very early-stage with zero social media presence, no external contributors, and no press coverage. However, development velocity is remarkably high — 31 PRs merged in under 2 months, with multiple commits daily. Recent work focuses on production hardening: prompt injection guards, anti-data-fabrication processors, IP-based rate limiting and geo-blocking, and analytics dashboards. The tech stack is cutting-edge (Next.js 16, React 19, AI SDK v6, Zod v4), suggesting a developer who stays at the bleeding edge.

## Technical Analysis

### Architecture

```
User Question (Hebrew)
        |
   Routing Agent (orchestrator)
   4 direct tools + 2 sub-agents
   Convex memory + vector search
        |
   +-----------+-----------+
   |           |           |
datagovAgent  cbsAgent   Client Tools
 (sub-agent)  (sub-agent)  (direct)
 16 tools     9 tools     charts + suggestions
   |           |
 CKAN API   CBS API
   |           |
 Own memory  Own memory
 thread      thread
```

### Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Next.js 16 (App Router + RSC) |
| UI | React 19, Tailwind CSS 4, Radix UI, Framer Motion |
| Agent Framework | Mastra 1.1 with AI SDK v6 |
| Model | OpenRouter → Google Gemini 3 Flash |
| Guard Model | Gemini 2.5 Flash Lite |
| Validation | Zod v4 (all tool I/O) |
| Memory & RAG | Convex (threads, vector search, dataset sync) |
| Charts | Nivo (bar, line, pie) |
| Auth | Clerk (Google sign-in) |
| Monitoring | Sentry |
| Rate Limiting | Upstash Redis |
| Language | TypeScript 5 (strict mode) |

### 29 Tools

**data.gov.il (16):** searchDatasets, listAllDatasets, getDatasetDetails, getDatasetActivity, getDatasetSchema, listOrganizations, getOrganizationDetails, getOrganizationActivity, listGroups, listTags, searchResources, getResourceDetails, queryDatastoreResource, getStatus, listLicenses, generateDataGovSourceUrl

**CBS (9):** browseCbsCatalog, browseCbsCatalogPath, getCbsSeriesData, getCbsSeriesDataByPath, browseCbsPriceIndices, getCbsPriceData, calculateCbsPriceIndex, searchCbsLocalities, generateCbsSourceUrl

**Client (4):** displayBarChart, displayLineChart, displayPieChart, suggestFollowUps

### Notable Technical Decisions
- **Mastra** chosen over LangChain/CrewAI — TypeScript-native, from credible team (Gatsby), strong Convex integration
- **Convex** for memory — real-time sync, vector search, no separate DB needed
- **OpenRouter** → Gemini 3 Flash — cost-effective, strong multilingual (Hebrew) support
- **Sub-agent memory isolation** — each agent stores tool call results in separate Convex threads, linked via `subAgentThreadId`
- **Two-pass recall** — on page reload, reconstructs full chain-of-thought UI from memory
- **Agent evaluation** — vitest-based eval configs for routing, datagov, and CBS agents
- **Prompt optimization scripts** — per-agent prompt optimization tooling

### Development Practices
- `.claude/` and `CLAUDE.md` (22KB) indicate heavy use of Claude Code for development
- `.agents/` and `AGENTS.md` suggest multi-agent AI-assisted development workflow
- `.mcp.json` for MCP tool integration
- Husky + lint-staged for pre-commit hooks
- ESLint with 8+ plugins (sonarjs, unicorn, react-hooks, etc.)
- Vitest for unit tests + eval tests

## User Sentiment

**Overall:** Too early to assess — no community discussion exists

- **Reddit:** No mentions found. Israeli open data community is more active on GitHub (hasadna org) than Reddit.
- **Twitter/X:** No mentions found. Zero social media buzz.
- **LinkedIn:** Developer (Lior Vainer) found at "Core" company. No project-related posts or company page.

## Competitive Landscape

Data Israel occupies a unique position as the **only consumer-facing web application** for Israeli public data Q&A. The competitive landscape consists of:

### MCP Servers (developer tools)
| Project | Approach | Language | Status |
|---------|----------|----------|--------|
| [aviveldan/datagov-mcp](https://github.com/aviveldan/datagov-mcp) | MCP server for data.gov.il CKAN API | Python | Active (Feb 2026), MIT |
| [DavidOsherdiagnostica/data-gov-il-mcp](https://github.com/DavidOsherdiagnostica/data-gov-il-mcp) | MCP server for Israeli gov data | — | Active (Aug 2025) |
| [barvhaim/remy-mcp](https://github.com/barvhaim/remy-mcp) | MCP server for Israeli Land Authority tenders | — | Active |
| [shlomiuziel/asher-mcp](https://github.com/shlomiuziel/asher-mcp) | MCP server for Israeli bank data | — | Active |

These are all **developer tools** — they provide API access but no end-user UI, no conversation memory, no Hebrew natural language interface.

### Community / Non-Profit
| Organization | Role |
|-------------|------|
| [DatA-IL](https://data-il.org) | Community aiming to unlock Israeli public data potential with AI. Advocacy + ecosystem building, not a product. |
| [hasadna](https://github.com/hasadna) | "The Public Knowledge Workshop" — multiple Israeli open data GitHub projects (open-bus, knesset-data, etc.) |
| [OpenIsraeliSupermarkets](https://github.com/OpenIsraeliSupermarkets) | Supermarket price scrapers for transparency |

### Key Differentiators
Data Israel is unique in combining all of:
1. Multi-agent AI orchestration (not just a wrapper around one API)
2. Live connections to both data.gov.il AND CBS (competitors target only one)
3. Hebrew-native natural language interface
4. Data visualization (bar, line, pie charts)
5. Conversation memory with context tracking
6. Consumer-facing web app (not a developer tool)
7. Transparent reasoning — users see which tools each agent calls

## Pros and Cons

| Pros | Cons |
|------|------|
| Unique product — no direct competitor as a consumer web app | Solo developer — bus factor of 1 |
| Very high development velocity (31 PRs in < 2 months) | Private license — "All rights reserved" limits community adoption |
| Cutting-edge stack (Next.js 16, React 19, Mastra, AI SDK v6) | Zero social media presence or community |
| Live and functional at data-israel.org | No visible monetization or business model |
| Connects to both data.gov.il AND CBS (comprehensive coverage) | Gemini 3 Flash may have Hebrew quality limitations vs larger models |
| Production hardening in progress (rate limiting, prompt guards) | No tests visible beyond eval configs |
| Transparent agent reasoning with chain-of-thought UI | Dependency on multiple external services (OpenRouter, Convex, Clerk, Upstash) |
| Free to use | Early-stage — unclear long-term sustainability |

## Sources

### GitHub
- https://github.com/LiorVainer/data-israel

### Web
- https://data-israel.org
- https://mastra.ai
- https://data.gov.il
- https://data-il.org

### Competitors
- https://github.com/aviveldan/datagov-mcp
- https://github.com/DavidOsherdiagnostica/data-gov-il-mcp

### Developer
- https://www.linkedin.com/in/lior-vainer-257105a8/

---
*Generated by Research Agent on 2026-03-10*
