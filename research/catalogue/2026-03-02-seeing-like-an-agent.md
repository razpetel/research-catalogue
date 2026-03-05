---
topic: "Seeing like an Agent: Lessons from Building Claude Code"
slug: seeing-like-an-agent
date: 2026-03-02
sources: [twitter, github, reddit, web, linkedin]
---

# Seeing like an Agent: Lessons from Building Claude Code

## Overview

"Lessons from Building Claude Code: Seeing like an Agent" is a viral Twitter/X thread by Thariq Shihipar (@trq212), a Claude Code engineer at Anthropic, posted on approximately February 28, 2026. The thread has accumulated 197 replies, 1.2K reposts, 9.3K likes, and 3.3M views, making it one of the most-engaged-with pieces of agent architecture writing in 2026.

The central thesis is a design philosophy for agent tool construction: rather than building tools based on what *you* think the agent needs, you must learn to "see like an agent" -- observing model outputs, identifying struggle points, and shaping tools to match the model's actual capabilities. This is framed as "as much an art as it is a science," requiring iterative experimentation over formulaic approaches.

The thread is the second installment in Thariq's "Lessons from Building Claude Code" series, following "Prompt Caching Is Everything" (February 19, 2026, 4.6K likes, 1.7M views). Together they form the most detailed public documentation of Claude Code's internal architecture decisions from an Anthropic engineer.

Thariq Shihipar is an engineer and serial entrepreneur (YC W20, MIT Media Lab) who previously founded Multiverse (gaming, $17MM raised), co-founded Chime (acquired by HubSpot), and co-founded PubPub.org (academic publishing non-profit). He currently leads development work on Claude Code at Anthropic.

## Technical Analysis

### Core Framework: Designing the Action Space

The thread opens with the assertion: "One of the hardest parts of building an agent harness is constructing its action space." Thariq uses a math problem analogy -- a student solving a hard problem needs different tools depending on their skill level (paper, calculator, or code execution). Similarly, agents need tools matched to their actual capabilities, not what engineers assume they need.

The guiding question: "How do you know what those abilities are? You pay attention, read its outputs, experiment. You learn to see like an agent."

### Lesson 1: Elicitation and the AskUserQuestion Tool

The team iterated through three approaches to improve Claude's ability to ask clarifying questions (elicitation):

| Attempt | Approach | Outcome |
|---------|----------|---------|
| 1 | Added `questions` parameter to ExitPlanTool | Failed -- Claude received conflicting signals about whether to prioritize the plan or the questions |
| 2 | Modified system instructions for markdown-formatted questions | Unreliable -- Claude would "append extra sentences, omit options, or use a different format altogether" |
| 3 | Dedicated AskUserQuestion tool with modal UI | Succeeded -- structured output via a tool that blocks the agent loop until user responds |

The key insight: "Claude seemed to like calling this tool." Rather than fighting the model's tendencies, they shaped the tool to match how Claude naturally wanted to interact. The tool was particularly prompted during plan mode and displayed a modal that blocked execution until the user answered, providing structured output with multiple options.

### Lesson 2: TodoWrite to Task Tool Evolution

When Claude Code launched, it included a TodoWrite tool for planning. The model frequently forgot its objectives, so the team inserted system reminders every 5 turns. This worked initially but became counterproductive as models improved:

- **Problem with reminders:** "Being sent reminders of the todo list made Claude think that it had to stick to the list instead of modifying it."
- **Model capability growth:** Opus 4.5 no longer needed the scaffolding and found it constraining.
- **Multi-agent coordination:** How could subagents coordinate on a shared Todo List?

The solution was replacing TodoWrite with the **Task Tool**, which fundamentally shifted the paradigm from task tracking to agent communication. Tasks could include dependencies, share updates across subagents, and be altered and deleted by the model.

**Key principle:** "As model capabilities increase, the tools that your models once needed might now be constraining them. It's important to constantly revisit previous assumptions on what tools are needed."

This is also why the team sticks to "a small set of models to support that have a fairly similar capabilities profile" -- it makes it tractable to observe and adapt to capability changes.

### Lesson 3: Progressive Disclosure Over Prompt Bloat

Rather than cramming all information into system prompts, the team evolved toward progressive disclosure -- incrementally revealing context through multi-layer exploration:

