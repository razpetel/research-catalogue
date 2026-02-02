# Claude Code Context Engineering

> Comprehensive guide to managing context in Claude Code, synthesizing official Anthropic framework, product features, practitioner workflows, and community tools.

**Research Date:** 2026-02-02
**Category:** AI/LLM Context Management
**Sentiment:** Very Positive (foundational capability)

---

## Key Insights

1. **Context engineering > prompt engineering** - It's about strategically curating the finite "attention budget" across system instructions, tools, examples, and message history—not just writing better prompts.

2. **Context rot is real** - Models degrade with extensive contexts due to transformer architecture's n² pairwise token relationships. The sweet spot is 70-80% capacity before compaction.

3. **Automation beats manual memory** - Using hooks to persist context automatically outperforms prompting Claude to "remember things when you think you should."

4. **Skills consume less context than raw MCP** - Converting frequently-used MCPs to skills enables 85% free context at session start vs heavy MCP overhead.

5. **Sub-agents isolate context** - Specialized agents handle focused tasks with clean context windows, returning 1,000-2,000 token summaries to the coordinator.

---

## Official Framework: Context Engineering Principles

**Source:** [Anthropic Engineering Blog](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)

### Core Definition

Context engineering = strategically curating tokens provided to language models during inference. It addresses optimizing a finite "attention budget" across:
- System instructions
- Tool definitions
- Examples
- Message history
- Retrieved documents

### The Guiding Principle

> "Find the smallest set of high-signal tokens that maximize the likelihood of your desired outcome."

### Key Techniques

| Technique | Description |
|-----------|-------------|
| **System Prompts** | "Right altitude" - specific enough to guide, flexible enough to avoid brittleness |
| **Tools** | Token-efficient, minimal functional overlap, clear input parameters |
| **Examples** | Diverse canonical examples > exhaustive edge case lists |
| **Just-in-Time Retrieval** | Lightweight identifiers (file paths, URLs), dynamic retrieval at runtime |

### Long-Horizon Strategies

1. **Compaction** - Summarize conversation history, preserve architectural decisions and critical details
2. **Structured Note-Taking** - Persistent external memory (NOTES.md, progress.txt files)
3. **Sub-Agent Architectures** - Specialized agents with clean context windows, return condensed summaries

---

## Official Product Features

