# Research Agent

Sequential multi-source research with full MCP access.

## Quick Start

```
/research <URL | topic | image-path>
```

Skip for simple factual questions — answer directly.

## Tools

| Tool | Use For |
|------|---------|
| GitHub MCP | Repository health, issues, code |
| Brave Search MCP | Web search with freshness, news |
| Context7 MCP | Library/framework docs |
| WebSearch | Quick discovery, domain filtering |
| agent-browser | Deep content extraction |

## Research Flow

1. **GitHub** → Repository health, technical signals
2. **Reddit** → Community sentiment (Brave search)
3. **Twitter** → Real-time buzz (Brave search)
4. **LinkedIn** → Professional adoption (WebSearch)
5. **Web** → News, docs, comparisons (Brave + Context7)
6. **Synthesis** → Unified report

## Paths

| Path | Purpose |
|------|---------|
| `.claude/skills/research/` | Skill + templates |
| `.claude/research-cache/` | Session temp data |
| `research/catalogue.md` | Index |
| `research/catalogue/` | Reports |
