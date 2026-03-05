---
topic: Beads Viewer
slug: beads-viewer
date: 2026-03-02
sources:
  - https://github.com/Dicklesworthstone/beads_viewer
  - https://github.com/mgalpert/beads-viewer
  - https://github.com/steveyegge/beads
  - https://github.com/steveyegge/beads/blob/main/docs/COMMUNITY_TOOLS.md
  - https://github.com/Dicklesworthstone/beads_viewer_rust
  - https://github.com/vanderheijden86/b9s
  - https://github.com/zhrkvl/BeadsViewer
  - https://github.com/kennyg/homebrew-beads_viewer
  - https://formulae.brew.sh/formula/beads_viewer
  - https://ianbull.com/posts/beads/
  - https://jeffreyemanuel.com/projects/beads-viewer
  - https://skills.rest/skill/beads-viewer
  - https://ralph-tui.com/docs/plugins/trackers/beads-bv
  - https://x.com/Steve_Yegge/status/1993919120170209498
  - https://x.com/doodlestein/status/2001682985343418795
  - https://x.com/Dimillian/status/1994799113192288448
  - https://www.reddit.com/r/vibecoding/comments/1p9tnm3/is_beads_worth_a_try/
  - https://www.reddit.com/r/vibecodeprod/comments/1p85au9/
  - https://www.reddit.com/r/ClaudeCode/comments/1qgkupf/
  - https://pkg.go.dev/github.com/Dicklesworthstone/beads_viewer/pkg/agents
---

# Beads Viewer

## Overview

"Beads Viewer" is a family of community-built visualization and management tools for **Beads** (`bd`), Steve Yegge's distributed, git-backed graph issue tracker designed for AI coding agents. The Beads ecosystem (17,848 GitHub stars, 1,108 forks on the core repo) has spawned dozens of viewers across terminal, web, desktop, and editor modalities. The term "beads-viewer" most commonly refers to two projects:

1. **beads_viewer (bv)** by Jeffrey Emanuel (@Dicklesworthstone) -- a Go-based, graph-aware TUI that is the most feature-rich and widely adopted Beads viewer (1,338 stars, 101 forks). It provides PageRank-based task prioritization, critical-path analysis, kanban boards, dependency DAG visualization, and a robot-mode JSON API purpose-built for AI agent consumption.

2. **beads-viewer** by mgalpert -- a React/TypeScript web interface (23 stars) with kanban board, interactive dependency graph, real-time WebSocket collaboration, and CLI integration via shell-outs to `bd`.

Both tools solve the same core problem: giving humans (and agents) a visual, interactive way to manage Beads task data that otherwise lives in SQLite databases and JSONL files within git repos.

### The Parent: Beads (`bd`)

Beads is a persistent, structured memory system for AI coding agents that replaces markdown-based planning with a dependency-aware task graph. It uses Dolt (a version-controlled SQL database) for storage, supports hierarchical IDs for epics/tasks/subtasks, and is designed for multi-agent/multi-branch collaboration. Beads has become a de facto standard in the "vibe coding" / agentic development community, with Steve Yegge (formerly of Google, Amazon, and Grab) as its creator.

### Why Viewers Exist

