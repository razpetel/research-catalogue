# Research Agent - Design Document

> **For Claude:** This is the architecture/design document. For implementation, see the implementation plan.

**Goal:** Build a comprehensive research agent that investigates topics across GitHub, Reddit, Twitter, LinkedIn, and web sources, producing structured reports with key insights and catalogue entries.

**Architecture:** Lead Researcher (Opus) orchestrates 5 parallel source-specialized subagents (Opus), collects findings via filesystem, synthesizes unified report, verifies citations (Sonnet), and outputs to catalogue.

**Tech Stack:** Claude Code, GitHub MCP, Context7 MCP, agent-browser CLI, Bash

---

## 1. Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                     /research <input>                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    LEAD RESEARCHER (Opus)                       │
│  1. Parse input (URL / Image / Topic)                          │
│  2. Generate session ID                                         │
│  3. Check catalogue for existing entry                          │
│  4. Write research plan to cache                                │
│  5. Dispatch subagents in parallel (Task tool)                  │
│  6. Evaluate findings, loop if gaps                             │
│  7. Synthesize unified report                                   │
└─────────────────────────────────────────────────────────────────┘
                              │
        ┌─────────┬──────────┬┴────────┬──────────┬────────┐
        ▼         ▼          ▼         ▼          ▼        │
   ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐  │
   │ GitHub │ │ Reddit │ │Twitter │ │LinkedIn│ │  Web   │  │
   │ Opus   │ │ Opus   │ │ Opus   │ │ Opus   │ │ Opus   │  │
   │GitHub  │ │agent-  │ │agent-  │ │agent-  │ │agent-  │  │
   │MCP     │ │browser │ │browser │ │browser │ │browser │  │
   │        │ │(Bash)  │ │(Bash)  │ │(Bash)  │ │+Context7│  │
   └────┬───┘ └───┬────┘ └───┬────┘ └───┬────┘ └───┬────┘  │
        │         │          │          │          │       │
        │   Write findings to .claude/research-cache/      │
        └─────────┴──────────┴────┬─────┴──────────┘       │
                                  ▼                        │
                    Lead Researcher evaluates              │
                    completeness, loops if gaps ───────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────┐
│                   CITATION AGENT (Sonnet)                       │
│  - Verify claims map to sources                                │
│  - Check URL accessibility                                      │
│  - Flag unsubstantiated claims                                  │
└─────────────────────────────────────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────┐
│                      FINAL OUTPUT                               │
│  1. Display Key Insights immediately                           │
│  2. Write report → research/catalogue/YYYY-MM-DD-<slug>.md     │
│  3. Update index → research/catalogue.md                       │
└─────────────────────────────────────────────────────────────────┘
```

**Key patterns (from Anthropic):**
- Opus orchestrates, Opus executes research, Sonnet verifies citations
- Filesystem as memory - subagents write to files, pass references
- Iterative cycles - Lead evaluates, may spawn more research if gaps
- Broad → specific query strategy within each subagent
- Minimum 3/5 subagents must succeed to proceed

---

## 2. File Structure

```
researcher/
├── .claude/
│   ├── settings.local.json          # MCP configs (github, context7)
│   ├── skills/
│   │   └── research.md              # Main /research skill
│   ├── prompts/
│   │   ├── github-subagent.md
│   │   ├── reddit-subagent.md
│   │   ├── twitter-subagent.md
│   │   ├── linkedin-subagent.md
│   │   ├── web-subagent.md
│   │   └── citation-agent.md
│   └── research-cache/              # Temp session data (gitignored)
│       └── <session-id>/
│           ├── plan.md
│           ├── github-findings.md
│           ├── reddit-findings.md
│           ├── twitter-findings.md
│           ├── linkedin-findings.md
│           └── web-findings.md
├── research/                        # User-facing outputs
│   ├── catalogue.md                 # Running index table
│   └── catalogue/
│       └── YYYY-MM-DD-<slug>.md     # Full reports
├── scripts/
│   └── setup.sh                     # Dependency installation
├── CLAUDE.md                        # Project instructions
├── .env                             # GITHUB_TOKEN (gitignored)
├── .env.example
└── .gitignore
```

---

## 3. MCP Configuration

File: `.claude/settings.local.json`

```json
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run", "-i", "--rm",
        "-e", "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

**Notes:**
- GitHub MCP reads `GITHUB_PERSONAL_ACCESS_TOKEN` from shell environment
- Context7 works without API key; for higher limits, set `CONTEXT7_API_KEY` in environment
- agent-browser invoked via Bash tool, not MCP

---

## 4. Core Algorithms

### 4.1 Slug Generation

```
Input: raw topic string or URL

Algorithm:
1. If URL: extract pathname or domain name as base
   - "https://cursor.sh/pricing" → "cursor"
   - "https://github.com/vercel/next.js" → "next-js"
2. Lowercase the string
3. Replace spaces and special chars with hyphens: [^a-z0-9] → "-"
4. Collapse consecutive hyphens: "--+" → "-"
5. Trim leading/trailing hyphens
6. Truncate to 50 chars max

Examples:
- "Cursor IDE" → "cursor-ide"
- "What is React?" → "what-is-react"
- "https://linear.app" → "linear"
```

### 4.2 Session ID Generation

```
Format: YYYYMMDD-HHMMSS-<slug>
Example: 20260201-143052-cursor-ide
Generated AFTER input parsing (need slug first).
```

### 4.3 Existing Entry Detection

```
Algorithm:
1. Generate slug from input topic
2. Glob: research/catalogue/*.md
3. For each file:
   - Read frontmatter `topic:` field
   - Slugify that topic
   - If slugs match OR slug is substring: candidate match
4. If multiple candidates: pick most recently `updated:`
5. If single candidate: use it
6. If no candidates: treat as new entry
```

