# Brave Search Integration - Design Document

> **For Claude:** This redesigns the research agent to use Brave Search MCP + WebSearch instead of direct site crawling.

**Goal:** Replace failing agent-browser crawls (Reddit, Twitter, LinkedIn) with search-first approach using Brave Search MCP and built-in WebSearch.

**Problem:** Direct site crawling fails due to paywalls (Twitter/X), login walls (LinkedIn), and empty results (Reddit search).

**Solution:** Two-stage search strategy - WebSearch for discovery, Brave for targeted deep searches, agent-browser only for high-value content extraction.

---

## Architecture

**Key change:** No parallel subagents. Lead Researcher does everything sequentially with full MCP access.

```
┌─────────────────────────────────────────────────────────────────┐
│                     /research <input>                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    LEAD RESEARCHER (Main Session)               │
│                                                                 │
│  Has MCP access: GitHub MCP, Brave Search MCP, Context7 MCP    │
│  Has built-in: WebSearch, WebFetch, agent-browser (via Bash)   │
│                                                                 │
│  Sequential workflow:                                           │
│  1. Parse input, generate session ID                           │
│  2. GitHub research (GitHub MCP)                               │
│  3. Reddit research (WebSearch → Brave MCP → agent-browser)    │
│  4. Twitter research (WebSearch → Brave MCP)                   │
│  5. LinkedIn research (WebSearch)                              │
│  6. Web research (WebSearch → Brave news → Context7)           │
│  7. Synthesize findings into report                            │
└─────────────────────────────────────────────────────────────────┘
```

**Why no subagents?**
- Task tool subagents cannot access MCP tools (documented limitation)
- Sequential execution with MCP is better than parallel without MCP
- Simpler architecture, easier to debug

---

## Tool Strategy (Sequential Steps)

All steps run in the main session with full MCP access.

### Step 1: GitHub Research
- **Tool:** GitHub MCP (`search_repositories`, `get_file_contents`, `list_issues`)
- **Output:** `.claude/research-cache/{session}/github-findings.md`

### Step 2: Reddit Research
- **Stage 1 (Discovery):** WebSearch `{topic}` to find themes
- **Stage 2 (Deep Search):** Brave `brave_web_search`:
  - Query: `site:reddit.com {topic} {theme}`
  - Parameters: `freshness: py`, `count: 20`
- **Stage 3 (Deep Content):** agent-browser for high-engagement threads
- **Output:** `.claude/research-cache/{session}/reddit-findings.md`

### Step 3: Twitter Research
- **Stage 1 (Discovery):** WebSearch `{topic}` to find themes
- **Stage 2 (Deep Search):** Brave `brave_web_search`:
  - Query: `site:x.com OR site:twitter.com {topic}`
  - Parameters: `freshness: pm`, `count: 20`
- **Output:** `.claude/research-cache/{session}/twitter-findings.md`

### Step 4: LinkedIn Research
- **Tool:** WebSearch with `allowed_domains: ["linkedin.com"]`
- **Output:** `.claude/research-cache/{session}/linkedin-findings.md`

### Step 5: Web Research
- **Stage 1:** WebSearch `{topic} review OR comparison`
- **Stage 2:** Brave `brave_news_search` with `freshness: pm`
- **Stage 3:** Context7 MCP for documentation
- **Stage 4:** agent-browser for deep-dives if needed
- **Output:** `.claude/research-cache/{session}/web-findings.md`

### Step 6: Synthesis
- Read all findings files
- Generate unified report
- Output Key Insights + full report

---

## Two-Stage Search Strategy

**Purpose:** Use WebSearch to discover the landscape, then craft targeted Brave queries.

**Example for "Cursor IDE":**

| Stage | Tool | Query | Purpose |
|-------|------|-------|---------|
| 1 | WebSearch | `Cursor IDE` | Discover: competitors (VS Code, Zed), concerns (privacy, pricing), buzz words |
| 2a | Brave | `site:reddit.com Cursor IDE vs VS Code` | Comparison sentiment |
| 2b | Brave | `site:reddit.com Cursor IDE privacy telemetry` | Controversy deep-dive |
| 2c | Brave | `site:reddit.com Cursor IDE review 2026` | Recent sentiment |

---

## agent-browser Rules

### Use agent-browser when:

| Subagent | Trigger | Value |
|----------|---------|-------|
| Reddit | High-engagement threads (20+ comments) | Full comment sentiment |
| Web | Technical deep-dives | Full benchmarks, detailed analysis |
| Web | Comparison articles | Full feature tables |

### Never use agent-browser for:

| Source | Reason |
|--------|--------|
| Twitter | Paywall blocks it anyway |
| LinkedIn | Login wall blocks it anyway |
| News articles | Snippets usually sufficient |

### Judgment call:
> "If search snippets don't provide enough detail AND the URL looks accessible (no obvious paywall), use agent-browser to fetch full content."

---

## Brave Search Configuration

### MCP Server
```json
{
  "brave-search": {
    "command": "npx",
    "args": ["-y", "@brave/brave-search-mcp-server"],
    "env": {
      "BRAVE_API_KEY": "YOUR_BRAVE_API_KEY_HERE"
    }
  }
}
```

**Note:** `settings.local.json` is gitignored. Copy from `.claude/settings.local.json.example`.

### Tools Used
- `brave_web_search` - Reddit, Twitter, general web
- `brave_news_search` - Current news and trends

### Tools NOT Used
- `brave_summarizer` - Our subagents do synthesis
- `brave_video_search` - Not needed for research
- `brave_image_search` - Not needed for research
- `brave_local_search` - Not needed for research

### Key Parameters

| Parameter | Reddit | Twitter | Web/News |
|-----------|--------|---------|----------|
| `freshness` | `py` (year) | `pm` (month) | `pm` (month) |
| `count` | 20 | 20 | 20 |
| `safesearch` | `moderate` | `moderate` | `moderate` |

---

## Files to Update

**Architecture change:** No subagent prompts needed. All logic moves to main skill.

| File | Change |
|------|--------|
| `~/.claude.json` | ✅ Done - MCP servers at user scope (brave-search, github, context7) |
| `.env` | ✅ Done - added `BRAVE_API_KEY` |
| `.env.example` | ✅ Done - added `BRAVE_API_KEY` placeholder |
| `.claude/skills/research/SKILL.md` | **Rewrite** - sequential workflow with MCP calls |
| `.claude/prompts/*.md` | **Delete** - no longer needed (no subagents) |
| `CLAUDE.md` | Update "Tools Available" table, remove subagent references |

---

## WebSearch vs Brave Decision Matrix

| Use Case | Tool | Rationale |
|----------|------|-----------|
| Initial discovery | WebSearch | Simple, fast, no API quota |
| Site-specific with freshness | Brave | `site:` filter + `freshness` param |
| News & trends | Brave `brave_news_search` | Dedicated news tool |
| LinkedIn | WebSearch | Simpler, login wall limits value anyway |
| Documentation | Context7 MCP | Specialized for this |
