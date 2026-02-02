---
name: research
description: Use when given a topic, URL, or image to investigate across GitHub, Reddit, Twitter, LinkedIn, and web
---

# Research Agent

Sequential multi-source research with full MCP access.

## When to Use

**Use for:** Products, tools, libraries, companies, technologies needing comprehensive analysis

**Skip for:** Simple facts, definitions, quick lookups — answer directly

## Quick Reference

| Step | Tools | Output |
|------|-------|--------|
| Setup | Parse input, read catalogue.md, semantic match | 📋 Related reports: [...] |
| GitHub | GitHub MCP | `github-findings.md` |
| Reddit | WebSearch → Brave (`site:reddit.com`, `freshness: py`) | `reddit-findings.md` |
| Twitter | WebSearch → Brave (`site:x.com`, `freshness: pm`) | `twitter-findings.md` |
| LinkedIn | WebSearch (`allowed_domains: ["linkedin.com"]`) | `linkedin-findings.md` |
| Web | WebSearch → Brave news → Context7 | `web-findings.md` |
| Synthesis | Read all findings → Generate report | `research/catalogue/YYYY-MM-DD-<slug>.md` |

## Workflow

### 1. Setup

1. Parse input: URL → extract domain/path | Image → Read + extract subject | Text → use directly
2. Generate slug: `lowercase → replace [^a-z0-9] with "-" → collapse → trim 50 chars`
3. **Check for related reports (MANDATORY):**
   - Read `research/catalogue.md`
   - Scan Topic and Summary columns for semantic overlap with research subject
   - Related if: same product/tool, competing product, subset/superset topic, or prior version
   - **MUST display:**
     ```
     📋 Related reports: [NONE | list with dates]
     ```
   - If related found: Read the most relevant report, display:
     ```
     📄 Prior research ([DATE]): [1-line key conclusion]
     ```
   - Note: Merge decision happens in Synthesis after gathering new findings
4. Generate session ID: `YYYYMMDD-HHMMSS-<slug>`
5. Create: `.claude/research-cache/<session_id>/`
6. Display: `Researching **<topic>**...` (add `(updating [DATE])` if related report found)

### 2. GitHub Research

**Tools:** GitHub MCP (`search_repositories`, `get_file_contents`, `list_issues`)

1. Search for topic, find primary repo
2. Examine README, issues, PRs, releases
3. Assess: active/stale/abandoned
4. Write to `github-findings.md` (see templates.md)

### 3. Reddit Research

**Tools:** WebSearch → Brave MCP → agent-browser (if needed)

1. WebSearch `{topic}` to find themes
2. Brave `brave_web_search`: `site:reddit.com {topic}`, `freshness: py`, `count: 20`
3. If high-engagement thread: agent-browser for comments
4. Write to `reddit-findings.md`

### 4. Twitter Research

**Tools:** WebSearch → Brave MCP

1. WebSearch `{topic}` to find influencers, buzz
2. Brave `brave_web_search`: `site:x.com OR site:twitter.com {topic}`, `freshness: pm`, `count: 20`
3. Write to `twitter-findings.md`

### 5. LinkedIn Research

**Tools:** WebSearch only

1. WebSearch with `allowed_domains: ["linkedin.com"]`
2. Note: Login walls limit depth — capture what's visible
3. Write to `linkedin-findings.md`

### 6. Web Research

**Tools:** WebSearch → Brave news → Context7 → agent-browser (if needed)

1. WebSearch `{topic} review OR comparison`
2. Brave `brave_news_search`, `freshness: pm`, `count: 20`
3. Context7: `resolve-library-id` → `get-library-docs` (if applicable)
4. agent-browser for pricing pages, comparison tables (if needed)
5. Write to `web-findings.md`

### 7. Synthesis

**If related report was found in Setup, decide how to proceed:**

```
┌─────────────────────────────────────┐
│ Related report from Setup?          │
└──────────────┬──────────────────────┘
               │
        yes    │    no
    ┌──────────┴──────────┐
    ▼                     ▼
┌───────────┐      ┌─────────────┐
│ Compare   │      │ Write new   │
│ findings  │      │ report      │
└─────┬─────┘      └─────────────┘
      │
      ▼
┌─────────────────────────────────────┐
│ What changed?                       │
│ • New findings contradict old?      │
│ • Significant updates (stars, etc)? │
│ • Same conclusions?                 │
└──────────────┬──────────────────────┘
               │
    ┌──────────┴──────────┐
    ▼                     ▼
┌───────────┐      ┌─────────────┐
│ Merge:    │      │ Minor: keep │
│ update    │      │ old, note   │
│ report    │      │ "verified"  │
└───────────┘      └─────────────┘
```

**Then synthesize:**
1. Read all 5 findings files
2. If existing report: Compare findings, identify what changed
3. Identify themes across sources
4. Display Key Insights immediately (see templates.md)
5. Write report to `research/catalogue/YYYY-MM-DD-<slug>.md`
   - New topic: Create fresh report
   - Changed significantly: Merge new findings, note what evolved
   - Minor changes: Update date, add "Last verified" note
6. Update `research/catalogue.md` (columns: Date | Topic | Summary | Sentiment | Report):
   - New: Append row with 2-3 sentence summary
   - Update: Revise existing row's date, summary, and sentiment

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Skipping catalogue check | ALWAYS read catalogue.md in Setup, display 📋 output |
| Slug-only matching | Use semantic matching — "Mem0" relates to "memory layer" |
| Missing the 📋 output | If you didn't display it, you didn't check |
| Skipping GitHub for non-code topics | Always check — many products have repos |
| Deep-diving one source | Balance across all 5 |
| Missing Context7 for libraries | Always try `resolve-library-id` |
| Forgetting freshness params | Reddit: `py` (year), Twitter: `pm` (month) |

## Output Formats

See `templates.md` in this directory for all output formats.
