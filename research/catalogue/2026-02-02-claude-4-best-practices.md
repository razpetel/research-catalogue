# Claude 4 Best Practices

> Official Anthropic documentation and community-validated techniques for prompting Claude 4.x models (Opus 4.5, Sonnet 4.5, Haiku 4.5)

**Research Date:** 2026-02-02
**Source:** [Anthropic Platform Docs](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)
**Category:** AI/LLM Prompting
**Sentiment:** Authoritative (Official Documentation)

---

## Key Insights

1. **Claude 4.x requires explicit instructions** - Unlike previous models that went "above and beyond," Claude 4.x follows instructions precisely. Request extra features explicitly: "Include as many relevant features as possible. Go beyond the basics."

2. **Context explains "why," not just "what"** - Adding motivation improves results. Instead of "NEVER use ellipses," say "Your response will be read by text-to-speech, so never use ellipses since the engine won't pronounce them."

3. **Opus for planning, Sonnet for execution** - Community consensus: use Opus 4.5 for architectural decisions and complex reasoning, Sonnet 4.5 for faster implementation. Many run `/model opusplan` workflow.

4. **State management is critical for long tasks** - Use structured JSON for tests/status, freeform text for progress notes, and git for checkpoints across sessions.

5. **Five proven prompting techniques** - XML tags, extended thinking, explicit instructions, few-shot examples, and context placement consistently deliver results.

6. **Let Claude drive requirements gathering** - Use the Ask Questions tool explicitly: *"Use the Ask Questions Tool as much as needed until you have full clarity."* The ball goes to Claude's court; you mostly respond.

---

## General Principles

### Be Explicit With Instructions

Claude 4.x models respond well to clear, explicit instructions. The "above and beyond" behavior from previous models must now be explicitly requested.

**Less effective:**
```
Create an analytics dashboard
```

**More effective:**
```
Create an analytics dashboard. Include as many relevant features and interactions
as possible. Go beyond the basics to create a fully-featured implementation.
```

### Add Context to Improve Performance

Providing motivation behind instructions helps Claude understand goals:

**Less effective:**
```
NEVER use ellipses
```

**More effective:**
```
Your response will be read aloud by a text-to-speech engine, so never use
ellipses since the text-to-speech engine will not know how to pronounce them.
```

### Long-Horizon Reasoning

Claude 4.5 excels at tasks spanning multiple context windows:

1. **First context window** - Set up framework (tests, setup scripts)
2. **Write tests in structured format** - e.g., `tests.json`
3. **Create setup scripts** - e.g., `init.sh` for graceful restarts
4. **Use git for state tracking** - Log of what's done + checkpoints

**State Management Example:**
```json
// tests.json
{
  "tests": [
    {"id": 1, "name": "authentication_flow", "status": "passing"},
    {"id": 2, "name": "user_management", "status": "failing"}
  ],
  "total": 200, "passing": 150, "failing": 25
}
```

```text
// progress.txt
Session 3 progress:
- Fixed authentication token validation
- Next: investigate user_management test failures (test #2)
- Note: Do not remove tests
```

---

## Communication Style Changes

Claude 4.5 models communicate differently:

| Aspect | Behavior |
|--------|----------|
| Directness | More fact-based, less self-celebratory |
| Verbosity | May skip summaries for efficiency |
| Tone | More conversational, less machine-like |

**To get progress updates:**
```
After completing a task that involves tool use, provide a quick summary
of the work you've done.
```

---

## Tool Usage Patterns

### Explicit Action Required

Claude 4.x follows instructions precisely. "Suggest" means suggest, not implement.

**Less effective (Claude will only suggest):**
```
Can you suggest some changes to improve this function?
```

**More effective (Claude will make changes):**
```
Make these edits to the authentication flow.
```

### Proactive vs Conservative Action

**For proactive behavior:**
```xml
<default_to_action>
By default, implement changes rather than only suggesting them. If the user's
intent is unclear, infer the most useful likely action and proceed, using tools
to discover any missing details instead of guessing.
</default_to_action>
```

**For conservative behavior:**
```xml
<do_not_act_before_instructions>
Do not jump into implementation unless clearly instructed. Default to providing
information and recommendations rather than taking action.
</do_not_act_before_instructions>
```

### Parallel Tool Calling

Sonnet 4.5 aggressively fires multiple operations simultaneously. This is steerable:

**Maximum parallelism:**
```xml
<use_parallel_tool_calls>
If you intend to call multiple tools and there are no dependencies between them,
make all independent calls in parallel. Never use placeholders or guess parameters.
</use_parallel_tool_calls>
```

**Reduce parallelism:**
```
Execute operations sequentially with brief pauses between each step.
```

---

## Requirements Gathering

### Ask Questions Tool Pattern

Claude Code has a built-in `AskUserQuestion` tool that can ask up to 4 questions at a time. Explicitly prompting Claude to use it shifts the dynamic—Claude drives requirements gathering, you respond.

**Prompt to enable:**
```
Use the Ask Questions Tool as much as needed until you have full clarity
about what we're building. Keep asking until all requirements are clear.
```

**Benefits:**
- Ball goes to Claude's court—you mostly respond
- Forces structured requirements extraction
- Reduces back-and-forth ambiguity
- Claude asks "sensible designer questions" you might not think to specify

