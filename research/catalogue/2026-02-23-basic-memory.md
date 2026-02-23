---
topic: Basic Memory (basicmachines-co)
slug: basic-memory
date: 2026-02-23
sources: [github, reddit, twitter, linkedin, web]
---

# Basic Memory Research Report

## Overview

Basic Memory is a local-first knowledge management MCP server by Basic Machines (basicmachines-co) that enables AI assistants like Claude, ChatGPT, and Gemini to build persistent knowledge through natural conversations, storing everything as structured Markdown files on the user's computer. Created in December 2024 by Paul Hernandez, it has grown to 2,552 GitHub stars and 168 forks with very active development (v0.18.5 as of Feb 20, 2026, with 15+ commits in the last 3 days). The project's core insight is that AI memory should be human-readable, human-editable, and version-controllable -- not locked in a black-box database.

Unlike hook-based memory solutions (claude-mem) that automatically capture tool usage, or cloud-first platforms (Mem0) that centralize memory management, Basic Memory takes a Zettelkasten-inspired approach where Markdown files serve as the canonical source of truth. Each file becomes an entity in a knowledge graph, with observations (categorized facts) and relations (typed WikiLinks) that AI assistants can traverse via the MCP protocol. A local SQLite database provides indexing and full-text search, while fastembed + sqlite-vec enable local vector search without any cloud dependency.

