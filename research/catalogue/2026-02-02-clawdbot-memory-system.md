---
topic: OpenClaw/Clawdbot Memory System
slug: clawdbot-memory-system
date: 2026-02-02
sources: [github, reddit, twitter, linkedin, web]
---

# OpenClaw/Clawdbot Memory System Research Report

## Overview

This report analyzes the memory architecture of OpenClaw (formerly Clawdbot/Moltbot), based primarily on Manthan Gupta's reverse engineering analysis published at manthanguptaa.in. The memory system represents a fundamentally different approach from cloud-based AI assistants like ChatGPT and Claude—prioritizing transparency, user ownership, and local-first storage over proprietary cloud mechanisms.

OpenClaw's memory architecture uses plain Markdown files stored locally, indexed with sqlite-vec for vector search and FTS5 for keyword matching. This design allows users to read, edit, and own their AI's memory—a sharp contrast to the opaque "black box" memory systems of commercial alternatives. The approach has drawn attention from IBM researchers who suggest it "challenges the hypothesis that autonomous AI agents must be vertically integrated."

## Technical Architecture

### Two-Layer Memory Design

**Layer 1: Daily Logs** (`memory/YYYY-MM-DD.md`)
- Append-only transient observations
- Agent writes preferences, interactions, contextual notes
- Short-term working memory

**Layer 2: Curated Knowledge** (`MEMORY.md`)
- Persistent long-term storage
- Manually refined significant decisions, user preferences, contacts
- Survives indefinitely across sessions

### Directory Structure
```
~/clawd/
├── MEMORY.md              # Long-term curated knowledge
└── memory/
    ├── 2026-01-26.md      # Daily notes
    ├── 2026-01-27.md
    └── ...

~/.clawdbot/memory/        # SQLite indexes (per agent)
```

### Indexing Pipeline

| Stage | Technology | Details |
|-------|------------|---------|
| File Watching | Chokidar | 1.5-second debouncing |
| Chunking | Custom | ~400 tokens, 80-token overlap |
| Embedding | OpenAI/Gemini | 1536 dimensions |
| Vector Storage | sqlite-vec | SQLite extension |
| Full-Text Search | FTS5 | SQLite extension |

### Hybrid Search

```
finalScore = (0.7 × vectorScore) + (0.3 × BM25Score)
```

This combines:
- **Vector search:** Semantically similar content ("that database thing")
- **BM25 keyword search:** Exact terminology matches ("POSTGRES_URL")

### Memory Tools

| Tool | Function |
|------|----------|
| `memory_search` | Semantic query returning scored snippets with file paths and line numbers |
| `memory_get` | Retrieves specific content after search, reading defined line ranges |

Note: No dedicated write tool—agent uses standard file operations, treating memory as regular Markdown files.

### Context vs Memory Separation

```
Context = System Prompt + Conversation History + Tool Results (ephemeral)
Memory = MEMORY.md + memory/*.md + Session Transcripts (persistent)
```

This separation keeps individual requests bounded while allowing indefinite knowledge accumulation.

### Conversation Compaction

**Pre-Compaction Flush** (at 75% context usage):
- Silent prompt triggers agent to extract important information
- Prevents knowledge loss before summarization

**Compaction:**
- Older conversational turns compress into summaries
- Recent messages remain intact
- Original JSONL transcripts preserved on disk

Configuration:
```json
{
  "agents": {
    "defaults": {
      "compaction": {
        "memoryFlush": {
          "enabled": true,
          "softThresholdTokens": 4000
        }
      }
    }
  }
}
```

## Comparative Analysis

### vs ChatGPT Memory (Manthan Gupta's Research)

| Aspect | ChatGPT | OpenClaw |
|--------|---------|----------|
| Architecture | 6-layer injection | 2-layer + hybrid search |
| Storage | Cloud, opaque | Local, transparent Markdown |
| Injection | Pre-computed summaries, always | On-demand retrieval |
| User Control | Limited management UI | Full file system access |
| Portability | Vendor locked | Fully portable |

ChatGPT uses pre-computed summaries injected into every prompt—prioritizing efficiency over depth.

### vs Claude Memory (Manthan Gupta's Research)

