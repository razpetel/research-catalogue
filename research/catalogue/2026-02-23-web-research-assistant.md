---
topic: Web Research Assistant (elad12390)
slug: web-research-assistant
date: 2026-02-23
sources: [github, reddit, twitter, linkedin, web]
---

# Web Research Assistant MCP Server Research Report

## Overview

Web Research Assistant is a Python-based MCP server by Elad Ben-Haim (elad12390) that bundles 13 tools, 4 MCP resources, and 5 MCP prompts into a comprehensive developer research toolkit. Built on top of a self-hosted SearXNG metasearch engine and crawl4ai for content extraction, it goes far beyond typical search-only MCP servers by adding package registry lookups (npm, PyPI, crates.io, Go), GitHub repository health metrics, Stack Overflow error translation, API documentation auto-discovery, technology comparison, changelog fetching, and service status monitoring for 120+ services. It also includes Pixabay image search and structured data extraction from web pages.

The project was created on November 16, 2025 (originally as "searxng-mcp"), reached v0.3.0 by December 3, 2025, and had a final reliability improvement commit on January 2, 2026. Despite its impressive feature breadth, the project has only 6 GitHub stars, ~53 monthly PyPI downloads, and zero community visibility outside MCP directory listings (Glama.ai, LobeHub). It has no issues, no pull requests, and no outside contributors. The SearXNG MCP space is dominated by ihor-sokoliuk/mcp-searxng (481 stars, 79 forks), which focuses on search + URL reading + caching -- a narrower but more popular and battle-tested approach.

The broader MCP web search landscape is dominated by cloud APIs: Tavily (community-preferred, $8+ CPM), Brave Search API (privacy-focused), Exa (semantic search), and Perplexity Sonar. SearXNG-based MCP servers occupy a niche for users who prioritize self-hosting and privacy, but require Docker setup and search engine configuration, creating a higher barrier to entry. Within that niche, web-research-assistant is uniquely ambitious in scope but lacks the community traction to validate its reliability at scale.

## Technical Analysis

**Architecture:** Clean modular Python codebase with each module under 400 lines. Source lives in `src/searxng_mcp/` with separate files for search, crawling, images, package registries, GitHub, errors, API docs, tracking, and the MCP server. Uses `httpx` for HTTP, `crawl4ai` for content extraction, and `beautifulsoup4` for HTML parsing.

**Installation:** Available via `uvx web-research-assistant` (zero-install), `pip install`, or `uv tool install`. Communicates over stdio for easy MCP client integration. Requires a SearXNG instance running on `http://localhost:2288` (Docker recommended).

**Quality signals:**
- CI/CD via GitHub Actions
- Tests with pytest
- Linting with ruff and mypy
- Glama.ai rates it Security A, License A, Quality A
- Comprehensive documentation (27 files in docs/)
- Usage analytics built-in with `reasoning` parameter on every tool call
- All tools have error handling and response size limits (8KB default)

**Version history:**
- v0.1.0 (Nov 16, 2025): Initial release with 13 tools
- v0.2.0 (Dec 3, 2025): Reliability improvements (api_docs 58%→90%, service_status 70%→90%+, github_repo 88%→95%+)
- v0.3.0 (Dec 3, 2025): Added 4 MCP Resources and 5 MCP Prompts
- Jan 2, 2026: Retry logic, TTL caching, 108 API aliases, 35+ new status pages

**Concerns:**
- Docker dependency for SearXNG is a significant setup barrier
- crawl4ai requires Playwright/Chromium for advanced crawling
- No type stubs or strict mypy (`disallow_untyped_defs = false`)
- Single contributor with no outside review of code

## User Sentiment

**Overall:** No direct sentiment (zero community visibility)

- Reddit: No mentions of web-research-assistant specifically. The SearXNG MCP ecosystem is discussed positively in r/mcp, r/OpenWebUI, and r/LocalLLaMA for privacy and speed, but setup complexity is a recurring complaint. The dominant SearXNG MCP (ihor-sokoliuk) is the one being discussed and recommended.
- Twitter: Zero mentions found for web-research-assistant or elad12390
- LinkedIn: Zero mentions found

## Competitive Landscape

The MCP web search space is highly competitive with clear tiers:

**Tier 1 - Cloud APIs (most popular):**
- Tavily: Community consensus #1 for AI web search. Paid ($8+ CPM), excellent LangChain integration, 1000 free calls/month
- Exa: Semantic/neural search. Paid ($2.5+ CPM), excellent for specific item discovery
- Brave Search API: Privacy-focused cloud search, $0-9/1K queries, 30B+ page index

**Tier 2 - Self-hosted SearXNG (privacy niche):**
- ihor-sokoliuk/mcp-searxng (481 stars): Dominant. Search + URL read + caching + pagination. Node.js
- SecretiveShell/searxng-mcp-server: Simplest setup, good starting point
- **web-research-assistant (6 stars):** Broadest feature set (13 tools) but lowest adoption. Python
- crawl4ai-rag-mcp (ToKiDoO): Docker all-in-one with search + crawl + vector DB + RAG

**Tier 3 - Multi-engine aggregators:**
- mcp-omnisearch: Unified interface across Tavily, Brave, Kagi, Perplexity, Exa

web-research-assistant's unique positioning is as a "developer research toolkit" rather than a search-only server. The package registry, GitHub, error translation, API docs, tech comparison, and service status tools have no equivalent in other SearXNG MCP servers. However, this breadth hasn't translated to adoption, likely because: (a) the dominant ihor-sokoliuk version is "good enough" for most search needs, (b) Docker setup friction, and (c) zero marketing/community engagement.

## Pros and Cons

| Pros | Cons |
|------|------|
| Broadest SearXNG MCP: 13 tools covering search, packages, GitHub, errors, docs, comparison, status | Only 6 stars, ~53 downloads/month -- near-zero adoption |
| Clean modular Python codebase (<400 LOC per module) | Requires Docker SearXNG instance (high setup friction) |
| MCP Resources + Prompts (beyond just tools) | Single contributor, no outside code review |
| Free and self-hosted (privacy-preserving) | Last commit 52 days ago -- may be abandoned |
| Published on PyPI with uvx zero-install | Zero community visibility (no Reddit/Twitter/LinkedIn mentions) |
| Glama.ai triple-A quality rating | Competing with 481-star dominant SearXNG MCP |
| Built-in usage analytics and retry logic | crawl4ai requires Playwright/Chromium (heavy dependency) |
| 120+ service status pages, 108 API aliases | No benchmarks or real-world usage reports |

## Sources

- https://github.com/elad12390/web-research-assistant
- https://pypi.org/project/web-research-assistant/
- https://glama.ai/mcp/servers/@elad12390/web-research-assistant
- https://pypistats.org/packages/web-research-assistant
- https://github.com/ihor-sokoliuk/mcp-searxng
- https://www.reddit.com/r/mcp/comments/1m5gts9/best_web_search_mcp_server/
- https://skywork.ai/skypage/en/searxng-mcp-server-ai-agent/1977988153954193408
- https://aimultiple.com/browser-mcp
- https://fastmcp.me/MCP/Explore?category=Web+Search

---
*Generated by Research Agent on 2026-02-23*
