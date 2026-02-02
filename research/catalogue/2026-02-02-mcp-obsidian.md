---
topic: MCP Obsidian
slug: mcp-obsidian
date: 2026-02-02
sources: [github, reddit, twitter, linkedin, web]
---

# MCP Obsidian Research Report

## Overview

MCP Obsidian refers to a thriving ecosystem of Model Context Protocol servers that enable AI assistants (Claude, ChatGPT, Cursor, etc.) to interact with Obsidian note vaults. The URL mcp-obsidian.org specifically points to the **bitbonsai/mcp-obsidian** project—a lightweight TypeScript implementation that works directly with vault files without requiring Obsidian to be running.

However, the most popular implementation is **MarkusPfundstein/mcp-obsidian** with 2,795 GitHub stars, which takes a different approach by bridging through Obsidian's Local REST API plugin. The ecosystem now includes 5+ actively maintained implementations, each with different trade-offs between simplicity, features, and integration depth.

The core value proposition across all implementations is **local-first AI access to your knowledge base**—your notes never leave your computer, and AI assistants can read, search, and modify content through a standardized protocol that works across multiple AI platforms.

## Technical Analysis

### bitbonsai/mcp-obsidian (mcp-obsidian.org)
- **Language:** TypeScript/Node.js
- **Stars:** 418 | **Forks:** 25
- **License:** MIT
- **Current version:** 0.7.4
- **Package:** `@mauricio.wolff/mcp-obsidian` on npm

**Key Technical Features:**
- 11-12 MCP methods for complete vault operations
- Direct file access (no REST API plugin required)
- Works without Obsidian running
- Token-optimized responses (40-60% smaller payloads)
- Safe frontmatter parsing with gray-matter library
- Path traversal protection
- Write modes: overwrite, append, prepend
- Tag management (add, remove, list)

**Installation:**
```bash
npx @mauricio.wolff/mcp-obsidian@latest /path/to/vault
```

### MarkusPfundstein/mcp-obsidian (Most Popular)
- **Language:** Python
- **Stars:** 2,795 | **Forks:** 349
- **License:** MIT
- **Contributors:** 16+

**Key Technical Features:**
- 7 core tools via REST API bridge
- Requires Obsidian Local REST API community plugin
- Obsidian must be running
- Full integration with Obsidian features
- MCP Inspector debugging support

**Installation:**
```bash
uvx mcp-obsidian
```

### Other Notable Implementations
| Project | Stars | Approach |
|---------|-------|----------|
| smithery-ai/mcp-obsidian | 1,292 | Claude Desktop connector |
| StevenStavrakis/obsidian-mcp | 629 | Simple MCP server |
| jacksteamdev/obsidian-mcp-tools | 562 | Semantic search + Templater |
| cyanheads/obsidian-mcp-server | 349 | Comprehensive REST bridge |

## User Sentiment

**Overall:** Positive

### Reddit
- **Sentiment:** Strongly positive, high engagement
- Active discussion in r/ObsidianMD (main), r/mcp (37K subscribers), r/ClaudeAI
- Users excited about local-first AI access
- MCP described as "USB-C for AI"
- Some confusion about which implementation to choose
- Interest in Claude Desktop + Claude Code coordination workflows

### Twitter
- **Visibility:** Low
- Conversation happening primarily on Reddit/GitHub rather than Twitter
- Technical niche not yet mainstream on social media

### LinkedIn
- **Professional adoption:** Limited visibility
- Primarily individual developer/knowledge worker use case
- No enterprise case studies found
- Open source community-driven rather than commercial

## Competitive Landscape

| Approach | Example | Best For |
|----------|---------|----------|
| Direct file access | bitbonsai | Simple setup, offline use |
| REST API bridge | MarkusPfundstein | Full Obsidian integration |
| Obsidian plugin | aaronsb/obsidian-mcp-plugin | Native UX |
| Semantic search | jacksteamdev/obsidian-mcp-tools | Intelligent search |
| RAG-enabled | claudiogarza/obsidian-rag-mcp | Meaning-based queries |

**Supported AI Clients:**
- Claude Desktop
- Claude Code
- ChatGPT+ (Enterprise+)
- Cursor IDE
- Windsurf IDE
- IntelliJ IDEA 2025.1+
- Gemini CLI

## Pros and Cons

| Pros | Cons |
|------|------|
| Local-first, privacy-preserving | Multiple competing implementations |
| Open standard (MCP), not locked to one AI | Setup requires technical comfort |
| Free and open source (MIT) | Some require Obsidian REST API plugin |
| Active ecosystem with multiple options | OpenAI only supports remote MCPs |
| Works across multiple AI platforms | Token costs can add up |
| Strong community engagement | No enterprise support |

## Recommendation

**For most users:** Start with **bitbonsai/mcp-obsidian** (mcp-obsidian.org) if you want the simplest setup—one npx command, no plugins required, works offline.

**For power users:** Use **MarkusPfundstein/mcp-obsidian** if you need deeper Obsidian integration and don't mind running Obsidian alongside your AI tool.

**For semantic search:** Consider **jacksteamdev/obsidian-mcp-tools** for AI-powered search by meaning rather than keywords.

## Sources

- https://mcp-obsidian.org/
- https://github.com/bitbonsai/mcp-obsidian
- https://github.com/MarkusPfundstein/mcp-obsidian
- https://github.com/smithery-ai/mcp-obsidian
- https://github.com/StevenStavrakis/obsidian-mcp
- https://github.com/jacksteamdev/obsidian-mcp-tools
- https://github.com/cyanheads/obsidian-mcp-server
- https://www.reddit.com/r/ObsidianMD/
- https://www.reddit.com/r/mcp/

---
*Generated by Research Agent on 2026-02-02*