**Search tool evolution:**
1. **RAG vector database** (initial) -- "While RAG was powerful and fast, it required indexing and setup and could be fragile across a host of different environments."
2. **Grep tool** -- "By giving Claude a Grep tool, we could let it search for files and build context itself. This is a pattern we've seen as Claude gets smarter -- it becomes increasingly good at building its context if it's given the right tools."
3. **Agent Skills** -- Formalized progressive disclosure via skill files that reference other searchable resources. Claude performs "nested search across several layers of files" to locate exact information.

**Claude Code Guide subagent:** Instead of documenting all self-knowledge in the main prompt, Claude Code delegates documentation queries to a specialized subagent with "extensive instructions on how to search docs well and what to return."

This aligns with Apple's CodeAct research (ICML 2024), which independently found that "a single code execution primitive outperformed sprawling specialised toolkits by up to 20% on complex tasks."

### Companion Architecture: Prompt Caching

The companion thread ("Prompt Caching Is Everything") reveals that Claude Code's entire harness is designed around prompt caching:

- **Prefix matching:** Any change anywhere in the prefix invalidates everything after it.
- **Layered content ordering:** System prompt and tools (globally cached) > project docs > session context > conversation messages.
- **Tools as permanent fixtures:** Never add or remove tools mid-conversation. State transitions (e.g., EnterPlanMode, ExitPlanMode) are modeled as tools themselves.
- **Deferred tool loading:** Lightweight stubs with `defer_loading: true` instead of removing tools.
- **Cache hits as infrastructure:** Claude Code treats cache hit rates as critical metrics, setting alerts and declaring incidents on drops.

### Underlying Architecture (Reverse-Engineered)

Based on public documentation and community reverse-engineering, Claude Code operates on a **TAOR (Think-Act-Observe-Repeat)** loop with approximately 50 lines of loop logic. The runtime is deliberately "dumb" so intelligence resides in the model and prompt structure.

**Capability primitives:** Read, Write, Execute (Bash), Connect (MCP). Bash acts as the universal adapter -- composable, discoverable, and leveraging existing software (ffmpeg, jq, git, etc.) without custom tools.

**Memory architecture (6 layers):** Organization policies > Project configuration > User preferences > Auto-learned patterns (MEMORY.md) > Session state > Real-time observations.

**Permission model:** 5-tier spectrum from `plan` (read-only) through `bypassPermissions` (managed orgs).

## User Sentiment

**Overall:** Overwhelmingly positive, with high engagement metrics (9.3K likes, 3.3M views) indicating strong resonance with the developer community.

### Twitter/X
- The thread is Thariq's highest-engagement post, surpassing the prompt caching thread (4.6K likes) by 2x.
- 197 replies indicate substantial discussion and debate.
- The "Lessons from Building Claude Code" series has established Thariq as a leading public voice on agent architecture.

### Reddit
- r/ClaudeAI and r/ClaudeCode communities actively reference Thariq's insights on tool design, with multiple threads discussing the Task Tool evolution and subagent architecture.
- The Task Tool is described as "Claude Code's most powerful underutilized/under explored tool" (r/ClaudeAI).
- Users report positive experiences with subagents, noting "subagents have their own context window and a narrower focus, helping to streamline the analyzing of the data."
- Community reverse-engineering efforts (vrungta.substack.com, deepwiki.com, paddo.dev) validate the architecture described in the thread.

### Hacker News
- The post was submitted to Hacker News (item ID 47196269) but appears to be a very recent submission with limited discussion so far.

### LinkedIn
- No direct viral LinkedIn post about "Seeing like an Agent" was found, but multiple LinkedIn posts reference Claude Code's agent architecture, agent teams, and subagent design patterns. Several posts from prominent AI educators (Andrew Ng, Omar Santos) discuss Claude Code's agentic capabilities extensively.
- A LinkedIn Pulse article ("Building Deep Agents: Lessons from Claude Code and Others") identifies rich system prompts, planning tools, sub-agents, and file system integration as the four components distinguishing "deep agents."

### Developer Blog Coverage
- **anup.io** published a detailed analysis ("How the Claude Code team designs agent tools") synthesizing the thread with Anthropic's "Building Effective Agents" guide.
- **techtwitter.com** archived the complete thread text for reference.

## Competitive Landscape

The "Seeing like an Agent" philosophy positions Claude Code's design approach distinctly among coding agents:

| Platform | Design Philosophy | Tool Approach |
|----------|-------------------|---------------|
| **Claude Code** | "See like an agent" -- match tools to model capabilities, iterate via observation | Minimal primitives (Bash as universal adapter), progressive disclosure, co-evolve tools with model |
| **Cursor** | AI-first editor with agent modes | IDE-integrated, sprawling tool menus, autonomous exploration |
| **GitHub Copilot** | Tight GitHub integration | Multi-step workflows within IDE, focus on completion |
| **Devin** | Fully autonomous engineering | End-to-end task execution, plans and executes independently |
| **Windsurf** | Speed-first | Fast decisions, efficient for well-defined tasks |
| **OpenCode/Gemini CLI** | Open-source alternatives | Replicate Claude Code patterns with different model backends |

### Related Foundational Work
- **Anthropic's "Building Effective Agents" guide** (December 2024): Recommends simple, composable patterns over complex frameworks. The "Seeing like an Agent" thread extends this with concrete implementation examples.
- **CodeAct (ICML 2024):** Research validating that single code execution primitives outperform specialized toolkits -- aligns with Claude Code's Bash-as-universal-adapter philosophy.
- **Thariq's "Prompt Caching Is Everything"** (February 2026): Companion piece covering the caching infrastructure that makes the agent architecture feasible.

## Pros and Cons

| Pros | Cons |
|------|------|
| Rare first-party insight into production agent architecture decisions | Thread format limits depth -- some lessons could use longer-form treatment |
| Concrete, iterative examples (AskUserQuestion 3 iterations, TodoWrite to Task Tool) | Anthropic-specific -- some lessons may not transfer to other model families |
| Actionable design principle: "tools that models once needed might now be constraining them" | No benchmarks or quantitative comparisons provided |
| Progressive disclosure pattern is widely applicable beyond Claude Code | Limited discussion of failure modes and edge cases |
| Validates industry trend toward fewer, more composable tools (CodeAct alignment) | The "art not science" framing may frustrate engineers seeking prescriptive rules |
| Part of an emerging series with deep institutional knowledge | Only covers tool design -- does not address safety, evaluation, or deployment |
| Extremely high engagement (3.3M views) suggests broad relevance | Twitter/X format inherently lossy -- no formal paper or blog post version |

## Sources

1. [Thariq (@trq212) - "Lessons from Building Claude Code: Seeing like an Agent" (X/Twitter)](https://x.com/trq212/status/2027463795355095314)
2. [TechTwitter - Full thread archive](https://www.techtwitter.com/articles/lessons-from-building-claude-code-seeing-like-an-agent)
3. [Anup.io - "How the Claude Code team designs agent tools"](https://www.anup.io/how-the-claude-code-team-designs-agent-tools/)
4. [Thariq (@trq212) - "Lessons from Building Claude Code: Prompt Caching Is Everything" (X/Twitter)](https://x.com/trq212/status/2024574133011673516)
5. [TechTwitter - Prompt Caching thread archive](https://www.techtwitter.com/articles/lessons-from-building-claude-code-prompt-caching-is-everything)
6. [Hacker News submission](https://news.ycombinator.com/item?id=47196269)
7. [vrungta.substack.com - "Claude Code Architecture (Reverse Engineered)"](https://vrungta.substack.com/p/claude-code-architecture-reverse)
8. [Thariq.io - Personal site](https://www.thariq.io/)
9. [ThariqS GitHub profile](https://github.com/ThariqS)
10. [Anthropic - "Building Effective Agents"](https://www.anthropic.com/research/building-effective-agents)
11. [CodeAct - "Executable Code Actions Elicit Better LLM Agents" (ICML 2024)](https://github.com/xingyaoww/code-act)
12. [r/AI_Agents - "About Claude Code's Task Tool (SubAgent Design)"](https://www.reddit.com/r/AI_Agents/comments/1lrdz4p/about_claude_codes_task_tool_subagent_design/)
13. [r/ClaudeAI - "Continuously impressed by Claude Code -- Sub-agents (Tasks) Are Insane"](https://www.reddit.com/r/ClaudeAI/comments/1li5i01/continuously_impressed_by_claude_code_subagents/)
14. [LinkedIn Pulse - "Building Deep Agents: Lessons from Claude Code and Others"](https://www.linkedin.com/pulse/building-deep-agents-lessons-from-claude-code-others-onkyai-rmd8f)
15. [DeepWiki - Claude Code System Architecture](https://deepwiki.com/anthropics/claude-code/1.1-system-architecture)
16. [Podwise - Claude Agent SDK Workshop with Thariq Shihipar](https://podwise.ai/dashboard/episodes/6711459)
