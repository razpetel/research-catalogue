---
topic: Granular Context Library / Lazy Prompting
slug: granular-context-library
date: 2026-02-02
sources: [web, reddit, twitter]
type: methodology
---

# Granular Context Library / Lazy Prompting Methodology Report

## Overview

The "Granular Context Library" is a Claude Code workflow methodology developed by Teresa Torres (product discovery coach, author of *Continuous Discovery Habits*) and popularized through ChatPRD's "How I AI" platform by Claire Vo. The core insight: instead of maintaining one massive context file, organize AI context into a modular, three-layer system that enables "lazy prompting"—simple prompts that work because the AI intelligently loads only relevant information.

Torres reports running her entire business through two Claude Code terminals integrated with Obsidian, including a `/today` command that generates her daily to-do list. She claims working "10x faster" on writing tasks using this approach.

## Core Methodology

### Three-Layer Context Architecture

| Layer | Location | Purpose | Loading Behavior |
|-------|----------|---------|------------------|
| **Global** | `~/.claude/CLAUDE.md` | Universal preferences, operational guidelines, core values | Loads every session automatically |
| **Project** | `<project>/CLAUDE.md` | Project-specific instructions, style guides, domain constraints | Loads when in project directory |
| **Reference** | `LLM Context/` folder | Business knowledge, templates, team info, product specs | On-demand when semantically relevant |

### The "Lazy Prompting" Effect

When context is properly organized:
- Simple prompts like `/today` generate comprehensive results
- No need for detailed prompt engineering
- AI selectively retrieves relevant context
- Quality doesn't degrade as knowledge base grows

### Four Implementation Steps

1. **Deconstruct into small files**
   - Replace single large context files with dozens of focused markdown files
   - Examples: `brand_guidelines.md`, `marketing_channels.md`, `team_info.md`
   - Each file covers one specific topic

2. **Create index files as maps**
   - Build master index files that point to specific details
   - Index contains structure and pointers, not content
   - Allows AI to navigate to needed information

3. **Add routing instructions**
   - Teach Claude which files to reference for different topics
   - Include in global CLAUDE.md or project-specific files
   - Example: "For brand questions, reference `brand_guidelines.md`"

4. **Build iteratively**
   - End sessions by asking Claude to document what it learned
   - Continuously refine and expand the context library
   - System grows smarter over time

## File Structure Example

```
~/obsidian-vault/
├── .claude/
│   └── CLAUDE.md                    # Global preferences
├── LLM Context/
│   ├── index.md                     # Master map of all context
│   ├── brand_guidelines.md          # Brand voice, colors, values
│   ├── marketing_channels.md        # Where and how we market
│   ├── product_specs.md             # Product details
│   ├── team_info.md                 # Team members, roles
│   ├── customer_personas.md         # Target audience details
│   └── revenue_model.md             # Business model
├── projects/
│   ├── blog-writing/
│   │   └── CLAUDE.md                # Writing-specific context
│   └── product-launch/
│       └── CLAUDE.md                # Launch-specific context
└── tasks/
    └── CLAUDE.md                    # Task management context
```

## Key Practitioners

### Teresa Torres
- **Role:** Product Discovery Coach, Author
- **System:** Claude Code + Obsidian for entire business
- **Command:** `/today` generates daily to-do list
- **Claim:** 10x faster writing with AI assistance
- **Quote:** "Claude Code is only as good as what it knows about you"

### Claire Vo
- **Role:** 3x CPO (LaunchDarkly), ChatPRD Founder
- **Platform:** "How I AI" podcast/blog on Lenny's Podcast network
- **Focus:** Democratizing AI workflows for product managers

## Community Adoption

### Obsidian + Claude Code Ecosystem

The methodology has spawned significant tool development:

| Tool | Function |
|------|----------|
| **Claudian** | Embeds Claude Code directly inside Obsidian |
| **Claude Vault** | Auto-syncs Obsidian vault to git, manages knowledge base |
| **Smart Connect** | Semantic search indexing for vault content |
| **Graphiti MCP** | Neo4j graph database for episodic memories |
| **MCP Tools Plugin** | Exposes search tools to Claude via Model Context Protocol |

### Reddit Discussion Themes

**r/ObsidianMD** (High engagement):
- "Claude Code can directly read and write files in my Obsidian vault"
- "I just downloaded Obsidian after listening to a podcast with Teresa Torres"
- Multiple plugin requests and implementations

**r/ProductManagement** (Mixed):
- Interest in the methodology
- Some skepticism: "Haven't you noticed half of these influencers are just selling a course"

**r/ClaudeAI**:
- Workflow guides proliferating
- Integration pattern discussions

## Comparison to Other Approaches

| Approach | Context Loading | Maintenance | Best For |
|----------|-----------------|-------------|----------|
| **Single CLAUDE.md** | All at once | Simple | Small projects |
| **Granular Context Library** | Selective, layered | Moderate | Power users, businesses |
| **AGENTS.md** | Passive injection | Low | Project documentation |
| **Skills** | On-demand invocation | High | Reusable workflows |
| **MCP Servers** | Tool-based retrieval | High | External integrations |

## Pros and Cons

| Pros | Cons |
|------|------|
| Enables simple "lazy" prompts | Initial setup investment required |
| Context scales without degradation | Learning curve for file organization |
| System improves iteratively | Requires Obsidian or similar tool |
| Modular and maintainable | May fragment context if poorly organized |
| Community tools available | Plugin ecosystem still maturing |
| Works with standard Claude Code | Scale limits with very large vaults |

## Implementation Recommendations

### Getting Started
1. Start with global CLAUDE.md only
2. Add one reference file per session as needs emerge
3. Let Claude suggest what to document at session end
4. Don't over-engineer—let it grow organically

### Best Practices
- Keep files focused on single topics
- Use clear, descriptive filenames
- Include routing instructions in global context
- Review and prune periodically
- Use index files for navigation

### Tools to Consider
- **Obsidian** - Primary note-taking platform
- **Claude Code** - AI agent with file system access
- **Git** - Version control for context library
- **Claudian plugin** - If you want Claude inside Obsidian

## Relationship to Other Methodologies

This methodology complements several approaches documented in our research catalogue:

- **AGENTS.md** (Vercel evals) - Passive context injection; can be used together
- **everything-claude-code** - Comprehensive config; shares modular philosophy
- **Get Shit Done (GSD)** - Context engineering; different approach to same problem
- **Clawdbot Memory System** - Similar layered design (daily logs + curated knowledge)

## Sources

### Primary
- https://www.chatprd.ai/how-i-ai/workflows/how-to-create-a-granular-context-library-for-lazy-prompting-with-ai
- https://creatoreconomy.so/p/automate-your-life-with-claude-code-teresa-torres
- https://www.chatprd.ai/how-i-ai/teresa-torres-claude-code-obsdian-task-management

### Twitter/X
- https://x.com/ttorres/status/1947344391720382489
- https://x.com/ttorres/status/1986134931781599603

### Community
- https://www.reddit.com/r/ProductManagement/comments/1pwpsxm/watched_this_claude_code_walkthrough_on_peter/
- https://www.reddit.com/r/ObsidianMD/comments/1q50v3y/run_claude_code_from_the_sidebar_no_terminal/
- https://www.reddit.com/r/ClaudeAI/comments/1qr19df/claude_code_obsidian_how_i_use_it_short_guide/
- https://www.reddit.com/r/ClaudeCode/comments/1q3zlnl/claude_vault_let_claude_code_manage_your_obsidian/

---
*Generated by Research Agent on 2026-02-02*