**Note:** The tool can only ask up to 4 questions per invocation, so instruct Claude to run it multiple times if needed.

### Plannotator Plugin

Visual plan review and annotation tool for Claude Code plans.

**Features:**
- Mark sections for deletion, add comments, suggest replacements
- Visual UI for annotating verbose plans before execution
- Share plans with team for collaborative feedback
- Auto-save approved plans to Obsidian/Bear Notes
- Annotations convert to structured feedback sent to Claude

**Installation:**
```bash
curl -fsSL https://plannotator.ai/install.sh | bash
```

Then in Claude Code:
```
/plugin marketplace add backnotprop/plannotator
/plugin install plannotator@plannotator
```

**Repository:** [github.com/backnotprop/plannotator](https://github.com/backnotprop/plannotator)

**Workflow:**
1. Claude completes planning phase
2. Plannotator UI launches in browser
3. Annotate and refine the plan visually
4. Approve → Claude proceeds to implementation
5. Or request changes → annotations sent as structured feedback

---

## Research and Information Gathering

Claude 4.5 excels at agentic search:

```
Search for this information in a structured way. As you gather data, develop
several competing hypotheses. Track your confidence levels in your progress
notes to improve calibration. Regularly self-critique your approach and plan.
Update a hypothesis tree or research notes file.
```

---

## Subagent Orchestration

Claude 4.5 has native subagent capabilities - it recognizes when tasks benefit from delegation without explicit instruction.

**To be more conservative:**
```
Only delegate to subagents when the task clearly benefits from a separate
agent with a new context window.
```

---

## Frontend Design

Avoid "AI slop" aesthetic:

```xml
<frontend_aesthetics>
Focus on:
- Typography: Choose distinctive fonts, avoid Arial, Inter, Roboto
- Color & Theme: Commit to cohesive aesthetic, use CSS variables
- Motion: Prioritize CSS-only solutions, one well-orchestrated page load
- Backgrounds: Create atmosphere and depth, not solid colors

Avoid: Overused fonts, purple gradients on white, cookie-cutter patterns
</frontend_aesthetics>
```

---

## Minimizing Hallucinations

```xml
<investigate_before_answering>
Never speculate about code you have not opened. If the user references a
specific file, you MUST read the file before answering. Give grounded and
hallucination-free answers.
</investigate_before_answering>
```

---

## Avoiding Over-Engineering

```
Avoid over-engineering. Only make changes that are directly requested or
clearly necessary. Keep solutions simple and focused.

Don't add features, refactor code, or make "improvements" beyond what was asked.
Don't add error handling for scenarios that can't happen.
Don't create helpers or abstractions for one-time operations.
```

---

## Code Exploration

```
ALWAYS read and understand relevant files before proposing code edits.
Do not speculate about code you have not inspected. Be rigorous and persistent
in searching code for key facts.
```

---

## Context Awareness

Claude 4.5 tracks its remaining context window. For tools that compact context:

```
Your context window will be automatically compacted as it approaches its limit.
Do not stop tasks early due to token budget concerns. Save progress and state
to memory before the context window refreshes. Be as persistent and autonomous
as possible.
```

---

## Extended Thinking

```
After receiving tool results, carefully reflect on their quality and determine
optimal next steps before proceeding. Use your thinking to plan and iterate
based on this new information.
```

**Note:** Avoid the word "think" when extended thinking is disabled - use "consider," "believe," or "evaluate" instead.

---

## Model Selection Guide

| Use Case | Recommended Model |
|----------|-------------------|
| Planning, architecture | Opus 4.5 |
| Implementation, execution | Sonnet 4.5 |
| Quick tasks, cost-sensitive | Haiku 4.5 |
| Complex reasoning | Opus 4.5 |
| High-volume processing | Sonnet 4.5 |

**Community Pattern:** "Plan with Opus, execute with Sonnet"

---

## Quick Reference: Five Proven Techniques

1. **XML Tags** - Claude was trained on XML-tagged prompts
2. **Extended Thinking** - Encourage step-by-step reasoning
3. **Explicit Instructions** - Be specific about desired behavior
4. **Few-Shot Examples** - 3-5 examples with `<example>` tags
5. **Context Placement** - Put user queries close to bottom of prompt

---

## Statistics

- Claude Code processes **195 million lines of code weekly**
- **115,000 developers** using Claude Code
- Opus 4.5 delivers flagship performance at **67% lower cost** than predecessor

---

## Sources

- [Anthropic Platform Docs - Claude 4 Best Practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)
- [Claude Blog - Prompt Engineering Best Practices](https://claude.com/blog/best-practices-for-prompt-engineering)
- [DreamHost - 25 Claude Prompt Techniques Tested](https://www.dreamhost.com/blog/claude-prompt-engineering-guide/)
- [Reddit r/ClaudeAI](https://www.reddit.com/r/ClaudeAI/) - Community discussions
- [Reddit r/ClaudeCode](https://www.reddit.com/r/ClaudeCode/) - Developer workflows
- [GitHub claude-prompt-engineering-guide](https://github.com/ThamJiaHe/claude-prompt-engineering-guide)
- [WIRED - How Claude Code Is Reshaping Software](https://www.wired.com/story/claude-code-success-anthropic-business-model/)
