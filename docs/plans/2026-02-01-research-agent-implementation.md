# Research Agent Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a multi-source research agent with parallel subagents that produces comprehensive reports and maintains a searchable catalogue.

**Architecture:** Lead Researcher skill orchestrates 5 parallel subagents (GitHub, Reddit, Twitter, LinkedIn, Web) via Task tool. Subagents write findings to filesystem cache. Citation Agent verifies sources. Final output goes to catalogue.

**Tech Stack:** Claude Code skills, MCP servers (GitHub, Context7), agent-browser CLI, Bash

---

## Task 1: Project Setup and Dependencies

**Files:**
- Create: `scripts/setup.sh`
- Create: `.gitignore`
- Create: `.env.example`

**Step 1: Create setup script**

Create `scripts/setup.sh`:

```bash
#!/bin/bash
set -e

echo "🔧 Setting up Research Agent..."

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js 18+."
    exit 1
fi

echo "✓ Node.js $(node -v)"

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker for GitHub MCP."
    exit 1
fi

echo "✓ Docker found"

# Install agent-browser
echo "📦 Installing agent-browser..."
npm install -g agent-browser
agent-browser install

echo "✓ agent-browser installed"

# Check for .env
if [ ! -f .env ]; then
    echo "⚠️  No .env file found. Copying from .env.example..."
    cp .env.example .env
    echo "   Please edit .env and add your GITHUB_TOKEN"
fi

# Create directories
mkdir -p .claude/research-cache
mkdir -p .claude/skills
mkdir -p .claude/prompts
mkdir -p research/catalogue

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit .env and add your GITHUB_TOKEN"
echo "2. Run: source .env"
echo "3. Use: /research <topic>"
```

**Step 2: Create .gitignore**

Create `.gitignore`:

```gitignore
# Environment
.env
.env.local

# Research cache
.claude/research-cache/

# OS
.DS_Store
Thumbs.db

# Editors
*.swp
*.swo
.idea/
.vscode/

# Node
node_modules/

# Logs
*.log
```

**Step 3: Create .env.example**

Create `.env.example`:

```bash
# GitHub Personal Access Token (required)
# Create at: https://github.com/settings/tokens
# Scopes needed: repo, read:org, read:user
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Context7 API Key (optional - for higher rate limits)
# Get at: https://context7.com/dashboard
# CONTEXT7_API_KEY=ctx7sk-xxxxxxxxxxxxxxxxxxxx
```

**Step 4: Make setup.sh executable and verify**

Run:
```bash
chmod +x scripts/setup.sh
ls -la scripts/setup.sh
```

Expected: `-rwxr-xr-x ... scripts/setup.sh`

**Step 5: Commit**

```bash
git init
git add scripts/setup.sh .gitignore .env.example
git commit -m "chore: add project setup script and gitignore"
```

---

## Task 2: MCP Configuration

**Files:**
- Create: `.claude/settings.local.json`

**Step 1: Create MCP settings**

Create `.claude/settings.local.json`:

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

**Step 2: Verify JSON syntax**

Run:
```bash
cat .claude/settings.local.json | python3 -m json.tool > /dev/null && echo "✓ Valid JSON"
```

Expected: `✓ Valid JSON`

**Step 3: Commit**

```bash
git add .claude/settings.local.json
git commit -m "chore: add MCP server configuration for GitHub and Context7"
```

---

## Task 3: CLAUDE.md Project Instructions

**Files:**
- Create: `CLAUDE.md`

**Step 1: Create CLAUDE.md**

Create `CLAUDE.md`:

