# claude-relay (chadbyte)

## Overview
**claude-relay** is an open-source (MIT) local relay server that provides a browser-based web UI for Claude Code, enabling push notifications, session handoff across devices, and multi-project management -- all without any cloud dependency. Created by chadbyte, it launched on Feb 9, 2026 and reached 2,000+ npm downloads and 81 GitHub stars in its first 10 days.

- **GitHub:** https://github.com/chadbyte/claude-relay
- **npm:** https://www.npmjs.com/package/claude-relay
- **Stars:** 81 | **Forks:** 6 | **License:** MIT
- **Created:** 2026-02-09
- **Language:** JavaScript (Node.js 18+)

## The Problem It Solves
Claude Code runs in the terminal. When it needs approval for a tool execution, it halts and waits. If you walk away to grab coffee, it sits there doing nothing. This is the single biggest workflow bottleneck for developers using Claude Code in autonomous/semi-autonomous modes.

Multiple solutions have emerged for this problem (see Competitive Landscape below), but claude-relay distinguishes itself with a **zero-install, zero-cloud** approach: one command (`npx claude-relay`) creates a local web server accessible from any device on your network.

## Architecture
claude-relay is **not** a stdin/stdout wrapper. It drives Claude Code directly via the **Claude Agent SDK** (`@anthropic-ai/claude-agent-sdk`) and streams data to the browser via WebSocket.

Key architectural decisions:
- **Background daemon** spawned with `detached: true` -- survives terminal closure
- **Unix socket IPC** for CLI-to-daemon communication (no extra TCP port)
- **Append-only JSONL session storage** -- at most last line lost on crash
- **Slug-based routing** -- multiple projects on a single port (`/p/{slug}/`)
- **Async iterables** connecting SDK message queue and response stream
- **File path validation** with symlink resolution, blocking access outside project directory
- **`0.0.0.0` binding + PIN** for LAN access, VPN recommended for remote

### Permission Flow
1. SDK invokes `canUseTool()` callback
2. Server creates a Promise, stores in `pendingPermissions[requestId]`
3. `permission_request` broadcast to all connected WebSocket clients
4. Push notification sent to subscribed devices
5. Client sends `permission_response` (allow/deny)
6. Promise resolves, SDK continues tool execution

## Key Features
- **Push notifications** for approvals, completions, errors, questions (PWA on iPhone, desktop Chrome)
- **Multi-project daemon** -- manage all projects via a single port
- **Session handoff** -- start in terminal, continue on phone, pass back to desktop
- **File browser** with live-reload on external file changes
- **Built-in terminal** with multi-tab support, rename, reorder, mobile special-key toolbar
- **Session search** with full-text search and hit timeline
- **Auto session logs** (JSONL) always saved locally
- **Token usage** display and model switching from browser
- **Mermaid diagram and Markdown rendering**, syntax highlighting for 180+ languages
- **Image paste and camera** attachment
- **Slash command** support with autocomplete
- **Sticky TodoWrite overlay** -- floating progress bar while scrolling
- **Draft persistence** per session
- **QR code** for instant mobile connect
- **HTTPS** via automatic mkcert certificate generation
- **macOS keep-awake** to prevent sleep during sessions