| Aspect | Claude | OpenClaw |
|--------|--------|----------|
| Architecture | Tool-based selective retrieval | Hybrid vector + keyword |
| Tools | `conversation_search`, `recent_chats`, `memory_user_edits` | `memory_search`, `memory_get` |
| Context Budget | ~190k tokens rolling window | Configurable with compaction |
| Storage | Cloud, opaque | Local, transparent |

Claude uses on-demand tool calls—accuracy-first approach with selective retrieval.

### Key Differentiation

| Feature | ChatGPT | Claude | OpenClaw |
|---------|---------|--------|----------|
| Philosophy | Efficiency-first | Accuracy-first | Transparency-first |
| User Ownership | No | No | Yes |
| Editable Memory | Limited | XML edits | Full Markdown |
| Audit Trail | Hidden | Hidden | JSONL transcripts |
| Offline Access | No | No | Yes |

## Community Extensions

| Project | Description |
|---------|-------------|
| [ClawRag](https://github.com/2dogsandanerd/ClawRag) | RAG system with Docling + ChromaDB |
| [openclaw-supermemory](https://github.com/yedanyagamiai/openclaw-supermemory) | AI-powered memory management plugin |
| [memU](https://github.com/NevaMind-AI/memU) | Memory service for 24/7 proactive agents |
| [MoltBrain](https://github.com/nhevers/MoltBrain) | Long-term memory layer for OpenClaw & MoltBook |

## User Sentiment

### Positive
- "Simpler than I expected: just JSONL for session history and markdown files" (r/ChatGPT)
- "Plain Markdown in the agent workspace" praised for transparency
- Home Assistant integration users value persistent memory

### Negative
- Memory loss reports on Hetzner VPS ("kept losing its settings and memories")
- "This is a sham... just a prompt looped via heartbeat" (r/accelerate skeptic)
- Concerns about API costs for embeddings

### Professional View
- IBM: Challenges vertical integration hypothesis
- Chris Lema (LinkedIn): "The AI Memory Solution We All Need (No, it's not OpenClaw)"
- DEV.to: "Clearest reference architectures for modern agentic AI systems"

## Pros and Cons

| Pros | Cons |
|------|------|
| Full user ownership of memory | Relies on external embedding APIs |
| Transparent, debuggable Markdown | Setup complexity |
| Hybrid search (vector + keyword) | Memory loss reports exist |
| No vendor lock-in | No automatic cloud sync |
| Survives compaction with disk persistence | Requires local storage management |
| Multi-agent isolation built-in | Each agent needs separate index |

## Recommendations

1. **For Transparency Seekers:** OpenClaw's memory is the most auditable consumer AI memory system available
2. **For Privacy-First Users:** Local storage means no cloud data exposure
3. **For Power Users:** Direct Markdown editing enables fine-grained memory control
4. **For Enterprise:** Consider security implications carefully; containerize deployments
5. **For Developers:** Study the hybrid search architecture as a reference implementation

## Sources

### Primary Analysis
- https://manthanguptaa.in/posts/clawdbot_memory/ (Manthan Gupta's reverse engineering)
- https://manthanguptaa.in/posts/claude_memory/ (Claude comparison)
- https://manthanguptaa.in/posts/chatgpt_memory/ (ChatGPT comparison)

### GitHub
- https://github.com/openclaw/openclaw
- https://github.com/asg017/sqlite-vec
- https://github.com/openclaw/openclaw/discussions/2984

### News & Analysis
- https://www.ibm.com/think/news/clawdbot-ai-agent-testing-limits-vertical-integration
- https://dev.to/safdarali25/from-chaos-to-claws-how-openclaw-won-open-source-in-a-single-week-1a85
- https://lucumr.pocoo.org/2026/1/31/pi/

### Community
- https://www.reddit.com/r/ChatGPT/comments/1qr45nw/everyone_talks_about_clawdbot_openclaw_but_heres/
- https://www.reddit.com/r/AIMemory/comments/1qnp4h3/clawdbot_and_memory/
- https://www.reddit.com/r/ClaudeAI/comments/1pnen0s/analysis_someone_reverseengineered_claudes_memory/

---
*Generated by Research Agent on 2026-02-02*