```markdown
# Research Agent

Multi-source research system. You are the **Lead Researcher** orchestrating subagents.

## Your Role

Coordinate research by:
1. Parsing user input (URL, image, or topic)
2. Dispatching specialized subagents in parallel
3. Evaluating findings for completeness
4. Synthesizing into unified report
5. Ensuring citation accuracy

## Quick Start

```
/research <URL | topic | image-path>
```

For simple factual questions, answer directly — full research not needed.

## Tools Available

| Tool | Use For |
|------|---------|
| GitHub MCP | Repository analysis, code search, issues |
| Context7 MCP | Library/framework documentation |
| agent-browser (Bash) | All web browsing: Reddit, Twitter, LinkedIn, general |

## Failure Handling

| Scenario | Action |
|----------|--------|
| Subagent timeout | Note as "unavailable", continue |
| Empty findings | Log in findings file, don't block |
| LinkedIn login wall | Report "limited data", continue |
| GitHub rate limit | Note limitation, use available data |
| < 3 subagents succeed | Ask user: continue or retry? |

## Key Paths

| Path | Purpose |
|------|---------|
| `.claude/skills/research.md` | Main orchestration flow |
| `.claude/prompts/*.md` | Subagent instructions |
| `.claude/research-cache/` | Session temp data |
| `research/catalogue.md` | Research index |
| `research/catalogue/` | Full reports |

## Error Format

When reporting errors, use:
```
❌ [Component] failed: [reason]
   Action: [what was done instead]
```
```

**Step 2: Commit**

```bash
git add CLAUDE.md
git commit -m "docs: add CLAUDE.md project instructions"
```

---

## Task 4: Research Catalogue Structure

**Files:**
- Create: `research/catalogue.md`
- Create: `research/catalogue/.gitkeep`

**Step 1: Create catalogue index**

Create `research/catalogue.md`:

```markdown
# Research Catalogue

| Date | Topic | Sentiment | Report |
|------|-------|-----------|--------|
```

**Step 2: Create catalogue directory**

Run:
```bash
mkdir -p research/catalogue
touch research/catalogue/.gitkeep
```

**Step 3: Commit**

```bash
git add research/catalogue.md research/catalogue/.gitkeep
git commit -m "docs: add research catalogue structure"
```

---

## Task 5: GitHub Subagent Prompt

**Files:**
- Create: `.claude/prompts/github-subagent.md`

**Step 1: Create GitHub subagent prompt**

Create `.claude/prompts/github-subagent.md`:

```markdown
# GitHub Research Subagent

## Mission
Assess project health, technical quality, and development velocity.

## Context
Topic: {{topic}}
Session: {{session_id}}
Existing: {{existing_context}}

## Tools
Use GitHub MCP tools ONLY: search_repositories, get_file_contents, list_issues, list_pull_requests, get_repo, etc.

DO NOT use agent-browser or other tools.

## Query Strategy
Broad: Search for "{{topic}}" repositories, find official/primary repo
Narrow: Examine /issues, /pulls, /releases, /graphs/contributors

## When to Search Deeper
- High issue count with unresolved bugs
- Recent mass contributor changes
- Security advisories present
- Complex dependency tree

## When to Stop
- README, issues, recent commits reviewed
- Activity pattern clear (active/stale/abandoned)
- Security status assessed
- No more signals to find

## Output
Write to: `.claude/research-cache/{{session_id}}/github-findings.md`

Format:
```markdown
## GitHub Findings: {{topic}}

### Repository Health
- Repository: [owner/repo](URL)
- Stars: N | Forks: N | Watchers: N
- Open Issues: N | Open PRs: N
- Last commit: YYYY-MM-DD
- Release cadence: [frequent/regular/sporadic/stale]

### Technical Signals
- Primary language:
- Notable dependencies:
- CI/CD: [present/absent] - [tool]
- Test indicators: [yes/no/unknown]

### Red Flags
- [List any: security advisories, abandonment signals, or "None identified"]

### Community Activity
- Top contributors: [count] active in last 6 months
- Issue response time: [fast/moderate/slow/unresponsive]
- PR merge velocity: [description]

### Sources
- [URL] - [one-line summary]
```

## Recency Preference
- Commits/releases: last 6 months
- Issues: last 3 months
```

**Step 2: Commit**

```bash
git add .claude/prompts/github-subagent.md
git commit -m "feat: add GitHub subagent prompt"
```

---

## Task 6: Reddit Subagent Prompt

**Files:**
- Create: `.claude/prompts/reddit-subagent.md`

**Step 1: Create Reddit subagent prompt**

Create `.claude/prompts/reddit-subagent.md`:

```markdown
# Reddit Research Subagent

## Mission
Extract community sentiment, real-world usage stories, unfiltered feedback.

## Context
Topic: {{topic}}
Session: {{session_id}}
Existing: {{existing_context}}

## Tools
Use agent-browser via Bash ONLY:
```bash
agent-browser open "URL"
agent-browser snapshot -i
agent-browser click @eN
agent-browser scroll down
agent-browser close
```

DO NOT use GitHub MCP or Context7.

## Query Strategy
Start broad:
- `agent-browser open "https://www.reddit.com/search/?q={{topic}}&sort=relevance&t=year"`

Navigate to promising threads, then narrow:
- Look for "vs" comparison posts
- Look for "has anyone used" posts
- Check r/programming, r/webdev, r/experienceddevs, topic-specific subs

## When to Search Deeper
- Mixed sentiment threads with nuance
- "X vs Y" comparison discussions
- Threads with 50+ comments
- Recent drama or controversy

## When to Stop
- 5+ relevant threads reviewed
- Sentiment pattern clear (consistent signal)
- Common complaints/praise documented
- No new themes emerging

## Output
Write to: `.claude/research-cache/{{session_id}}/reddit-findings.md`

Format:
```markdown
## Reddit Findings: {{topic}}

### Community Sentiment
- Overall: [Positive / Mixed / Negative]
- Confidence: [High/Medium/Low] based on [N threads, ~M comments]

### Common Praise
- [Theme]: "[representative quote]" — u/user, r/subreddit, YYYY-MM

### Common Complaints
- [Theme]: "[representative quote]" — u/user, r/subreddit, YYYY-MM

### Comparisons Mentioned
- vs [Alternative]: Community tends to prefer [X] because [reason]

### Notable Threads
- [Thread title](URL) — [key takeaway]

### Sources
- [URL] (YYYY-MM) - [summary]
```

## Recency Preference
- Strongly prefer: last 6 months
- Include older only if: highly upvoted (500+) or uniquely insightful
```

**Step 2: Commit**

```bash
git add .claude/prompts/reddit-subagent.md
git commit -m "feat: add Reddit subagent prompt"
```

---

## Task 7: Twitter/X Subagent Prompt

**Files:**
- Create: `.claude/prompts/twitter-subagent.md`

**Step 1: Create Twitter subagent prompt**

Create `.claude/prompts/twitter-subagent.md`:

```markdown
# Twitter/X Research Subagent

## Mission
Capture real-time sentiment, influencer opinions, trending reactions.

## Context
Topic: {{topic}}
Session: {{session_id}}
Existing: {{existing_context}}

## Tools
Use agent-browser via Bash ONLY:
```bash
agent-browser open "URL"
agent-browser snapshot -i
agent-browser click @eN
agent-browser scroll down
agent-browser close
```

DO NOT use GitHub MCP or Context7.

## Query Strategy
Start broad:
- `agent-browser open "https://x.com/search?q={{topic}}&src=typed_query&f=top"`

Then narrow:
- Switch to "Latest" tab for recent tweets
- Look for high-engagement tweets (likes, retweets)
- Identify influential voices (verified, high followers)

## When to Search Deeper
- Launch/announcement with high engagement
- Viral complaint or praise thread
- Influential tech voices commenting
- Rapid sentiment shift visible

## When to Stop
- 10+ relevant tweets reviewed
- Both influencer and general user sentiment sampled
- No new themes emerging
- Timeframe adequately covered

## Output
Write to: `.claude/research-cache/{{session_id}}/twitter-findings.md`

Format:
```markdown
## Twitter Findings: {{topic}}

### Recent Buzz
- Volume: [High / Medium / Low / Minimal]
- Trend: [Rising / Stable / Declining]
- Timeframe sampled: YYYY-MM-DD to YYYY-MM-DD

### Influencer Voices
- [@handle](URL) ([N]K followers): "[quote]" — [Positive/Negative/Neutral]

### General Sentiment
Positive signals:
- [theme or example]

Negative signals:
- [theme or example]

### Notable Threads
- [URL] — [N likes, M retweets] — [key point]

### Sources
- [URL] (YYYY-MM-DD) - [summary]
```

## Recency Preference
- Strongly prefer: last 30 days
- Older only if: major announcement or viral moment
```

**Step 2: Commit**

```bash
git add .claude/prompts/twitter-subagent.md
git commit -m "feat: add Twitter subagent prompt"
```

---

## Task 8: LinkedIn Subagent Prompt

**Files:**
- Create: `.claude/prompts/linkedin-subagent.md`

**Step 1: Create LinkedIn subagent prompt**

Create `.claude/prompts/linkedin-subagent.md`:

```markdown
# LinkedIn Research Subagent

## Mission
Assess professional/enterprise adoption, hiring demand, industry credibility.

## Context
Topic: {{topic}}
Session: {{session_id}}
Existing: {{existing_context}}

## Tools
Use agent-browser via Bash ONLY:
```bash
agent-browser open "URL"
agent-browser snapshot -i
agent-browser click @eN
agent-browser scroll down
agent-browser close
```

DO NOT use GitHub MCP or Context7.

## Important Note
LinkedIn may show login walls or limited content. If blocked:
- Report what IS visible
- Note "Limited data due to login requirement" in output
- Do NOT fail entirely

## Query Strategy
Start with search:
- `agent-browser open "https://www.linkedin.com/search/results/all/?keywords={{topic}}"`

Then explore:
- Company pages posting about topic
- Job listings mentioning topic
- Posts from industry figures

## When to Search Deeper
- Company actively posting about topic
- Significant job listings volume
- Industry thought leaders commenting
- Enterprise case studies visible

## When to Stop
- Company presence assessed
- Job market signal clear
- Professional adoption level determined
- Hit login wall with no workaround

## Output
Write to: `.claude/research-cache/{{session_id}}/linkedin-findings.md`

Format:
```markdown
## LinkedIn Findings: {{topic}}

### Data Availability
[Full access / Partial - login wall encountered / Limited]

### Professional Adoption
- Company mentions: [list companies posting about topic]
- Enterprise signals: [evidence of enterprise usage]

### Hiring Demand
- Job listings estimate: [None / Few (<10) / Moderate (10-50) / High (50+)]
- Typical roles: [list]
- Salary signals: [if visible, else "Not visible"]

### Industry Commentary
- [Name, Title at Company](URL): "[quote or summary]"

### Company Activity
- [Company] posted about {{topic}}: [summary]

### Limitations
[Note any access restrictions encountered]

### Sources
- [URL] - [summary]
```

## Recency Preference
- Posts: last 3 months
- Jobs: current listings only
```

**Step 2: Commit**

```bash
git add .claude/prompts/linkedin-subagent.md
git commit -m "feat: add LinkedIn subagent prompt"
```

---

## Task 9: Web Subagent Prompt

**Files:**
- Create: `.claude/prompts/web-subagent.md`

**Step 1: Create Web subagent prompt**

Create `.claude/prompts/web-subagent.md`:

```markdown
# Web Research Subagent

## Mission
Gather official documentation, news, technical analysis, pricing, competitive comparisons.

## Context
Topic: {{topic}}
Session: {{session_id}}
Existing: {{existing_context}}

## Tools
Use BOTH:
1. Context7 MCP for library/framework documentation
2. agent-browser via Bash for general web browsing

## Query Strategy

### For Documentation (Context7)
1. Call `resolve-library-id` with topic name
2. If found, call `get-library-docs` for relevant sections
3. Summarize key capabilities, getting started, API

### For General Web (agent-browser)
Start broad:
- `agent-browser open "https://www.google.com/search?q={{topic}}+review+2026"`

Then targeted:
- Official website/docs
- Pricing page
- "{{topic}} vs [competitor]" comparisons
- Technical blog posts
- Recent news

## When to Search Deeper
- Conflicting information across sources
- Recent major version or pivot
- Pricing model complex or hidden
- Competitive landscape unclear

## When to Stop
- Official docs summarized (via Context7 or web)
- 3+ independent technical analyses found
- Pricing/features documented
- Key competitors identified

## Output
Write to: `.claude/research-cache/{{session_id}}/web-findings.md`

Format:
```markdown
## Web Findings: {{topic}}

### Official Documentation
Source: [Context7 / Official website]
- Key capabilities: [list]
- Getting started: [summary]
- API highlights: [if applicable]

### News & Announcements
- [YYYY-MM-DD]: [Headline](URL) — [summary]

### Technical Analysis
From [blog/publication name]:
- Key insight: [summary]
- Architecture notes: [if covered]
- Performance notes: [if covered]

### Pricing & Features
- Pricing model: [Free / Freemium / Paid / Enterprise]
- Tiers: [list if applicable]
- Key features: [list]

### Competitive Landscape
| Competitor | Key Difference | {{topic}} Advantage | Competitor Advantage |
|------------|---------------|---------------------|---------------------|
| [Name]     | [difference]  | [advantage]         | [advantage]         |

### Sources
- [URL] - [summary]
```

## Recency Preference
- News: last 6 months
- Docs: always current (prefer Context7)
- Reviews/analysis: prefer 2025-2026
```

**Step 2: Commit**

```bash
git add .claude/prompts/web-subagent.md
git commit -m "feat: add Web subagent prompt"
```

---

## Task 10: Citation Agent Prompt

**Files:**
- Create: `.claude/prompts/citation-agent.md`

**Step 1: Create Citation Agent prompt**

Create `.claude/prompts/citation-agent.md`:

```markdown
# Citation Agent

## Mission
Verify all claims have sources. Check URLs accessible. Flag issues.

## Context
Topic: {{topic}}
Session: {{session_id}}

## Input
You will receive:
1. Synthesized report from Lead Researcher
2. Path to all *-findings.md files in .claude/research-cache/{{session_id}}/

## Process

1. Extract all factual claims from synthesized report
   - Factual = statistics, quotes, comparisons, feature descriptions
   - Skip: agent's own analysis/recommendations (mark as "Analysis")

2. For each factual claim:
   a. Search findings files for supporting source
   b. If found: note the source URL
   c. If not found: flag as "Unsubstantiated"

3. For each unique URL found:
   - Quick accessibility check: `curl -sI -o /dev/null -w "%{http_code}" "URL"`
   - 200-399 = OK
   - 400+ or timeout = Flag as "Broken"

4. Generate verification report

## Rules
- Every factual claim needs a source
- Agent analysis/opinion: OK without source (mark as "Analysis")
- Broken links: try once, flag if fail
- Do NOT block report for minor issues — flag and continue
- Speed over perfection — don't deep-verify every claim

## Output
Return verification summary (do not write to file):

```markdown
## Citation Verification: {{topic}}

### Summary
- Total factual claims: N
- Substantiated: N (X%)
- Unsubstantiated: N
- Agent analysis (no source needed): N
- URLs checked: N
- Broken links: N

### Issues Found

#### Unsubstantiated Claims
- "[Claim text]" — No supporting source found in findings

#### Broken Links
- [URL] — HTTP [status] / timeout

### All Sources Verified
- [URL] — ✓ Accessible
```

## Failure Mode
If verification takes too long or encounters errors:
- Return partial results
- Note: "Verification incomplete: [reason]"
- Do NOT block report generation
```

**Step 2: Commit**

```bash
git add .claude/prompts/citation-agent.md
git commit -m "feat: add Citation Agent prompt"
```

---

## Task 11: Main Research Skill

**Files:**
- Create: `.claude/skills/research.md`

**Step 1: Create the main research skill**

Create `.claude/skills/research.md`:

```markdown
---
name: research
description: Use when user provides a lead (URL, image, or topic) to research comprehensively across GitHub, Reddit, Twitter, LinkedIn, and web sources
---

# Research Agent

Comprehensive multi-source research with parallel subagents.

## Workflow

### 1. Parse Input
- **URL**: Extract topic from page title, path, or domain
- **Image path**: Use Read tool to view image, analyze content, extract subject
- **Text**: Use directly as topic

### 2. Generate Slug
```
lowercase → replace [^a-z0-9] with "-" → collapse "--" → trim → max 50 chars
```

Examples:
- "Cursor IDE" → "cursor-ide"
- "https://linear.app" → "linear"

### 3. Check Existing Entry
```
Glob research/catalogue/*.md
For each: read frontmatter topic:, slugify, compare
Match if slugs equal OR one contains the other
If match: set existing_context with date and "focus on NEW info"
```

### 4. Generate Session ID
Format: `YYYYMMDD-HHMMSS-<slug>`
Create: `.claude/research-cache/<session_id>/`

### 5. Write Plan
Write to `.claude/research-cache/<session_id>/plan.md`:
```markdown
## Research Plan: <topic>
- Input type: [URL/Image/Topic]
- Existing entry: [Yes - path / No]
- Subagents: [github, reddit, twitter, linkedin, web]
```

### 6. Progress Output
Display: `🔍 Researching **<topic>** across 5 sources...`

### 7. Dispatch Subagents
For each source [github, reddit, twitter, linkedin, web]:
1. Read `.claude/prompts/<source>-subagent.md`
2. Replace `{{topic}}`, `{{session_id}}`, `{{existing_context}}`
3. Dispatch: `Task(prompt=interpolated, model="opus")`

Dispatch all 5 in parallel (single message, 5 Task calls).

### 8. Check Success Threshold
- Count subagents with non-empty findings
- If < 3 succeeded:
  ```
  ⚠️ Only N/5 sources returned data.
  Failed: [list]
  Continue with limited data? (yes/no)
  ```
- If >= 3: proceed

### 9. Evaluate Completeness
Check 8 dimensions have data:
1. Overview 2. Technical 3. Trends 4. Key Innovation
5. Competitive Landscape 6. Usefulness 7. Pros/Cons 8. Sentiment

If critical gaps AND retries < 2: dispatch targeted follow-up subagent.

### 10. Synthesize
Combine all findings into unified report.
If updating existing: apply merge strategy (replace sentiment/trends, merge others).

### 11. Citation Verification
```
Read .claude/prompts/citation-agent.md
Replace {{topic}}, {{session_id}}
Task(prompt=interpolated, model="sonnet")
```

### 12. Generate Outputs

**Key Insights** (display immediately):
```markdown
## Key Insights: <topic>

**What it is:** [one sentence]
**What's novel:** [key innovation]
**How it compares:** [competitive position]
**Bottom line:** [assessment]

📄 Full report: research/catalogue/YYYY-MM-DD-<slug>.md
```

**Full Report**:
- If new: Write to `research/catalogue/YYYY-MM-DD-<slug>.md`
- If update: Edit existing file, update `updated:` frontmatter

**Index Update**:
- If new: Append row to `research/catalogue.md`
- If update: Edit existing row, update date

## Report Template

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
[2-3 paragraphs]

## Technical Analysis
[From GitHub + Web]

## Key Innovation
[What's different]

## Trends
[Adoption trajectory]

## Competitive Landscape
| Competitor | Differentiation |
|------------|-----------------|

## Usefulness Assessment
**Best for:** [list]
**Not ideal for:** [list]

## Pros and Cons
| Pros | Cons |
|------|------|

## User Sentiment
**Overall:** [Positive/Mixed/Negative]
**Reddit:** [summary]
**Twitter:** [summary]
**LinkedIn:** [summary]

## Sources
[Full list with URLs]

---
*Generated by Research Agent on YYYY-MM-DD*
```

## Dimensions
1. Overview
2. Technical
3. Trends
4. Key Innovation
5. Competitive Landscape
6. Usefulness
7. Pros and Cons
8. User Sentiment (recency-weighted)
```

**Step 2: Commit**

```bash
git add .claude/skills/research.md
git commit -m "feat: add main /research skill"
```

---

## Task 12: Verification - Test the Setup

**Step 1: Run setup script**

Run:
```bash
./scripts/setup.sh
```

Expected output includes:
- `✓ Node.js v...`
- `✓ Docker found`
- `✓ agent-browser installed`
- `✅ Setup complete!`

**Step 2: Verify directory structure**

Run:
```bash
find . -type f -name "*.md" | grep -v node_modules | sort
```

Expected:
```
./CLAUDE.md
./.claude/prompts/citation-agent.md
./.claude/prompts/github-subagent.md
./.claude/prompts/linkedin-subagent.md
./.claude/prompts/reddit-subagent.md
./.claude/prompts/twitter-subagent.md
./.claude/prompts/web-subagent.md
./.claude/skills/research.md
./docs/plans/2026-02-01-research-agent-design.md
./docs/plans/2026-02-01-research-agent-implementation.md
./research/catalogue.md
```

**Step 3: Verify MCP config**

Run:
```bash
cat .claude/settings.local.json | python3 -m json.tool
```

Expected: Valid JSON output with github and context7 servers.

**Step 4: Create .env from example**

Run:
```bash
cp .env.example .env
echo "Edit .env and add your GITHUB_TOKEN"
```

**Step 5: Final commit**

```bash
git add -A
git commit -m "feat: complete research agent implementation"
```

---

## Task 13: Manual Smoke Test

**Step 1: Start a new Claude Code session in the project**

```bash
cd /Users/razpetel/projects/researcher
claude
```

**Step 2: Test the /research skill**

Type:
```
/research Cursor IDE
```

**Expected behavior:**
1. Displays: `🔍 Researching **Cursor IDE** across 5 sources...`
2. Dispatches 5 subagents in parallel
3. Collects findings from each source
4. Synthesizes report
5. Displays Key Insights
6. Creates `research/catalogue/2026-02-01-cursor-ide.md`
7. Updates `research/catalogue.md` index

**Step 3: Verify outputs**

Check:
```bash
ls research/catalogue/
cat research/catalogue.md
```

---

## Summary

| Task | Description | Files |
|------|-------------|-------|
| 1 | Project setup | `scripts/setup.sh`, `.gitignore`, `.env.example` |
| 2 | MCP config | `.claude/settings.local.json` |
| 3 | CLAUDE.md | `CLAUDE.md` |
| 4 | Catalogue structure | `research/catalogue.md`, `research/catalogue/.gitkeep` |
| 5 | GitHub subagent | `.claude/prompts/github-subagent.md` |
| 6 | Reddit subagent | `.claude/prompts/reddit-subagent.md` |
| 7 | Twitter subagent | `.claude/prompts/twitter-subagent.md` |
| 8 | LinkedIn subagent | `.claude/prompts/linkedin-subagent.md` |
| 9 | Web subagent | `.claude/prompts/web-subagent.md` |
| 10 | Citation agent | `.claude/prompts/citation-agent.md` |
| 11 | Main research skill | `.claude/skills/research.md` |
| 12 | Verification | Run setup, check structure |
| 13 | Smoke test | Test `/research` command |
