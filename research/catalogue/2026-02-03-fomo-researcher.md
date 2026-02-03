# fomo-researcher

> Claude Code plugin that automates multi-source research across GitHub, Reddit, Twitter, LinkedIn, and web — replacing the "47 open tabs at 2am" workflow.

**Research Date:** 2026-02-03
**Category:** Claude Code Plugins / Research Automation
**Sentiment:** Positive (promising, day 1)

---

## Key Insights

1. **First-mover in multi-source plugin space** — While Claude-Code-Deep-Research (115 stars) exists for deep web research, fomo-researcher is the first to package 5-source research (GitHub, Reddit, Twitter, LinkedIn, Web) as a single Claude Code plugin.

2. **Semantic catalogue matching is novel** — The ability to recognize "memory layer for AI agents" relates to prior "Mem0" research prevents duplicate work. No other research tool offers this.

3. **Day 1 — no community validation** — 1 star (self), 0 forks, 0 issues. The plugin works (evidenced by this research session) but has no external users yet.

4. **Plugin fatigue risk** — Reddit reports users getting confused with 15+ plugins. fomo-researcher's single-skill design may be an advantage.

5. **MCP dependency creates setup friction** — Requires Brave Search API key at minimum; full functionality needs GitHub MCP, Context7, and agent-browser.

---

## Overview

