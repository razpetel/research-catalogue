# Brave Search Integration - Design Document

> **For Claude:** This redesigns the research agent to use Brave Search MCP + WebSearch instead of direct site crawling.

**Goal:** Replace failing agent-browser crawls (Reddit, Twitter, LinkedIn) with search-first approach using Brave Search MCP and built-in WebSearch.

**Problem:** Direct site crawling fails due to paywalls (Twitter/X), login walls (LinkedIn), and empty results (Reddit search).

**Solution:** Two-stage search strategy - WebSearch for discovery, Brave for targeted deep searches, agent-browser only for high-value content extraction.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     /research <input>                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    LEAD RESEARCHER (Opus)                       │
│  Parse input → Generate session → Dispatch 5 subagents          │
└─────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────┬──────────┬┴──────────┬──────────┐
        ▼         ▼          ▼           ▼          ▼
   ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐
   │ GitHub │ │ Reddit │ │Twitter │ │LinkedIn│ │  Web   │
   │        │ │        │ │        │ │        │ │        │
   │GitHub  │ │WebSearch│ │WebSearch│ │WebSearch│ │WebSearch│
   │MCP     │ │   ↓    │ │   ↓    │ │        │ │   ↓    │
   │        │ │Brave   │ │Brave   │ │        │ │Brave   │
   │        │ │   ↓    │ │        │ │        │ │News    │
   │        │ │agent-  │ │        │ │        │ │   ↓    │
   │        │ │browser │ │        │ │        │ │agent-  │
   │        │ │(threads)│ │        │ │        │ │browser │
   │        │ │        │ │        │ │        │ │Context7│
   └────────┘ └────────┘ └────────┘ └────────┘ └────────┘
```

---

## Tool Strategy Per Subagent

### GitHub Subagent
- **Tools:** GitHub MCP only
- **No change** from current design

### Reddit Subagent
- **Stage 1 (Discovery):** WebSearch with `{topic}` to find themes, terminology, controversies
- **Stage 2 (Deep Search):** Brave `brave_web_search` with:
  - Query: `site:reddit.com {topic} {theme}`
  - Parameters: `freshness: py` (past year), `count: 20`
  - Run 2-3 targeted queries based on Stage 1 findings
- **Stage 3 (Deep Content):** agent-browser for high-engagement threads (20+ comments)

### Twitter Subagent
- **Stage 1 (Discovery):** WebSearch with `{topic}` to find themes, influencers, buzz
- **Stage 2 (Deep Search):** Brave `brave_web_search` with:
  - Query: `site:x.com OR site:twitter.com {topic} {theme}`
  - Parameters: `freshness: pm` (past month), `count: 20`
  - Run 2-3 targeted queries based on Stage 1 findings
- **No agent-browser** - paywall blocks it, snippets sufficient

### LinkedIn Subagent
- **Tools:** WebSearch only with `allowed_domains: ["linkedin.com"]`
- **No Brave, no agent-browser** - login wall blocks deep access, snippets sufficient

### Web Subagent
- **Stage 1 (Discovery):** WebSearch with `{topic} review OR comparison`
- **Stage 2 (News):** Brave `brave_news_search` with `freshness: pm`, `count: 20`
- **Stage 3 (Docs):** Context7 MCP for library/framework documentation
- **Stage 4 (Deep Content):** agent-browser for technical deep-dives, comparison tables

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

| File | Change |
|------|--------|
| `.claude/settings.local.json` | ✅ Done - added `brave-search` MCP |
| `.env` | ✅ Done - added `BRAVE_API_KEY` |
| `.env.example` | Add `BRAVE_API_KEY` placeholder |
| `.claude/prompts/reddit-subagent.md` | Rewrite: WebSearch → Brave → agent-browser |
| `.claude/prompts/twitter-subagent.md` | Rewrite: WebSearch → Brave |
| `.claude/prompts/linkedin-subagent.md` | Simplify: WebSearch only |
| `.claude/prompts/web-subagent.md` | Rewrite: WebSearch → Brave news → agent-browser + Context7 |
| `.claude/prompts/github-subagent.md` | No change |
| `.claude/prompts/citation-agent.md` | No change |
| `.claude/skills/research/SKILL.md` | Update tool references |
| `CLAUDE.md` | Update "Tools Available" table |

---

## WebSearch vs Brave Decision Matrix

| Use Case | Tool | Rationale |
|----------|------|-----------|
| Initial discovery | WebSearch | Simple, fast, no API quota |
| Site-specific with freshness | Brave | `site:` filter + `freshness` param |
| News & trends | Brave `brave_news_search` | Dedicated news tool |
| LinkedIn | WebSearch | Simpler, login wall limits value anyway |
| Documentation | Context7 MCP | Specialized for this |