## Development Activity
- **Single contributor:** chadbyte (all commits)
- **23 npm versions** in 10 days (v1.0.0 on Feb 9 to v2.2.3 on Feb 19) -- extremely rapid iteration
- **30+ issues** filed (14 open), active bug fixing and feature shipping
- Already addressed **Anthropic TOS compliance** by removing OAuth usage API (issue #91, Feb 19)
- Handling plan approvals, diff previews, edit tool display
- International adoption signal: Korean fork (SihyunAdventure/claude-relay)

## Community Reception

### Reddit
- Original post in r/ClaudeCode: "I built a browser UI for Claude Code with push notifications. 2,000 downloads in 10 days"
- Earlier post in r/ClaudeAI: "I built a tool to access Claude Code on your actual machine from any device -- no GitHub, no sandbox"
- Author explicitly differentiates from Happy Coder: "The main difference is the architecture. Happy Coder runs a relay server in the cloud to bridge your machine and phone. claude-relay keeps everything local."
- Community response appears positive; the "mobile access problem" resonates widely
- Users mention pairing with Tailscale for remote access

### Hacker News
- Show HN post: "Claude Relay -- Web UI for Claude Code, zero install, push notifications" (item #47033722)
- Post appeared ~3 days ago

### Twitter / LinkedIn
- No significant presence found on Twitter/X or LinkedIn as of Feb 19, 2026

## Competitive Landscape

The Claude Code web UI / mobile access space is crowded and rapidly evolving:

| Tool | Stars | Approach | Cloud Required | Price | Key Differentiator |
|------|-------|----------|----------------|-------|--------------------|
| **claude-relay** | 81 | Local WebSocket relay via Agent SDK | No | Free (MIT) | Zero install (`npx`), zero cloud, daemon model |
| **Happy Coder** | 12.6K | Cloud relay server + mobile/web client | Yes (relay) | Free | E2E encryption, voice input, iOS/Android native |
| **Claudia** | ~19.9K | Desktop Electron app | No | Free (AGPL) | Full GUI toolkit, custom agents, background agents |
| **VibeKanban** | 20.4K | Visual Kanban orchestrator | No | Free | Multi-agent, supports Claude Code + Gemini + Codex |
| **claude-remote** | 14 | Local PWA relay | No | Free | Lightweight PWA with push notifications |
| **AgentOS** | - | Self-hosted web UI | No | Free | Multi-session management |
| **Omnara** | - | iOS native app | Yes | $9/mo | Native iOS experience |
| **ntfy.sh hooks** | DIY | Claude Code hooks + push service | No (self-host) | Free | No UI, just notifications |

### claude-relay's Positioning
- **vs Happy Coder:** No cloud relay, no signup, everything local. Happy Coder has 150x the stars and a polished mobile experience with voice input and E2E encryption. claude-relay trades that polish for simplicity and data sovereignty.
- **vs Claudia:** claude-relay is browser-based (no install), Claudia is a desktop Electron app with deeper toolkit features (custom agents, background agents). Different niches.
- **vs VibeKanban:** VibeKanban is a full orchestration platform for parallel agents. claude-relay is a focused browser UI for a single Claude Code session per project. Not directly competing.
- **vs ntfy hooks:** claude-relay provides the full UI experience. ntfy hooks are the minimal "just notifications" approach.

## Concerns and Risks

1. **Single maintainer** -- all 30+ commits from chadbyte. Bus factor of 1. 23 npm versions in 10 days suggests possibly unsustainable pace.
2. **Network security** -- binds to `0.0.0.0` by default, making it accessible to anyone on the local network. PIN protection is optional (set during first run). The README explicitly warns against public internet exposure.
3. **Very early stage** -- 81 stars, 10 days old, v2.2.3. Feature set is impressive but stability is unproven at scale.
4. **No E2E encryption** -- unlike Happy Coder. Data is transmitted in cleartext over the LAN (HTTPS mitigates but requires mkcert setup).
5. **Push notification reliability** -- issues #90 and #93 report problems with iOS/WSL2/Tailscale and WiFi network setups. Push on mobile requires HTTPS + PWA "Add to Home Screen" -- a multi-step setup.
6. **TOS compliance** -- already had to remove OAuth usage API feature (issue #91) to comply with Anthropic TOS. Future feature additions may hit similar walls.
7. **Agent SDK dependency** -- tied to `@anthropic-ai/claude-agent-sdk` which is itself evolving rapidly (0.2.x). Breaking changes upstream could require immediate updates.

## Sentiment
**Positive (Early)**. The architecture is sound, the problem is real and widely felt, the zero-install approach is genuinely differentiated, and the development pace is impressive. However, 81 stars puts it far behind established alternatives (Happy Coder 12.6K, Claudia 19.9K), and the single-maintainer rapid-release pattern needs sustained community contribution to be viable long-term.

## Recommendation
- **Worth trying now** if you want a zero-cloud, zero-install browser UI for Claude Code, especially for local network use with Tailscale
- **Pair with mkcert** for push notifications (required for HTTPS)
- **Do not expose to public internet** -- use Tailscale or VPN for remote access
- **Watch for community growth** -- 81 stars vs 12.6K (Happy Coder) is a significant gap; adoption trajectory in the next 30 days will be telling
- **If you need mobile-first with voice:** evaluate Happy Coder instead
- **If you need a full desktop toolkit:** evaluate Claudia instead

## Sources
- https://github.com/chadbyte/claude-relay
- https://www.reddit.com/r/ClaudeCode/comments/1r8keob/
- https://www.reddit.com/r/ClaudeAI/comments/1r0irv7/
- https://news.ycombinator.com/item?id=47033722
- https://www.npmjs.com/package/claude-relay
- https://happy.engineering/docs/comparisons/alternatives/
- https://www.scriptbyai.com/claude-code-resource-list/

---
*Research date: 2026-02-19*