### 4.4 Prompt Interpolation

```
For each subagent dispatch:
1. Read prompt file content
2. Replace placeholders:
   - {{topic}} → topic
   - {{session_id}} → session_id
   - {{existing_context}} → existing_context or "None - this is new research"
3. Dispatch: Task(prompt=content, model="opus")
```

### 4.5 Update Merge Strategy

```
Per dimension:
- User Sentiment: REPLACE entirely (recency critical)
- Trends: REPLACE entirely (recency critical)
- Technical: MERGE (keep stable facts, update versions/stats)
- Competitive Landscape: MERGE (add new competitors, update comparisons)
- All others: REPLACE if new data contradicts, APPEND if supplements

Always update:
- `updated:` frontmatter field
- Date in catalogue.md index
```

### 4.6 Catalogue Index Update

```
New entry: Append row to table in catalogue.md
Existing entry:
1. Grep catalogue.md for row containing topic slug
2. Edit that row: update Date column to today
3. If report filename changed, update Report link
```

---

## 5. Agent Specifications

### 5.1 Lead Researcher (Orchestrator)

**Model:** Opus
**Role:** Coordinates entire research flow

**Workflow:**
1. Parse input (URL/Image/Text → topic)
2. Generate slug
3. Check existing entries
4. Generate session ID
5. Write plan to cache
6. Output progress message
7. Dispatch 5 subagents in parallel
8. Collect findings
9. Check success threshold (≥3 required)
10. Evaluate completeness
11. Synthesize unified report
12. Dispatch Citation Agent
13. Generate outputs (Key Insights, Report, Index)

### 5.2 GitHub Subagent

**Model:** Opus
**Tools:** GitHub MCP only
**Mission:** Assess project health, technical quality, development velocity
**Output:** `.claude/research-cache/{{session_id}}/github-findings.md`

### 5.3 Reddit Subagent

**Model:** Opus
**Tools:** agent-browser (via Bash) only
**Mission:** Extract community sentiment, real-world usage, unfiltered feedback
**Output:** `.claude/research-cache/{{session_id}}/reddit-findings.md`

### 5.4 Twitter/X Subagent

**Model:** Opus
**Tools:** agent-browser (via Bash) only
**Mission:** Capture real-time sentiment, influencer opinions, trending reactions
**Output:** `.claude/research-cache/{{session_id}}/twitter-findings.md`

### 5.5 LinkedIn Subagent

**Model:** Opus
**Tools:** agent-browser (via Bash) only
**Mission:** Assess professional/enterprise adoption, hiring demand
**Output:** `.claude/research-cache/{{session_id}}/linkedin-findings.md`

### 5.6 Web Subagent

**Model:** Opus
**Tools:** agent-browser (via Bash) + Context7 MCP
**Mission:** Gather docs, news, technical analysis, pricing, comparisons
**Output:** `.claude/research-cache/{{session_id}}/web-findings.md`

### 5.7 Citation Agent

**Model:** Sonnet
**Tools:** Bash (curl)
**Mission:** Verify claims have sources, check URL accessibility
**Output:** Verification summary (returned, not written to file)

---

## 6. Output Formats

### Key Insights (Displayed Immediately)

```markdown
## Key Insights: <topic>

**What it is:** [One sentence]
**What's novel:** [Key innovation]
**How it compares:** [Competitive position]
**Bottom line:** [Assessment]

📄 Full report: research/catalogue/YYYY-MM-DD-<slug>.md
```

### Full Report (Catalogue Entry)

```markdown
---
topic: <topic>
slug: <slug>
date: YYYY-MM-DD
updated: YYYY-MM-DD
sources: [github, reddit, twitter, linkedin, web]
---

# <Topic> Research Report

## Overview
## Technical Analysis
## Key Innovation
## Trends
## Competitive Landscape
## Usefulness Assessment
## Pros and Cons
## User Sentiment
## Sources
```

### Catalogue Index

```markdown
# Research Catalogue

| Date | Topic | Sentiment | Report |
|------|-------|-----------|--------|
```

---

## 7. External Dependencies

| Dependency | Required | Installation |
|------------|----------|-------------|
| Node.js 18+ | Yes | System install |
| Docker | Yes | System install |
| agent-browser | Yes | `npm install -g agent-browser && agent-browser install` |
| GitHub token | Yes | github.com/settings/tokens |
| Context7 API key | No | context7.com/dashboard |

---

## 8. Components Summary

| Component | Model | Tools | File |
|-----------|-------|-------|------|
| Lead Researcher | Opus | All | `.claude/skills/research.md` |
| GitHub Subagent | Opus | GitHub MCP | `.claude/prompts/github-subagent.md` |
| Reddit Subagent | Opus | agent-browser | `.claude/prompts/reddit-subagent.md` |
| Twitter Subagent | Opus | agent-browser | `.claude/prompts/twitter-subagent.md` |
| LinkedIn Subagent | Opus | agent-browser | `.claude/prompts/linkedin-subagent.md` |
| Web Subagent | Opus | agent-browser + Context7 | `.claude/prompts/web-subagent.md` |
| Citation Agent | Sonnet | Bash (curl) | `.claude/prompts/citation-agent.md` |

---

## 9. Success Criteria

- [x] Parallel subagent dispatch via Task tool
- [x] Source-based specialization (each subagent = one source)
- [x] Filesystem-based memory (findings files in cache)
- [x] Iterative completeness checking with retry
- [x] Citation verification before final output
- [x] Existing entry detection and updates
- [x] Running catalogue index table
- [x] Failure handling with 3/5 threshold
- [x] Progress feedback during execution