| Attribute | Value |
|-----------|-------|
| **Repository** | [github.com/razpetel/fomo-researcher](https://github.com/razpetel/fomo-researcher) |
| **Creator** | razpetel |
| **Stars** | 1 |
| **Forks** | 0 |
| **Created** | 2026-02-02 (1 day old) |
| **License** | MIT |
| **Status** | Day 1, functional |

---

## What It Does

Single command research automation:

```bash
/research <topic | URL | image-path>
```

### Research Sources

| Source | Method | Freshness |
|--------|--------|-----------|
| **GitHub** | GitHub MCP | Current |
| **Reddit** | Brave Search | Past year |
| **Twitter/X** | Brave Search | Past month |
| **LinkedIn** | WebSearch | Current |
| **Web** | Brave + Context7 | Current |

### Output

1. **Findings files** — Raw intel per source (`.claude/research-cache/`)
2. **Synthesized report** — `research/catalogue/YYYY-MM-DD-<slug>.md`
3. **Catalogue entry** — Indexed in `research/catalogue.md`
4. **Sentiment analysis** — Positive/Mixed/Negative assessment

### Unique Features

**Semantic Catalogue Matching**:
```
📋 Related reports: Mem0 (2026-02-02)
📄 Prior research: "Production-ready, 40K stars, YC-backed"
```

Prevents duplicate research by recognizing conceptual overlap, not just keyword matches.

---

## Installation

```bash
# Add marketplace
/plugin marketplace add razpetel/fomo-researcher

# Install plugin
/plugin install fomo-researcher@razpetel
```

### Prerequisites

| Service | Required | Free Tier | Setup |
|---------|----------|-----------|-------|
| **Brave Search** | Yes | 2K queries/mo | [api-dashboard.search.brave.com](https://api-dashboard.search.brave.com) |
| **GitHub MCP** | Optional | Unlimited | [github.com/settings/tokens](https://github.com/settings/tokens) |
| **Context7** | No | Works without key | Auto-installed |
| **agent-browser** | Optional | Deep extraction | `/plugin install agent-browser@vercel-labs` |

### MCP Configuration

Add to `~/.claude.json`:

```json
{
  "mcpServers": {
    "brave-search": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@brave/brave-search-mcp-server"],
      "env": { "BRAVE_API_KEY": "${BRAVE_API_KEY}" }
    }
  }
}
```

---

## Competitive Landscape

| Tool | Stars | Sources | Catalogue | Semantic Match |
|------|-------|---------|-----------|----------------|
| **fomo-researcher** | 1 | 5 | Yes | Yes |
| **Claude-Code-Deep-Research** | 115 | Web | No | No |
| **last30days-skill** | ? | 2 (Reddit, Twitter) | No | No |
| **social_research_agent** | ? | Multi | No | No |

### Differentiators

1. **Breadth**: 5 sources vs typical 1-2
2. **Memory**: Semantic catalogue prevents duplicates
3. **Packaging**: Official plugin format with easy installation
4. **Freshness tuning**: Per-source parameters

### Gaps vs Competitors

1. **No deep research mode**: Claude-Code-Deep-Research does iterative deep dives
2. **No parallel agents**: Some tools spawn multiple subagents
3. **Day 1 maturity**: No battle-testing

---

## Architecture

```
/research "topic"
       │
       ▼
┌──────────────────────┐
│  Catalogue Check     │ ← Semantic matching
│  (research/catalogue.md)
└──────────┬───────────┘
           │
    ┌──────┼──────┬──────┬──────┐
    ▼      ▼      ▼      ▼      ▼
 GitHub  Reddit Twitter LinkedIn Web
   │       │       │       │      │
   └───────┴───────┴───────┴──────┘
                   │
                   ▼
         ┌─────────────────┐
         │    Synthesis    │
         │ (cross-reference)
         └────────┬────────┘
                  │
       ┌──────────┼──────────┐
       ▼          ▼          ▼
    Report    Catalogue   Key Insights
    (*.md)     Entry      (displayed)
```

---

## Usage Examples

```bash
# Tool research
/research Cursor IDE

# URL deep-dive
/research https://github.com/anthropics/claude-code

# Screenshot analysis
/research screenshot.png

# Vague query
/research "that memory thing everyone's talking about"
```

### When NOT to Use

- Simple factual questions (Claude knows)
- Code fixes (different skill)
- Non-research tasks

---

## Current Limitations

| Limitation | Impact |
|------------|--------|
| Day 1 maturity | No community validation |
| MCP setup required | Friction for new users |
| No deep research mode | Less depth than Claude-Code-Deep-Research |
| Single maintainer | Bus factor risk |
| Brave API required | Costs after 2K queries/mo |

---

## Roadmap Speculation

Based on README and design:

1. **Parallel subagents** — Spawn 5 agents for simultaneous source research
2. **Deep research mode** — Iterative investigation for complex topics
3. **Export formats** — PDF, Notion, Obsidian integration
4. **Caching** — Reduce API calls for repeated queries

---

## Verdict

**Promising day-1 tool that addresses a real workflow pain point.** The 5-source breadth and semantic catalogue matching are genuine innovations in the Claude Code plugin space. However, with 1 star and no external users, it's too early to recommend for production use.

**Watch for:**
- Community adoption signals
- Additional contributors
- Deep research mode addition

**Best for:**
- Early adopters comfortable with MCP setup
- Developers researching tools/libraries frequently
- Teams wanting structured research documentation

---

## Related Reports

- **[Context Engineering](2026-02-02-context-engineering.md)** — Background on Claude Code context management
- **[agent-browser](2026-02-02-agent-browser.md)** — Deep extraction tool used by fomo-researcher
- **[Context7](2026-02-02-context7.md)** — Documentation MCP used for library research

---

## Sources

### Primary
- [GitHub: razpetel/fomo-researcher](https://github.com/razpetel/fomo-researcher)

### Competitors
- [GitHub: AnkitClassicVision/Claude-Code-Deep-Research](https://github.com/AnkitClassicVision/Claude-Code-Deep-Research) (115 stars)
- [GitHub: mvanhorn/last30days-skill](https://github.com/mvanhorn/last30days-skill)

### Community
- [Reddit: Created a deep researcher for Claude code](https://www.reddit.com/r/ClaudeAI/comments/1lnrzwl/created_a_deep_researcher_for_claude_code/)
- [Reddit: I spent way too long cataloguing Claude Code tools](https://www.reddit.com/r/ClaudeAI/comments/1ofltdr/i_spent_way_too_long_cataloguing_claude_code/)
- [Reddit: Any idea of using claude code to do deep research?](https://www.reddit.com/r/ClaudeAI/comments/1n424t4/any_idea_of_using_claude_code_to_do_deep_research/)

### Official
- [Claude Blog: Customize Claude Code with plugins](https://claude.com/blog/claude-code-plugins)
- [Anthropic: Building agents with the Claude Agent SDK](https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk)