Beads data is inherently graph-structured (tasks have blocking dependencies, parent-child relationships, and cross-references). While the `bd` CLI provides JSON output for scripting, developers and agents need richer interfaces to understand project topology, identify bottlenecks, and plan work efficiently. This need has produced a thriving ecosystem documented in the official [COMMUNITY_TOOLS.md](https://github.com/steveyegge/beads/blob/main/docs/COMMUNITY_TOOLS.md).

## Technical Analysis

### beads_viewer (bv) -- The TUI (Dicklesworthstone)

**Language/Stack:** Go, Bubble Tea (Charm libraries) for TUI rendering at 60fps.

**Version:** v0.14.4 (stable, available via Homebrew).

**Created:** November 26, 2025. Last pushed: March 2, 2026 (actively maintained).

**Installation:**
```bash
brew install beads_viewer            # Homebrew (official formula)
go install github.com/Dicklesworthstone/beads_viewer@latest  # Go
# Pre-built binaries for macOS, Linux, Windows via GitHub Releases
```

**Core Feature Set:**

| Feature | Description |
|---------|-------------|
| Split-view dashboard | Fast scrollable list + rich Markdown detail pane |
| Kanban board | Columnar flow view with drag semantics |
| Dependency graph explorer | Interactive DAG visualization |
| Tree view | Hierarchical epic/task/subtask navigation |
| History timeline | Correlates git commits to task state changes |
| Time-travel diffing | Compare task state across git revisions (`--as-of`) |
| Fuzzy search | Zero-latency filtering across all fields |
| Export | Markdown with Mermaid diagrams, HTML interactive graphs |

**Graph Analytics (9 Metrics):**
1. **PageRank** -- Recursive dependency authority ranking
2. **Betweenness Centrality** -- Bottleneck/bridge detection
3. **HITS (Hub/Authority)** -- Identifies epics (hubs) vs. utility tasks (authorities)
4. **Critical Path** -- Longest dependency chain revealing project keystones
5. **Eigenvector Centrality** -- Influence through important neighbors
6. **Degree Centrality** -- Direct connection counts
7. **Density** -- Edge-to-node coupling health metric
8. **Cycle Detection** -- Identifies circular dependencies
9. **Topological Sort** -- Valid execution ordering

Phase 1 metrics (degree, topo sort, density) compute instantly. Phase 2 metrics (PageRank, betweenness, HITS, eigenvector, cycles) run asynchronously with a 500ms timeout.

**Robot Mode (AI Agent Interface):**

This is the differentiating feature. Robot mode outputs structured JSON designed for LLM consumption, avoiding the interactive TUI that would block agent sessions:

```bash
bv --robot-triage     # Comprehensive project snapshot with recommendations
bv --robot-next       # Single top-priority pick + claim command
bv --robot-plan       # Parallel execution tracks with unblock info
bv --robot-insights   # All 9 graph metrics
bv --robot-diff       # Change tracking since a git reference
bv --robot-graph      # Export as JSON, DOT, or Mermaid
```

The `--robot-triage` mega-command returns: quick reference counts, ranked actionable recommendations with scores, quick-win suggestions, blocker-clearing priorities, project health distributions, and copy-paste shell commands.

Token optimization is available via `--format toon` for compressed output.

**Agents Integration:** The codebase includes a `pkg/agents` package that auto-injects beads_viewer usage instructions into AGENTS.md files, enabling seamless adoption in agentic coding workflows.

**Dolt Compatibility Note:** As of the latest COMMUNITY_TOOLS.md (March 2026), beads_viewer is listed under "Historical / Stale" because Beads migrated from JSONL to Dolt in v0.50+. Issue #121 tracks Dolt compatibility. However, the repo remains actively maintained (pushed March 2, 2026), and the Homebrew formula was updated to v0.14.4, suggesting work is ongoing to address this.

**Rust Port (bvr):** Jeffrey Emanuel released `beads_viewer_rust` on February 28, 2026, promising full legacy parity with conformance testing.

### beads-viewer -- The Web UI (mgalpert)

**Language/Stack:** React 18, TypeScript 5.6, Vite 5.4, Tailwind CSS, Zustand, TanStack Table, React Flow, Express backend, Bun runtime.

**Created:** October 16, 2025. Smaller scope but clean architecture.

**Architecture:**
```
React Frontend (5173) <--HTTP/WS--> Express Server (3001) <--shell exec--> bd CLI (Go) --> SQLite + JSONL
```

**Features:**
- Kanban board with drag-and-drop (via @dnd-kit)
- Interactive dependency graph (via React Flow)
- Sortable issue list (via TanStack Table)
- "Ready Work" smart view (unblocked, actionable issues)
- Real-time WebSocket sync across clients
- Optimistic updates with Zustand rollback
- File watcher for external CLI changes

**Limitations:** Built for Beads CLI v0.9.6. Fewer advanced analytics than bv. No robot mode for agents. Appears less actively maintained (last push October 2025).

### Other Notable Viewers

| Project | Type | Stars | Key Differentiator |
|---------|------|-------|--------------------|
| [b9s](https://github.com/vanderheijden86/b9s) | TUI (Go) | 2 | Forked from bv, inspired by k9s; adds tree-view editing and project switcher |
| [BeadsViewer](https://github.com/zhrkvl/BeadsViewer) | IntelliJ plugin | -- | IDE-native experience for JetBrains users |
| [Mardi Gras](https://github.com/quietpublish/mardi-gras) | TUI (Go) | -- | Real-time updates, Gas Town agent orchestration, tmux integration |
| [bdui](https://github.com/assimelha/bdui) | TUI (Node.js) | -- | Real-time tree view with dependency graph |
| [perles](https://github.com/zjrosen/perles) | TUI (Go) | -- | Custom BQL (Beads Query Language) for filtering |
| [lazybeads](https://github.com/codegangsta/lazybeads) | TUI (Go) | -- | Lightweight Bubble Tea browser |
| [beads-ui](https://github.com/mantoni/beads-ui) | Web (Node.js) | -- | `npx beads-ui start` one-liner, Dolt compatible |
| [Beadbox](https://github.com/beadbox/beadbox) | macOS (Tauri) | -- | Native desktop with real-time sync |
| [Foolery](https://github.com/acartine/foolery) | Web (Next.js) | -- | Agent orchestration control surface |

The COMMUNITY_TOOLS.md page lists 30+ tools across TUIs, web UIs, editor extensions, native apps, SDKs, and orchestration layers.

### Integration Points

- **Ralph TUI:** The [Beads-BV tracker plugin](https://ralph-tui.com/docs/plugins/trackers/beads-bv) integrates beads_viewer's analytics into Ralph TUI's agent management workflow.
- **SuperBeads/Superpowers:** Jeffrey Emanuel's beads_viewer has been integrated into the SuperBeads Wiggum framework to work seamlessly with both Beads and Superpowers (per Reddit r/ClaudeCode discussion).
- **Claude Skills:** A [beads-viewer skill](https://skills.rest/skill/beads-viewer) on skills.rest wraps bv's graph analytics for Claude Code agents.
- **Homebrew:** Official formula at `brew install beads_viewer` with 145 installs/month.

## User Sentiment

### Positive

- **Steve Yegge** (Beads creator) endorsed bv on X: "This is the first UI for Beads that I could see myself using. Pretty clever. And it's a Terminal UI!" -- a strong signal given the dozens of alternatives available.
- **Jeffrey Emanuel** (bv author) reports agents use it "constantly as a kind of compass directing them on what to work on next," calling it one of his most useful tools despite being built in a single day.
- **Thomas Ricouard** (well-known iOS developer) built an "open in Cursor" button into his beads viewer workflow, pre-filling agent prompts with task context.
- **Ian Bull** (blog post) called bv "perhaps the most sophisticated" terminal UI option.
- **Reddit r/vibecoding:** Users exploring Beads specifically called out beads_viewer as a compelling TUI to complement the CLI.
- **Reddit r/ClaudeCode:** The Superpowers integration thread confirmed bv works seamlessly in multi-agent frameworks.

### Concerns and Criticisms

- **Dolt migration breakage:** The biggest concern is that bv may not work with Beads v0.50+ (Dolt-based storage). The official COMMUNITY_TOOLS.md now lists it under "Historical / Stale" with a link to issue #121. This is a significant compatibility risk.
- **Agent-only value proposition:** Some users question whether the graph analytics are useful for human developers or primarily benefit AI agents, making it a niche tool.
- **Ecosystem fragmentation:** With 30+ viewers, users face decision fatigue choosing which one to adopt. No single tool has consolidated community consensus.
- **Learning curve:** The robot-mode flags and 9 graph metrics require understanding to use effectively.

### Community Activity

The beads_viewer repo has 124 issues/PRs (all closed, 0 open as of March 2026), suggesting active triage. Contributors have submitted PRs for SQLite compatibility and beads-rs support. The Homebrew formula maintains 145 monthly installs, indicating modest but steady adoption.

## Competitive Landscape

### Direct Competitors (Beads-Specific Viewers)

| Tool | Approach | Dolt Compat | Agent Mode | Analytics | Maturity |
|------|----------|-------------|------------|-----------|----------|
| **bv (beads_viewer)** | Go TUI | Issue #121 | Yes (robot flags) | 9 graph metrics | High (v0.14.4) |
| **beads-viewer (mgalpert)** | React Web | Via bd CLI | No | Basic dependency graph | Medium |
| **Mardi Gras** | Go TUI | Yes (bd --json) | Yes | Basic | Medium |
| **bdui** | Node.js TUI | Unknown | No | Dependency graph | Low |
| **perles** | Go TUI | Unknown | No | BQL queries | Low |
| **beads-ui** | Node.js Web | Yes (bd CLI) | No | Kanban only | Medium |
| **Foolery** | Next.js Web | Unknown | Yes (orchestration) | Wave planning | Medium |
| **Beadbox** | Tauri macOS | Unknown | No | Progress bars | Medium |

### Indirect Competitors (General Issue Trackers)

Beads itself competes with GitHub Issues, Linear, Jira, and Shortcut. Beads viewers thus indirectly compete with those platforms' native UIs. The key differentiation is that Beads viewers are purpose-built for **AI agent workflows** with structured JSON output, dependency-aware prioritization, and git-native storage -- none of which traditional issue trackers optimize for.

### Positioning

beads_viewer (bv) occupies a unique niche: it is the only Beads viewer with deep graph analytics (PageRank, HITS, critical path) and a structured robot-mode protocol for AI agents. No other tool in the ecosystem provides this level of analytical sophistication for task prioritization.

However, its position is threatened by the Dolt migration. Tools that use `bd list --json` (like Mardi Gras and beads-ui) are inherently more future-proof than tools that read JSONL directly.

## Pros and Cons

### beads_viewer (bv) -- The TUI

| Pros | Cons |
|------|------|
| Most feature-rich Beads viewer with 9 graph analytics | Dolt compatibility uncertain (listed as "stale" in official docs) |
| Robot-mode JSON API purpose-built for AI agents | Go binary adds a dependency vs. bd-CLI-only tools |
| Steve Yegge endorsement and strong community reception | 30+ competitor viewers fragment adoption |
| Homebrew formula for easy installation | Learning curve for robot-mode flags and graph metrics |
| Active development (pushed March 2, 2026) | Token cost of verbose robot-mode output |
| 1,338 GitHub stars demonstrate real traction | Single maintainer risk (Jeffrey Emanuel) |
| Vim-style keyboard navigation familiar to developers | TUI paradigm may not suit all workflows |
| Time-travel diffing against git revisions is unique | Rust port just released; unclear if Go version continues |

### beads-viewer (mgalpert) -- The Web UI

| Pros | Cons |
|------|------|
| Familiar web-based React UI | Only 23 stars; smaller community |
| Real-time WebSocket collaboration | No robot mode for agents |
| Interactive dependency graph via React Flow | Built for Beads v0.9.6; compatibility with v0.50+ unknown |
| Drag-and-drop Kanban board | Last pushed October 2025 (5 months stale) |
| Clean architecture (Express + Zustand) | Requires Bun runtime |
| Optimistic updates for responsive UX | No graph analytics beyond basic dependency view |

## Sources

- [Dicklesworthstone/beads_viewer](https://github.com/Dicklesworthstone/beads_viewer) -- Primary Go TUI repository (1,338 stars)
- [mgalpert/beads-viewer](https://github.com/mgalpert/beads-viewer) -- React web UI (23 stars)
- [steveyegge/beads](https://github.com/steveyegge/beads) -- Core Beads issue tracker (17,848 stars)
- [Beads COMMUNITY_TOOLS.md](https://github.com/steveyegge/beads/blob/main/docs/COMMUNITY_TOOLS.md) -- Official ecosystem listing
- [Dicklesworthstone/beads_viewer_rust](https://github.com/Dicklesworthstone/beads_viewer_rust) -- Rust port (Feb 2026)
- [Homebrew formula](https://formulae.brew.sh/formula/beads_viewer) -- v0.14.4, 145 installs/month
- [Jeffrey Emanuel's project page](https://jeffreyemanuel.com/projects/beads-viewer) -- Author's summary
- [skills.rest/skill/beads-viewer](https://skills.rest/skill/beads-viewer) -- Claude Code skill wrapper
- [Ralph TUI Beads-BV integration](https://ralph-tui.com/docs/plugins/trackers/beads-bv) -- Plugin integration
- [Ian Bull: "Beads - Memory for your Agent"](https://ianbull.com/posts/beads/) -- Community blog review
- [Steve Yegge endorsement on X](https://x.com/Steve_Yegge/status/1993919120170209498) -- "First UI I could see myself using"
- [Jeffrey Emanuel on X](https://x.com/doodlestein/status/2001682985343418795) -- Author's announcement thread
- [Thomas Ricouard on X](https://x.com/Dimillian/status/1994799113192288448) -- "Open in Cursor" integration
- [Reddit r/vibecoding](https://www.reddit.com/r/vibecoding/comments/1p9tnm3/is_beads_worth_a_try/) -- User discussion
- [Reddit r/vibecodeprod](https://www.reddit.com/r/vibecodeprod/comments/1p85au9/) -- Launch announcement
- [Reddit r/ClaudeCode](https://www.reddit.com/r/ClaudeCode/comments/1qgkupf/) -- Superpowers integration
