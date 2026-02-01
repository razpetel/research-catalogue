# Sequential Research Agent Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Rewrite the research agent to use sequential execution with full MCP access (Brave Search, GitHub, Context7) instead of parallel subagents.

**Architecture:** Lead Researcher skill runs in main session, calling MCP tools directly in sequence: GitHub → Reddit → Twitter → LinkedIn → Web → Synthesis. No Task tool subagents (they can't access MCP).

**Tech Stack:** Claude Code skills, Brave Search MCP, GitHub MCP, Context7 MCP, WebSearch (built-in), agent-browser (via Bash)

---

## Task 1: Clean Up Old Subagent Prompts

**Files:**
- Delete: `.claude/prompts/` (entire directory)

**Step 1: Remove prompts directory**

```bash
rm -rf .claude/prompts
```

**Step 2: Verify removal**

```bash
ls .claude/
```

Expected: No `prompts` directory

**Step 3: Commit**

```bash
git add -A
git commit -m "chore: remove subagent prompts (moving to sequential architecture)"
```

---

## Task 2: Update CLAUDE.md

**Files:**
- Modify: `CLAUDE.md`

**Step 1: Rewrite CLAUDE.md with new architecture**

Replace entire contents with:

```markdown
# Research Agent

Multi-source research system. Sequential execution with full MCP access.

## Quick Start

```
/research <URL | topic | image-path>
```

For simple factual questions, answer directly — full research not needed.

## Tools Available

| Tool | Use For |
|------|---------|
| GitHub MCP | Repository analysis, code search, issues |
| Brave Search MCP | Web search with freshness control, news search |
| Context7 MCP | Library/framework documentation |
| WebSearch (built-in) | Quick discovery, domain-filtered search |
| agent-browser (Bash) | Deep content extraction when needed |

## Research Flow

Sequential steps (each has full MCP access):
1. **GitHub** - Repository health, technical signals
2. **Reddit** - Community sentiment via Brave search
3. **Twitter** - Real-time buzz via Brave search
4. **LinkedIn** - Professional adoption via WebSearch
5. **Web** - News, docs, comparisons via Brave + Context7
6. **Synthesis** - Unified report generation

## Key Paths

| Path | Purpose |
|------|---------|
| `.claude/skills/research/SKILL.md` | Main research workflow |
| `.claude/research-cache/` | Session temp data |
| `research/catalogue.md` | Research index |
| `research/catalogue/` | Full reports |

## Error Handling

If a source fails, note it and continue:
```
⚠️ [Source] unavailable: [reason]
   Continuing with remaining sources...
```
```

**Step 2: Verify file**

```bash
head -30 CLAUDE.md
```

**Step 3: Commit**

```bash
git add CLAUDE.md
git commit -m "docs: update CLAUDE.md for sequential architecture"
```

---

## Task 3: Rewrite Main Research Skill

**Files:**
- Modify: `.claude/skills/research/SKILL.md`

**Step 1: Rewrite skill with sequential workflow**

Replace entire contents with:

```markdown
---
name: research
description: Research a topic across GitHub, Reddit, Twitter, LinkedIn, and web sources
---

# Research Agent

Sequential multi-source research with full MCP access.

## Workflow

### 1. Parse Input & Setup

**Parse input type:**
- URL → Extract topic from domain/path
- Image → Read with Read tool, extract subject
- Text → Use directly as topic

**Generate slug:**
```
lowercase → replace [^a-z0-9] with "-" → collapse "--" → trim → max 50 chars
```

**Generate session ID:** `YYYYMMDD-HHMMSS-<slug>`

**Create cache directory:** `.claude/research-cache/<session_id>/`

**Display progress:** `🔍 Researching **<topic>**...`

---

### 2. GitHub Research

**Tools:** GitHub MCP

**Process:**
1. Search repositories: `search_repositories` for topic
2. Find primary repo, examine README
3. Check issues, PRs, release cadence
4. Assess: active/stale/abandoned

**Write findings to:** `.claude/research-cache/<session_id>/github-findings.md`

**Format:**
```markdown
## GitHub Findings

### Repository
- Name: [owner/repo]
- Stars: N | Forks: N
- Last commit: YYYY-MM-DD
- Status: [Active/Stale/Abandoned]

### Technical Signals
- Language:
- CI/CD: [Yes/No]
- Test coverage: [Yes/No/Unknown]

### Red Flags
- [Any issues or "None"]

### Sources
- [URLs]
```

---

### 3. Reddit Research

**Tools:** WebSearch → Brave MCP → agent-browser (if needed)

**Process:**
1. **Discovery:** WebSearch for `{topic}` - find themes, terminology
2. **Deep search:** Brave `brave_web_search`:
   - Query: `site:reddit.com {topic}`
   - Params: `freshness: py`, `count: 20`
3. **Deep content:** If high-engagement thread found, use agent-browser

**Write findings to:** `.claude/research-cache/<session_id>/reddit-findings.md`

**Format:**
```markdown
## Reddit Findings

### Sentiment
- Overall: [Positive/Mixed/Negative]
- Confidence: [High/Medium/Low]

### Common Praise
- [Theme]: "[quote]"

### Common Complaints
- [Theme]: "[quote]"

### Notable Threads
- [Title](URL) - [takeaway]

### Sources
- [URLs]
```

---

### 4. Twitter Research

**Tools:** WebSearch → Brave MCP

**Process:**
1. **Discovery:** WebSearch for `{topic}` - find influencers, buzz
2. **Deep search:** Brave `brave_web_search`:
   - Query: `site:x.com OR site:twitter.com {topic}`
   - Params: `freshness: pm`, `count: 20`

**Write findings to:** `.claude/research-cache/<session_id>/twitter-findings.md`

**Format:**
```markdown
## Twitter Findings

### Buzz Level
- Volume: [High/Medium/Low/Minimal]
- Trend: [Rising/Stable/Declining]

### Influencer Takes
- [@handle]: "[quote]" - [Positive/Negative/Neutral]

### General Sentiment
- [Summary]

### Sources
- [URLs]
```

---

### 5. LinkedIn Research

**Tools:** WebSearch only

**Process:**
1. WebSearch with `allowed_domains: ["linkedin.com"]`
2. Note: Login walls limit depth - capture what's visible

**Write findings to:** `.claude/research-cache/<session_id>/linkedin-findings.md`

**Format:**
```markdown
## LinkedIn Findings

### Professional Adoption
- Company mentions: [list]
- Job listings: [None/Few/Moderate/High]

### Industry Commentary
- [Notable posts or "Limited data due to login walls"]

### Sources
- [URLs]
```

---

### 6. Web Research

**Tools:** WebSearch → Brave news → Context7 MCP → agent-browser (if needed)

**Process:**
1. **Discovery:** WebSearch for `{topic} review OR comparison`
2. **News:** Brave `brave_news_search` with `freshness: pm`
3. **Docs:** Context7 `resolve-library-id` → `get-library-docs` (if applicable)
4. **Deep content:** agent-browser for pricing pages, comparison tables

**Write findings to:** `.claude/research-cache/<session_id>/web-findings.md`

**Format:**
```markdown
## Web Findings

### Documentation
- Source: [Context7/Official site]
- Key capabilities: [list]

### News
- [Date]: [Headline](URL) - [summary]

### Pricing
- Model: [Free/Freemium/Paid/Enterprise]
- Key tiers: [list]

### Competitors
| Name | Difference |
|------|------------|
| [X]  | [Y]        |

### Sources
- [URLs]
```

---

### 7. Synthesis

**Process:**
1. Read all 5 findings files from cache
2. Identify common themes across sources
3. Generate unified report

**Output Key Insights (display immediately):**
```markdown
## Key Insights: <topic>

**What it is:** [one sentence]
**What's novel:** [key differentiator]
**How it compares:** [competitive position]
**Bottom line:** [recommendation]

📄 Full report: research/catalogue/YYYY-MM-DD-<slug>.md
```

**Write full report to:** `research/catalogue/YYYY-MM-DD-<slug>.md`

**Report format:**
```markdown
---
topic: <topic>
slug: <slug>
date: YYYY-MM-DD
sources: [github, reddit, twitter, linkedin, web]
---

# <Topic> Research Report

## Overview
[2-3 paragraphs synthesizing all findings]

## Technical Analysis
[From GitHub + Web]

## User Sentiment
**Overall:** [Positive/Mixed/Negative]
- Reddit: [summary]
- Twitter: [summary]
- LinkedIn: [summary]

## Competitive Landscape
[From Web research]

## Pros and Cons
| Pros | Cons |
|------|------|

## Sources
[All URLs from all findings files]

---
*Generated by Research Agent on YYYY-MM-DD*
```

**Update index:** Append row to `research/catalogue.md`
```

**Step 2: Verify file structure**

```bash
head -50 .claude/skills/research/SKILL.md
```

**Step 3: Commit**

```bash
git add .claude/skills/research/SKILL.md
git commit -m "feat: rewrite research skill for sequential MCP execution"
```

---

## Task 4: Verify MCP Configuration

**Files:**
- Check: `~/.claude.json` (user-scope MCP)
- Check: `.claude/settings.local.json` (project-scope, gitignored)

**Step 1: Verify user-scope MCP has all servers**

```bash
grep -A5 '"brave-search"' ~/.claude.json
grep -A5 '"github"' ~/.claude.json
grep -A5 '"context7"' ~/.claude.json
```

Expected: All three servers present with correct config

**Step 2: Verify Brave API key is set**

```bash
grep "BRAVE_API_KEY" ~/.claude.json | head -1
```

Expected: API key present (not empty)

**Step 3: No commit needed** (config files not in repo)

---

## Task 5: Update .gitignore

**Files:**
- Modify: `.gitignore`

**Step 1: Ensure prompts directory won't be recreated**

Check current .gitignore is correct (should already have research-cache):

```bash
cat .gitignore
```

**Step 2: No changes needed if already correct**

---

## Task 6: Smoke Test

**Step 1: Start fresh Claude session**

```bash
cd /Users/razpetel/projects/researcher
claude
```

**Step 2: Test skill loads**

Type `/` and verify `research` appears in autocomplete.

**Step 3: Run minimal test**

```
/research cursor ide --dry-run
```

Or just:
```
/research test
```

**Step 4: Verify MCP tools accessible**

In the session, the skill should be able to call:
- GitHub MCP tools
- Brave Search MCP tools
- Context7 MCP tools

**Step 5: Check output files created**

```bash
ls .claude/research-cache/
ls research/catalogue/
```

---

## Summary

| Task | Description | Files |
|------|-------------|-------|
| 1 | Remove old prompts | `.claude/prompts/` (delete) |
| 2 | Update CLAUDE.md | `CLAUDE.md` |
| 3 | Rewrite skill | `.claude/skills/research/SKILL.md` |
| 4 | Verify MCP config | `~/.claude.json` (check only) |
| 5 | Check .gitignore | `.gitignore` (verify) |
| 6 | Smoke test | Manual test |
