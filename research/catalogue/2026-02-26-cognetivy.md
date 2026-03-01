---
topic: cognetivy
slug: cognetivy
date: 2026-02-26
sources: [github, reddit, twitter, linkedin, web]
---

# Cognetivy Research Report

## Overview

Cognetivy is a brand-new open-source **state layer for AI coding assistants** created by developer "meitarbe" on GitHub. Released on February 25, 2026 (3 days before this report), it provides local workflow definitions, run tracking, event logging, and structured data collections — all stored in a `.cognetivy/` directory within your project. The key positioning is "no LLMs inside" — Cognetivy is purely a data and state infrastructure layer that AI agents (Claude Code, Cursor, OpenClaw) interact with via Skills and MCP protocols.

The project ships as two components: a CLI/npm package (`cognetivy`) with a built-in MCP server and HTTP API, and a React-based Studio UI for read-only visualization of workflow DAGs, runs, events, and collections. It integrates with AI coding agents through the emerging Skills and MCP ecosystems — you can install it via `npx cognetivy` and connect it to your preferred editor's agent. The architecture is deliberately lightweight: no cloud services, no databases, just local JSON files versioned in your project.

Despite being only days old, the project is unusually well-scaffolded with CONTRIBUTING.md, ARCHITECTURE.md, RELEASING.md, SECURITY.md, issue templates, PR templates, CODEOWNERS, Dependabot, and CI workflows. There is zero community adoption or external discussion yet — no Reddit, Twitter, LinkedIn, or news mentions exist. The npm package has 495 weekly downloads, likely from early testing.

## Technical Analysis

**Stack:** TypeScript (Node.js >=18), Commander CLI framework, Ajv for validation, fast-json-patch for versioned mutations, React + Vite for Studio UI, shadcn/ui components.

**Architecture:**
- `cli/` — Published npm package with ~14 TypeScript source files. Key modules: `workspace.ts` (state read/write), `mcp.ts` (MCP server + tool handlers), `skills.ts` (agent integration), `cli.ts` (CLI commands), `studio-server.ts` (HTTP API + static serving)
- `studio/` — Private React SPA built with Vite, bundled into CLI for serving
- All state lives in `.cognetivy/` — workflow index, workflow records/versions, runs, events, collections, node results

**Key concepts:**
- **Workflows** — DAG-based node graphs defining reasoning steps
- **Runs** — Execution instances of workflows with input data
- **Events** — Timestamped log entries during runs
- **Collections** — Schema-validated structured data storage
- **Nodes** — Individual workflow steps with results

**Integration points:**
- MCP server via `cognetivy mcp` command
- Skills installation for Claude Code, Cursor, OpenClaw
- Studio UI opens in browser for visualization

**Code quality signals:** TypeScript throughout, proper build pipeline, test suite (`npm test`), structured release process, semantic versioning

## User Sentiment

**Overall:** No data (too new)

- **Reddit:** No mentions found. Zero presence in r/ClaudeAI, r/cursor, r/AI_Agents, or any subreddit.
- **Twitter/X:** No mentions found. No launch announcement or influencer engagement.
- **LinkedIn:** No mentions found. Developer identity not publicly linked.

## Competitive Landscape

Cognetivy sits in a unique niche — it's not an orchestrator, not a full workflow engine, and not an LLM wrapper. Closest comparisons:

| Tool | Difference |
|------|------------|
| **Conductor (Melty Labs)** | GUI orchestrator for parallel agents; Cognetivy is a state layer, not an orchestrator |
| **CodeMachine-CLI** | Coordinates multiple AI coding agents; Cognetivy stores state, doesn't coordinate |
| **Mastra** | Full TypeScript AI framework with LLM integration; Cognetivy explicitly has no LLMs |
| **n8n / Temporal** | Heavyweight workflow engines with cloud infra; Cognetivy is local-only, developer-focused |
| **Custom MCP servers** | Cognetivy bundles MCP + Skills + Studio UI into one package |

The "state layer without LLMs" positioning is distinctive. Rather than competing with orchestrators, Cognetivy aims to be the persistence and observability substrate that any AI agent can write to and read from.

## Pros and Cons

| Pros | Cons |
|------|------|
| Clean, focused concept — state layer without LLM coupling | 3 days old, zero community adoption |
| Local-first, no cloud dependencies | Single contributor, no external validation |
| Multi-agent support (Claude Code, Cursor, OpenClaw) | All 6 npm versions published same day — unclear stability |
| Built-in Studio UI for visualization | No production usage evidence |
| Well-scaffolded OSS project (docs, CI, templates) | Commit history mostly "wip" — rapid initial push |
| MCP + Skills dual integration path | npm description ("reasoning orchestration state") is abstract |
| MIT license | 495 downloads could be mostly self-testing |
| TypeScript with proper build/test pipeline | No stars, no forks, no community issues |

## Sources

- https://github.com/meitarbe/cognetivy
- https://github.com/meitarbe/cognetivy/blob/main/README.md
- https://github.com/meitarbe/cognetivy/blob/main/docs/ARCHITECTURE.md
- https://github.com/meitarbe/cognetivy/blob/main/CONTRIBUTING.md
- https://github.com/meitarbe/cognetivy/blob/main/CHANGELOG.md
- https://github.com/meitarbe/cognetivy/blob/main/cli/package.json
- https://www.npmjs.com/package/cognetivy

---
*Generated by Research Agent on 2026-02-26*