**Source:** [Claude Blog: Context Management](https://claude.com/blog/context-management)

### Context Editing (Public Beta)

Automatically clears stale tool calls and results when approaching token limits:
- **84% token reduction** in 100-turn web search evaluation
- Removes outdated information while preserving conversation flow
- Enables agents to operate longer without manual intervention

### Memory Tool (Public Beta)

Persistent storage in user-managed backend:
- Create, read, update, delete files in dedicated memory directory
- Persists across conversations without consuming context window
- Client-side operation gives complete control over data persistence

### Combined Impact

| Configuration | Performance Improvement |
|---------------|------------------------|
| Context editing alone | 29% |
| Context editing + memory | 39% |

---

## Essential Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/context` | Show current token usage | Mid-session monitoring |
| `/clear` | Reset conversation history | Task transitions |
| `/compact` | Compress history | At 70% capacity |
| `/usage` | Display costs and tokens | Cost tracking |
| `/catchup` | Read changed git files | After `/clear` |

---

## Practitioner Workflows

**Source:** [blog.sshh.io - How I Use Every Claude Code Feature](https://blog.sshh.io/p/how-i-use-every-claude-code-feature)

### CLAUDE.md Philosophy

- Treat it as the agent's "constitution"
- **Token budget allocation**: Document only tools used by 30%+ of engineers
- Start with guardrails, not comprehensive manuals
- Allocate token budget per tool "like selling advertising space"

### Three Restart Workflows

1. **`/compact`** - Avoided due to opacity (what gets kept is unclear)
2. **`/clear` + `/catchup`** - Simple reboots, preserves git context
3. **"Document & Clear"** - For complex tasks:
   - Dump progress to markdown file
   - `/clear`
   - Reference markdown to resume

### Baseline Context Budget

In a well-configured monorepo:
- **~20K tokens** baseline context (10% of 200K window)
- **180K tokens** available for actual work

---

## Natural Breakpoints for Clearing

Clear context at these moments:
- After completing a feature
- Before starting unrelated work
- Following a git commit
- When transitioning between frontend and backend work
- When context meter hits 70-80%

---

## Persistent Memory System

### Project-Level (`./CLAUDE.md`)
```markdown
# Project Context
- Code style conventions
- Build commands
- Architecture decisions
- Tech stack specifics
```

### User-Level (`~/.claude/CLAUDE.md`)
```markdown
# Personal Preferences
- Preferred frameworks
- Documentation standards
- Common patterns
```

### Active Context Pattern (from Cline)
```markdown
# CLAUDE-active-context.md
Current task: [description]
Key decisions: [list]
Next steps: [list]
```

---

## Granular Context Library (Advanced Pattern)

**Source:** Teresa Torres (Product Discovery Coach) via [ChatPRD](https://www.chatprd.ai/how-i-ai/workflows/how-to-create-a-granular-context-library-for-lazy-prompting-with-ai)

A three-layer modular system that enables "lazy prompting"—simple prompts that work because the AI intelligently loads only relevant information.

### Three-Layer Architecture

| Layer | Location | Purpose | Loading |
|-------|----------|---------|---------|
| **Global** | `~/.claude/CLAUDE.md` | Universal preferences, core values | Every session |
| **Project** | `<project>/CLAUDE.md` | Project-specific instructions | In project directory |
| **Reference** | `LLM Context/` folder | Business knowledge, templates, specs | On-demand when relevant |

### The "Lazy Prompting" Effect

When context is properly organized:
- Simple prompts like `/today` generate comprehensive results
- No need for detailed prompt engineering
- AI selectively retrieves relevant context
- Quality doesn't degrade as knowledge base grows

### Implementation Steps

1. **Deconstruct into small files**
   - Replace single large context with dozens of focused markdown files
   - Examples: `brand_guidelines.md`, `marketing_channels.md`, `team_info.md`

2. **Create index files as maps**
   - Build master index that points to specific details
   - Index contains structure and pointers, not content

3. **Add routing instructions**
   - Teach Claude which files to reference for different topics
   - Example: "For brand questions, reference `brand_guidelines.md`"

4. **Build iteratively**
   - End sessions by asking Claude to document what it learned
   - System grows smarter over time

### File Structure Example

```
~/obsidian-vault/
├── .claude/
│   └── CLAUDE.md                    # Global preferences
├── LLM Context/
│   ├── index.md                     # Master map
│   ├── brand_guidelines.md          # Brand voice, colors
│   ├── product_specs.md             # Product details
│   ├── team_info.md                 # Team members, roles
│   └── customer_personas.md         # Target audience
├── projects/
│   ├── blog-writing/
│   │   └── CLAUDE.md                # Writing-specific
│   └── product-launch/
│       └── CLAUDE.md                # Launch-specific
```

### Practitioner Example

**Teresa Torres:**
- Runs entire business through two Claude Code terminals + Obsidian
- `/today` command generates daily to-do list
- Claims "10x faster" on writing tasks
- Quote: "Claude Code is only as good as what it knows about you"

### Obsidian + Claude Code Ecosystem

| Tool | Function |
|------|----------|
| **Claudian** | Embeds Claude Code inside Obsidian |
| **Claude Vault** | Auto-syncs Obsidian vault to git |
| **Smart Connect** | Semantic search indexing |
| **MCP Tools Plugin** | Exposes search tools via MCP |

### Comparison to Other Approaches

| Approach | Context Loading | Best For |
|----------|-----------------|----------|
| Single CLAUDE.md | All at once | Small projects |
| Granular Context Library | Selective, layered | Power users, businesses |
| AGENTS.md | Passive injection | Project documentation |
| Skills | On-demand invocation | Reusable workflows |
| Thickness Hierarchy | Layered by token cost | Token optimization |

---

## Thickness Hierarchy (Schultz Framework)

**Source:** [Joshua Schultz - Claude Code Complete Guide](https://joshuaschultz.com/ai/articles/claude-code-complete-guide/)

An architectural principle from operations consultant Joshua Schultz that organizes Claude Code components by token consumption, pushing work toward deterministic (zero-token) execution.

### The Hierarchy

```
┌─────────────────────────────────────────────────┐
│ THINNEST (lowest token cost)                    │
├─────────────────────────────────────────────────┤
│ Commands        → Orchestration only            │
│ Agents          → Strategic direction           │
│ Skills          → Detailed procedures           │
│ Scripts/YAML    → Zero-token deterministic      │
├─────────────────────────────────────────────────┤
│ THICKEST (highest token cost)                   │
└─────────────────────────────────────────────────┘
```

### Core Principle

> "Push as much work as possible to deterministic (non-token-using) parts."

### Verification Tools Pattern

Schultz advocates using external files as "mini-databases" that don't consume tokens:

| Tool Type | Purpose | Example |
|-----------|---------|---------|
| **YAML files** | Quality gates | Coverage thresholds, complexity limits |
| **Markdown templates** | Output formats | Exact structure enforcement |
| **Checklists** | Pass/fail validation | Binary completion criteria |

### Hooks as Guarantees

A key insight: hooks provide **guarantees** while instructions provide **suggestions**.

| Approach | Reliability | Token Cost |
|----------|-------------|------------|
| "Please format code before committing" | Low (may forget) | Tokens per reminder |
| PreToolUse hook running Prettier | 100% (automated) | Zero tokens |

### 10 Mastery Rules (Context-Relevant Subset)

From Schultz's comprehensive guide, these rules directly impact context management:

1. **Be specific, not vague** — Vague prompts waste tokens on clarification cycles
2. **Plan before coding** — explore → plan → code → commit reduces rework
3. **Clear context frequently** — Between unrelated tasks
4. **Let hooks handle formatting/style** — Don't waste context on style instructions
5. **Deploy subagents for verification** — Fresh context windows for focused tasks
6. **Reference files explicitly with paths** — Reduces Claude's search overhead
7. **Course-correct early via interrupts** — Don't let Claude wander consuming tokens
8. **Iterate on CLAUDE.md deliberately** — Test changes incrementally

### Six-Layer Architecture

Schultz's full architecture maps to context loading:

```
CLAUDE.md → Commands → Agents → Skills → Hooks → Plugins/MCP
   ↓           ↓          ↓        ↓        ↓          ↓
Always    On-demand   Delegated  Invoked  Automated  External
loaded    triggered   contexts   on-need  zero-token  services
```

### Non-Developer Application

Uniquely, Schultz applies this framework to business operations (marketing, financial analysis), demonstrating that context engineering principles extend beyond software development.

---

## Sub-Agent Strategy

### When to Use Sub-Agents

- Tasks that don't need main conversation context
- Heavy output operations (test runs, linting)
- Focused specialized tasks

### Examples

| Agent | Purpose | Context Needed |
|-------|---------|----------------|
| Code Reviewer | Review code quality | Minimal |
| Dev Server Manager | Start/stop servers | None |
| Test Runner | Execute test suites | Minimal |
| Documentation Generator | Generate docs | File contents only |

### Anti-Pattern Warning

From blog.sshh.io:
> "I reject custom subagents—they 'gatekeep context' and force rigid workflows. Prefer letting the main agent decide delegation via built-in `Task()` features."

---

## Hook-Based Automation

### Block-at-Submit Hooks
- Validate completion before commits
- Ensure tests pass before allowing action

### Hint Hooks
- Non-blocking feedback
- Suggestions without stopping workflow

### Context Management Hooks

**Forbid large outputs:**
```python
# Hook to prevent pytest output flooding context
# Blocks commands that generate large outputs
```

**Automated memory persistence (claude-mem):**
- Uses hooks to save memories automatically
- No prompting required
- Primary directive remains focused on task

---

## Community Tools

### claude-mem
- **Repository**: https://github.com/thedotmack/claude-mem
- **License**: AGPL-3.0
- **Purpose**: Automated context persistence via hooks

> "I made this because I was building a different project and kept hitting the context limit, then having to restart and re-teach Claude the entire architecture. Now Claude just... remembers."

### Context Graph Plugin
- Creates persistent graph of bug fixes and code decisions
- Grows over time
- Referenced automatically by hooks

### Context Forge
- PRPs (Prompt Resource Packages) integration
- Structured orchestration over long sessions

### clear-context Skill
- https://github.com/athola/claude-night-market
- Automatically manages context using subagents

---

## Optimization Tips

### Skills vs MCP Context

**Problem**: Raw MCP definitions consume significant context at session start.

**Solution**: Convert frequently-used MCPs to skills.

> "Skills are progressively discovered and don't consume context like mcp. Typically have 85% free context for a new session."

### Session Isolation

```bash
# Database-focused session
claude --session=database "Focus only on database schema"

# Frontend-focused session
claude --session=frontend "Work only on React components"

# API-focused session
claude --session=api "Handle only backend logic"
```

### Token Percentage Monitoring

**Quick Win**: Watch token percentage in Claude Code's status bar. When you hit 80%, exit and restart for complex multi-file work.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Performance degradation | Clear context, start new conversation |
| Lost architectural context | Update CLAUDE.md with key decisions |
| Repeated explanations | Use persistent memory files |
| Session recovery needed | Save progress summaries to dated markdown |
| Heavy MCP overhead | Convert to skills |

---

## Statistics & Benchmarks

| Metric | Value |
|--------|-------|
| Token reduction (context editing) | 84% |
| Performance improvement (editing + memory) | 39% |
| Free context with skills-based MCP | 85% |
| Baseline context in optimized monorepo | ~20K tokens (10%) |
| Available working context | 180K tokens (90%) |

---

## Summary: The Context Engineering Stack

```
┌─────────────────────────────────────────────────┐
│ 1. Foundation: CLAUDE.md files                  │
│    - Project conventions, architecture          │
│    - Personal preferences                       │
├─────────────────────────────────────────────────┤
│ 2. Session Management                           │
│    - /context monitoring                        │
│    - /clear at natural breakpoints              │
│    - /compact at 70% (with caution)             │
├─────────────────────────────────────────────────┤
│ 3. Automation Layer                             │
│    - Hooks for memory persistence               │
│    - Sub-agents for heavy operations            │
│    - Skills instead of raw MCP                  │
├─────────────────────────────────────────────────┤
│ 4. Recovery Patterns                            │
│    - Document & Clear workflow                  │
│    - Git as state checkpoint                    │
│    - Progress files for handoff                 │
└─────────────────────────────────────────────────┘
```

---

## Related Reports

- **[Claude 4 Best Practices](2026-02-02-claude-4-best-practices.md)** - Prompting techniques, model selection (complements this report)
- **[Get Shit Done (GSD)](2026-02-02-get-shit-done.md)** - Full framework that solves context rot via fresh subagent contexts
- **[Cole Medin's PIV Loop](2026-02-02-cole-medin-piv-loop.md)** - Methodology using CLAUDE.md and git as long-term memory
- **[everything-claude-code](2026-02-02-everything-claude-code.md)** - Comprehensive config collection including context management

---

## Sources

### Official
- [Anthropic Engineering: Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Claude Blog: Managing Context](https://claude.com/blog/context-management)

### Practitioner Guides
- [blog.sshh.io: How I Use Every Claude Code Feature](https://blog.sshh.io/p/how-i-use-every-claude-code-feature)
- [MCPCat: Managing Claude Code Context](https://mcpcat.io/guides/managing-claude-code-context/)
- [CometAPI: Managing Claude Code's Context Handbook](https://www.cometapi.com/managing-claude-codes-context/)
- [ClaudeFast: Context Management Mechanics](https://claudefa.st/blog/guide/mechanics/context-management)
- [ChatPRD: Granular Context Library for Lazy Prompting](https://www.chatprd.ai/how-i-ai/workflows/how-to-create-a-granular-context-library-for-lazy-prompting-with-ai)
- [Creator Economy: Automate Your Life with Claude Code (Teresa Torres)](https://creatoreconomy.so/p/automate-your-life-with-claude-code-teresa-torres)
- [Joshua Schultz: Claude Code Complete Guide](https://joshuaschultz.com/ai/articles/claude-code-complete-guide/) — Thickness Hierarchy framework

### Community
- [Reddit r/ClaudeCode: Context management plugin (claude-mem)](https://www.reddit.com/r/ClaudeCode/comments/1odoo3k/i_built_a_context_management_plugin_and_it/)
- [Reddit r/ClaudeCode: Tips - context management and task-based approach](https://www.reddit.com/r/ClaudeCode/comments/1pawyud/tips_after_using_claude_code_daily_context/)
- [Reddit r/ObsidianMD: Claude Code + Obsidian workflows](https://www.reddit.com/r/ObsidianMD/comments/1q50v3y/run_claude_code_from_the_sidebar_no_terminal/)
- [GitHub: claude-mem](https://github.com/thedotmack/claude-mem)
- [GitHub: claude-night-market clear-context skill](https://github.com/athola/claude-night-market)
