# ccstatusline

> Highly customizable statusline for Claude Code CLI with powerline support, themes, and interactive TUI configuration.

| Attribute | Value |
|-----------|-------|
| **URL** | https://github.com/sirmalloc/ccstatusline |
| **Author** | Matthew Breedlove (@sirmalloc) |
| **Stars** | 3,442 |
| **License** | MIT |
| **Created** | August 2025 |
| **Last Active** | February 3, 2026 |

## Key Insights

- **Most feature-rich statusline tool** in the Claude Code ecosystem with 15+ widget types, unlimited status lines, and interactive TUI configuration
- **3.4K stars in 6 months** with active development (v2.0.16 latest), suggesting strong product-market fit among Claude Code power users
- **Part of larger ecosystem** alongside ccusage (token tracking), claude-powerline (zero-deps), and cc-statusline (simple setup)—ccstatusline targets users who want maximum customization
- **Author credibility**: Matthew Breedlove is a 16-year veteran developer (CTO at Revenite.ai) who maintains multiple Claude Code tools (tweakcc, related to ccusage ecosystem)
- **Community hub is Reddit** (r/ClaudeAI), where author actively engages with feature requests; Twitter discussion favors lighter ccusage tool

## What It Does

ccstatusline transforms Claude Code's bottom status bar into a customizable information dashboard. Key capabilities:

### Widgets Available
- **Model & Session**: Model name, session clock, session cost, block timer (5-hour tracking)
- **Git Integration**: Branch, changes (+/-), worktree name
- **Token Metrics**: Input/output/cached/total tokens, context percentage (with 80% usable threshold)
- **System**: Current working directory (fish-style abbreviation), terminal width
- **Custom**: Custom text (emoji support), custom command (execute shell commands)
- **Layout**: Static separators, flex separators (right-align content)

### Configuration
- Interactive TUI (React/Ink) for visual configuration
- Powerline support with 16/256/true color modes
- Multi-line layouts (unlimited lines)
- Global formatting options (padding, separators, bold)

### Installation
```bash
npx ccstatusline@latest   # npm
bunx ccstatusline@latest  # bun (faster)
```

## Competitive Landscape

| Tool | Approach | Stars | Best For |
|------|----------|-------|----------|
| **ccstatusline** | Full-featured TUI | 3.4K | Maximum customization |
| **claude-powerline** | Zero-deps, vim-style | ~2K | Security-conscious users |
| **cc-statusline** | Question-based setup | ~500 | Quick, simple setup |
| **ccusage** | Token/cost focused | ~1K | Usage tracking focus |
| **Custom scripts** | jq one-liners | N/A | Minimal overhead |

ccstatusline differentiates through:
- **TUI configuration** (no JSON editing required)
- **Widget variety** (15+ types vs 5-8 in competitors)
- **Powerline aesthetics** with theme support
- **ccusage integration** via custom command widget

## Technical Details

- **Runtime**: Bun (recommended) or Node.js
- **Config Storage**: `~/.config/ccstatusline/settings.json`
- **Claude Integration**: `~/.claude/settings.json` with `CLAUDE_CONFIG_DIR` support
- **Platform**: Cross-platform (macOS, Linux, Windows with full documentation)

### Known Limitations
- Terminal width detection "a bit unreliable" on some systems (POSIX hack)
- Single primary maintainer (bus factor concern)
- Some users reported agent conflicts after statusline setup (likely configuration issues)

## Community Reception

### Reddit (Primary Community)
- "Now I actually know what's happening!"
- TUI praised for eliminating JSON editing
- Author actively responds to feature requests
- Listed in "25 Claude Code Tips" compilation

### Twitter
- Limited direct mentions; ccusage has more Twitter mindshare
- Statusline ecosystem broadly well-received

### Recognition
- Mentioned in "Awesome Claude Code" list
- Listed on ClaudeLog knowledge base
- Context7 library entry with "High" source reputation

## Development Status

**Very Active**: Latest commit February 2, 2026

Recent releases:
- v2.0.16: Fish-style path abbreviation
- v2.0.14: Remaining mode toggle for context percentage
- v2.0.12: Emoji support in custom text
- v2.0.11: Unlimited status lines (removed 3-line limit)

Open issues suggest continued feature development (free memory widget, git indicators, CI setup).

## Recommendations

**Use ccstatusline if:**
- You want rich visual customization without editing JSON
- Multiple status lines or powerline aesthetics matter to you
- You need diverse widgets (block timer, git worktree, custom commands)
- You're comfortable with a feature-rich tool

**Consider alternatives if:**
- You want zero dependencies (→ claude-powerline)
- You only need token tracking (→ ccusage)
- You prefer minimal setup (→ cc-statusline or custom jq script)

**Bottom line**: The most comprehensive Claude Code statusline tool available. Recommended for power users who want their status bar to show everything at a glance. For simpler needs, the lighter alternatives may suffice.

## Links

- [GitHub Repository](https://github.com/sirmalloc/ccstatusline)
- [npm Package](https://www.npmjs.com/package/ccstatusline)
- [Author LinkedIn](https://linkedin.com/in/sirmalloc)
- [Related: ccusage Integration Guide](https://ccusage.com/guide/statusline)
- [Related: tweakcc (themes)](https://github.com/Piebald-AI/tweakcc)