The project recently launched Basic Memory Cloud (beta since October 2025, $14.25/month) for cross-device and multi-LLM access, while maintaining its commitment to the free, open-source local version. Community sentiment is solidly positive, especially among Obsidian users and privacy-conscious developers. Reddit users consistently recommend it as the best local-first alternative to Mem0, praising its transparency and human-editability. The primary concerns are the AGPL-3.0 license (restrictive for commercial embedding), the requirement to keep the sync process running, and some open bugs including a reported SQL injection vulnerability (#591).

## Technical Analysis

### Architecture

Basic Memory's architecture centers on five layers:

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Storage** | Markdown files (`~/basic-memory/`) | Canonical data source, human-readable |
| **Parsing** | markdown-it-py + python-frontmatter | Extract entities, observations, relations |
| **Index** | SQLite + SQLAlchemy + Alembic | Full-text search, metadata queries |
| **Embeddings** | fastembed + sqlite-vec | Local vector search (no cloud) |
| **Interface** | MCP server (fastmcp 3.0.1) | AI assistant integration |

Optionally: Postgres backend (via asyncpg) for larger deployments, and rclone-based cloud sync to Tigris for the cloud offering.

### Knowledge Graph Model

Each Markdown file maps to an **Entity** with:

```markdown
---
title: Authentication System
permalink: authentication-system
tags: [security, auth, api]
type: note
---

## Observations
- [decision] Using JWT for stateless auth #security
- [requirement] Tokens must expire in 24 hours (compliance)
- [risk] No token rotation implemented yet

## Relations
- implements [[API Security Policy]]
- depends_on [[User Service]]
- relates_to [[OAuth Integration]]
```

The `[category]` prefix, `#tags`, and `(context)` provide structured metadata while remaining readable Markdown. Relations via `[[WikiLinks]]` form the knowledge graph edges, traversable by AI via the `build_context` tool.

### MCP Tools (15+)

**Content Management:** write_note, read_note, edit_note, move_note, delete_note, read_content, view_note

**Knowledge Graph Navigation:** build_context (traverse via memory:// URLs), recent_activity, list_directory

**Search:** search, search_notes (filtered), search_by_metadata (frontmatter queries)

**Project Management:** list_memory_projects, create_memory_project, get_current_project, sync_status

**Visualization:** canvas (knowledge graph diagrams)

The `build_context` tool is particularly powerful -- given a `memory://` URL, it traverses the knowledge graph to specified depth, filtered by timeframe, building rich context from related entities.

### Memory Protocol for AI

Basic Memory includes a structured protocol for Claude's auto-memory integration:
- Memories organized into `user/`, `projects/`, `sessions/`, `patterns/` directories
- Isolated from user notes (separate project namespace)
- Auto-searchable via full-text search and knowledge graph traversal
- Explicit instruction: "ASSUME INTERRUPTION: Context may reset - save progress frequently"

### Tech Stack

- **Language:** Python 3.12+
- **Framework:** FastAPI, Pydantic, SQLAlchemy
- **MCP:** fastmcp 3.0.1 (recently upgraded from 2.x)
- **Embeddings:** fastembed 0.7.4+ (local, no API calls)
- **Vector Search:** sqlite-vec 0.1.6+
- **DB:** SQLite (primary), Postgres (optional via asyncpg)
- **CLI:** Typer with Rich formatting
- **Package Manager:** uv (recommended)
- **Logging:** Loguru
- **Tests:** pytest with asyncio, testcontainers (Postgres), testmon

### Development Quality

- 540+ total commits across ~10 contributors
- CI/CD with GitHub Actions
- Comprehensive test suite (unit + integration, SQLite + Postgres)
- Pyright + ty for type checking
- Ruff for linting/formatting
- Alembic for database migrations
- `just` task runner with 15+ development commands

## User Sentiment

**Overall: Positive**

### Reddit (Primary Community)

Sentiment: **Positive** | Confidence: **High**

- Dedicated subreddit r/basicmemory with active community
- Cross-posted to r/ClaudeAI, r/Python, r/ObsidianMD, r/selfhosted, r/mcp
- 69 upvotes on r/selfhosted announcement (strong for niche tool)
- Consistently recommended in "best memory MCP" discussions

**Common Praise:**
- Local-first philosophy: "totally free, straightforward, and locally hosted on your own device"
- Obsidian integration: "AI that reads, writes, and searches your vault intelligently"
- Knowledge graph: "uses a more structured knowledge graph approach with semantic relationships rather than simple key-value storage"
- Human-editable: "simple system to write notes, save them locally and have them be easily viewable and modifiable in Obsidian"
- Recommended over Mem0 for privacy: "For open source, if you can handle some very lite MCP set up, 'basic memory' is great"

**Common Complaints:**
- Initial setup friction: some users had trouble getting MCP tools to appear
- Sync process must stay running for real-time updates
- Not as auto-magical as claude-mem (requires some user intention)

### Twitter/X

Buzz: **Low** | Trend: **Stable**

- Official @basic_memory account exists and is active
- Limited viral reach; community lives on Reddit and Discord

### LinkedIn

Visibility: **Minimal**

- No significant LinkedIn presence for the company or product
- Developer-focused tool, not enterprise marketing

## Competitive Landscape

| Tool | Stars | Approach | Key Strength | Key Weakness |
|------|-------|----------|-------------|-------------|
| **Basic Memory** | 2,552 | Markdown + KG + MCP | Human-readable, Obsidian, local-first | Requires sync, manual effort |
| **Mem0** | 40K+ | Cloud/self-hosted, vector + graph | Enterprise-grade, cross-platform | Cloud dependency, expensive |
| **Claude-Mem** | 29.2K | Hooks + SQLite + Chroma | Auto-capture, zero effort | $CMEM token, zombie processes, AGPL |
| **Official Auto-Memory** | Built-in | CLAUDE.md + MEMORY.md | Zero setup, Anthropic-supported | 200-line limit, no semantic search |
| **OpenMemory MCP** | ~500 | PostgreSQL + Qdrant | Shared cross-tool memory | Requires Docker, complex setup |
| **Memento MCP** | ~200 | Neo4j knowledge graph | Graph + temporal awareness | Neo4j dependency, heavy |
| **In Memoria** | ~300 | MCP pattern learning | Codebase-specific | Niche scope |
| **Cognee** | 12.4K | Python ECL pipeline | Ontology support, graph reasoning | More complex, enterprise-focused |

### Positioning

Basic Memory occupies a unique niche: **structured, human-editable knowledge graphs for privacy-conscious users who want Obsidian integration.** It's more structured than claude-mem (which auto-captures everything as observations), more local-first than Mem0 (which is cloud-first), and more powerful than official auto-memory (which lacks semantic search and graph traversal). The tradeoff is that it requires more intentional use -- you need to ask the AI to create notes or structure knowledge, rather than having it captured automatically.

### Cloud Strategy

The cloud offering ($14.25/month beta, $19 planned) is positioned as a convenience layer, not a replacement:
- Per-project routing: some projects local, some cloud
- Remote MCP for multi-device access
- Local version remains fully functional and free
- "Core principle maintained: your same files, still yours"

This is notably more measured than claude-mem's crypto token approach or Mem0's enterprise pricing.

## Pros and Cons

| Pros | Cons |
|------|------|
| Genuine local-first: all data as human-readable Markdown | AGPL-3.0 license (restrictive for commercial use) |
| Obsidian integration -- works with existing PKM workflows | Requires `sync --watch` to stay current |
| Structured knowledge graph with typed relations | More manual effort than auto-capture solutions |
| 15+ MCP tools with graph traversal | 2,552 stars -- smaller community than Mem0/claude-mem |
| Local vector search (no cloud embeddings) | Open SQL injection vulnerability (#591) |
| Multi-project support with independent databases | Python 3.12+ requirement (not universally available) |
| Optional cloud with transparent pricing | Cloud is beta, still maturing |
| Import from ChatGPT/Claude histories | Limited Twitter/LinkedIn visibility |
| Active development (15+ commits in 3 days) | Primarily single-maintainer (83% of commits) |
| No crypto tokens or aggressive monetization | Some setup friction for non-technical users |
| Context7 quality score: 92.3/100 | |

## Sources

### GitHub
- https://github.com/basicmachines-co/basic-memory
- https://github.com/basicmachines-co/basic-memory/releases

### Reddit
- https://www.reddit.com/r/basicmemory/
- https://www.reddit.com/r/selfhosted/comments/1lupg4n/
- https://www.reddit.com/r/Python/comments/1jctt1v/
- https://www.reddit.com/r/ClaudeAI/comments/1jdga7v/
- https://www.reddit.com/r/ObsidianMD/comments/1l9rdnb/
- https://www.reddit.com/r/ClaudeAI/comments/1m1af6a/
- https://www.reddit.com/r/LocalLLaMA/comments/1mon8it/
- https://www.reddit.com/r/modelcontextprotocol/comments/1j9w0qy/
- https://www.reddit.com/r/mcp/comments/1nxy8s6/
- https://www.reddit.com/r/mcp/comments/1n9xayx/
- https://www.reddit.com/r/ClaudeCode/comments/1on0ops/

### Twitter/X
- https://x.com/basic_memory

### Web
- https://basicmemory.com/
- https://docs.basicmemory.com/
- https://basicmemory.com/blog/basic-memory-cloud-beta/
- https://basicmachines.co/
- https://skywork.ai/skypage/en/A-Deep-Dive-into-Basic-Memory-The-Local-First-MCP-Server-for-Persistent-AI-Knowledge/1972541885506449408
- https://playbooks.com/mcp/basicmachines-memory
- https://mcp.so/server/basic-memory/basicmachines-co
- https://glama.ai/mcp/servers/@basicmachines-co/basic-memory
- https://mcphub.com/mcp-servers/basicmachines-co/basic-memory
- https://www.pulsemcp.com/servers/basicmachines-memory
- https://pypi.org/project/basic-memory/

---
*Generated by Research Agent on 2026-02-23*
