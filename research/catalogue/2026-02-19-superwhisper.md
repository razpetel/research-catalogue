---
topic: superwhisper
slug: superwhisper
date: 2026-02-19
sources: [github, reddit, twitter, linkedin, web]
---

# Superwhisper Research Report

## Overview

Superwhisper is a privacy-first AI voice dictation application built by SuperUltra, Inc., a bootstrapped, profitable startup based in Toronto, Canada. Founded in 2023 by Neil Chudleigh (Y Combinator alum, previously co-founded PartnerStack), the app converts speech to text using local Whisper models running on-device, with optional cloud LLM post-processing through GPT-5, Claude Haiku 4.5, Llama 4, Grok 4.1, Gemini 3.0 Flash, and others. Available on macOS (full-featured), Windows (catching up), iOS/iPad, and Apple Vision Pro, it targets developers, writers, and productivity power users who want deep customization and data privacy.

Superwhisper's defining moment came on February 2, 2025, when Andrej Karpathy — ex-Tesla AI director and OpenAI founding member — coined the term "vibe coding" in a viral tweet while explicitly naming SuperWhisper as his tool of choice for talking to Cursor. This single endorsement cemented the app's position in the developer consciousness and drove massive organic adoption. Neel Nanda (Google DeepMind), Chris Albon (Wikimedia ML), and Quinn Nelson (SnazzyLabs, 1.3M YouTube subscribers) have also publicly endorsed or discussed it.

The product occupies the "power user premium" tier of a rapidly expanding voice dictation market that now includes 15+ competitors. It differentiates through context awareness via macOS accessibility APIs (reading clipboard, selected text, and active application), an extensive mode system (Voice, Message, Email, Note, Super, Meeting, Custom), bundled unlimited LLM access, and a $249.99 lifetime license — unique among premium dictation tools. However, it faces growing pressure from cheaper alternatives (VoiceInk at $39 open-source, BetterDictation at $24) and free open-source entrants (FreeFlow by Zach Latta gained 658 GitHub stars in 4 days). The LA Times featured the voice dictation trend in January 2026, signaling mainstream awareness of the category.

## Technical Analysis

### Product Architecture

| Attribute | Detail |
|-----------|--------|
| **Core Engine** | whisper.cpp (confirmed via GitHub fork of ggml-org/whisper.cpp) |
| **Voice Models** | Nano, Fast, Pro, Ultra (increasing accuracy/resource demands); Parakeet model |
| **AI Models** | GPT-5, Claude Haiku 4.5, Llama 4, Grok 4.1, Gemini 3.0 Flash, Ministral |
| **Local Processing** | Full offline capability on Apple Silicon; Intel Macs better with cloud models |
| **Context Awareness** | macOS accessibility APIs: clipboard (3-sec window), selected text, active app |
| **Activation** | Default Option+Space (customizable); Push-to-Talk mode |
| **Modes** | Voice to Text, Message, Email, Note, Super, Meeting, Custom |
| **Languages** | 100+ with translation to English (Pro) |
| **Deep Links** | `superwhisper://mode?key=KEY`, `superwhisper://record` |
| **BYOK** | Custom API keys for OpenAI, Anthropic, etc. |
| **App Store Rating** | 4.4/5 (696 ratings), v2.5.2, 43.4 MB |
| **Product Hunt** | 4.9/5 (1,200+ reviews) |

### Platform Support

| Platform | Status |
|----------|--------|
| **macOS** | Full-featured (Intel + Apple Silicon) |
| **Windows** | Desktop app, some features catching up (no FileSync, experimental system audio/Parakeet) |
| **iOS/iPad** | Available (iOS 18.0+), keyboard mode, AirPods Pro, CarPlay |
| **Apple Vision Pro** | Supported (visionOS 2.0) |
| **Linux** | Not supported |

### GitHub Presence

Superwhisper is **closed-source commercial software**. The official GitHub org (`superultrainc`) has 5 public repos:

| Repo | Stars | Purpose |
|------|-------|---------|
| superwhisper-docs | 45 | Mintlify documentation (last PR: Feb 18, 2026) |
| superwhisper-download | 68 | README with download links |
| superwhisper-raycast | 19 | Official Raycast extension (TypeScript, MIT) |
| whisper.cpp (fork) | 0 | Fork of ggml-org/whisper.cpp confirming local inference engine |
| sup | 25 | Internal Go TUI tool for GitHub PRs |

**Community ecosystem** is healthy:
- `ognistik/macrowhisper` (150 stars) — Swift automation helper, most popular community project
- `ognistik/alfred-superwhisper` (121 stars) — Alfred workflow integration
- `ognistik/superwhisper` (10 stars) — Shared modes and settings configs
- Various dictation prompt collections, analytics toolkits, and custom modes

**72 repos** reference "superwhisper" on GitHub; ~80 issues across external repos mention it (Raycast, PowerToys, Codex, VibeKanban).

### Open-Source Alternatives Explicitly Targeting Superwhisper

| Project | Stars | Created | Description |
|---------|-------|---------|-------------|
| zachlatta/freeflow | 658 | Feb 15, 2026 | "Free alternative to Wispr Flow / Superwhisper" — 658 stars in 4 days |
| bokan/stt | N/A | Dec 2025 | "Like SuperWhisper, but free. Like Wispr Flow, but local." |
| moinulmoin/voicetypr | N/A | 2026 | Offline voice-to-text for macOS/Windows |
| knowall-ai/turbo-whisper | N/A | Jan 2026 | SuperWhisper-like dictation for Linux |
| maker-or/openwispher | N/A | Feb 2026 | Simple open-source alternative |

## User Sentiment

**Overall: Mixed-to-Positive** — power users are deeply loyal; casual users find it overpriced and complex

### Reddit: Mixed-to-Positive (High Confidence)

- **r/superwhisper** (962 subscribers) + extensive discussion across r/macapps, r/LocalLLaMA, r/ProductivityApps, r/ClaudeCode
- **Power users praise deeply**: "IMHO Superwhisper is amazing and the best at what it does"; "works flawlessly on my mac, maybe one of my most used apps"; "it has come to replace most AI apps for text related tasks"
- **Biggest complaint — unresponsive developer**: Cited independently in 4+ threads. Multiple users report emails ignored for months. "Bought Pro subscription, emailed support twice over two months, got zero response."
- **Pricing contentious**: "$250 for lifetime versus $19 for VoiceInk. Is the high cost mainly due to LLM access?"; "VoiceInk + BYOK costs about $0.02/day"
- **Paywalling backlash**: "Today's update shamelessly shifted from 'Pay for Cloud Models' to 'Pro' Models" — one user's app was "completely bricked" by the tier change
- **Learning curve frustrates casual users**: "SuperWhisper does pull you into that rabbit hole"; multiple users struggle to get pure transcription without AI "helping"
- **iOS and Windows weak**: iOS keyboard has app-specific limitations; Windows beta described as "painfully slow"

### Twitter: High Volume, Rising Trend

- **Karpathy watershed**: "There's a new kind of coding I call 'vibe coding'... I just talk to Composer with SuperWhisper" — coined the most influential AI dev term of 2025, giving Superwhisper massive exposure
- **Consistent influencer endorsements**: Neel Nanda (DeepMind): "a wonderful piece of software I use tens to hundreds of times a day"; Chris Albon (Wikimedia): "Talking to Cursor with Superwhisper is so much fun"
- **PCMag organic adoption**: Reviewer casually mentions using Superwhisper daily in an unrelated headphone review
- **Founder (@neilsuperduper) active**: Shipping rapidly — Windows launch, v2.0, Parakeet model, Ultra Cloud
- **@superwhisperapp**: Very active official account with product announcements reaching 12K+ views

### LinkedIn: Overwhelmingly Positive

- **Company page**: 1,655 followers; 1-3 employees (Neil Chudleigh, Max Humber, Austen Sutherland)
- **Professional adoption**: 10+ substantive posts from PMs, content creators, legal reviewers. Use cases: email drafting, document reviews, AI chat, Notion, Slack
- **Notable**: Ben Erez post (51 likes, 33 comments) actually switched *away* to Willow — competitive pressure visible
- **MacSources LinkedIn article** (Feb 16, 2026): Detailed 9.7/10 review
- **Hard Fork podcast** (NYT): Kevin Roose discussed superwhisper, driving discovery
- **AIMinds Podcast** (Deepgram): Neil Chudleigh featured as guest
- **No job listings**: Bootstrapped team, no open positions

## Competitive Landscape

The AI voice dictation market is experiencing explosive growth with 15+ active products. Superwhisper occupies the power-user premium tier:

| Competitor | Price | Key Difference vs Superwhisper |
|-----------|-------|-------------------------------|
| **Wispr Flow** | $12/mo ($144/yr) | Cloud-based, more polished UX, cross-platform. No offline. $81M funded. |
| **VoiceInk** | $39 one-time (or free OSS) | Open-source, BYOK model costs pennies. Fewer AI features. The main threat. |
| **BetterDictation** | $2/mo or $24 lifetime | Budget king. Simpler features. Apple Silicon only. |
| **MacWhisper** | $30-79 one-time | Better for batch file transcription. Not real-time dictation focused. |
| **Voibe** | $4.90/mo or $99 lifetime | 48% cheaper annually. Developer Mode for coding. |
| **Aqua Voice** | $8-10/mo | Real-time floating text, 99.1% accuracy claim. Cross-platform. |
| **Willow Voice** | $15/mo | Zero-config simplicity, context-aware formatting. YC X25. |
| **FreeFlow** | Free (OSS) | Zach Latta (Hack Club). 658 stars in 4 days. Newest disruptor. |
| **OpenWhispr** | Free (OSS) | Cross-platform (Mac/Win/Linux). Hybrid offline/cloud. |
| **Spokenly** | Free (BYOK) | Free with local models. Lightweight (2.9MB). |

**Market dynamics:**
- Privacy (local vs cloud) is the primary battleground
- Subscription fatigue is driving users toward one-time purchase and BYOK models
- VoiceInk's $39 open-source offering is the most frequently recommended alternative
- FreeFlow's 658 stars in 4 days signals latent demand for free alternatives
- "Vibe coding" has become a major growth driver, tying dictation tools to AI-assisted development

## Company & Business

| Attribute | Detail |
|-----------|--------|
| **Legal Entity** | SuperUltra, Inc. |
| **HQ** | Toronto, Ontario, Canada |
| **Founder** | Neil Chudleigh (YC alum, ex-PartnerStack co-founder) |
| **Team Size** | 1-3 visible employees (Neil Chudleigh, Max Humber, Austen Sutherland) |
| **Funding** | Bootstrapped, profitable |
| **Founded** | 2023 (HN Show HN launch) |
| **LinkedIn Followers** | 1,655 |

### Pricing

| Tier | Price | Key Inclusions |
|------|-------|----------------|
| Free | $0 | Voice-to-text, 100+ languages, small AI models, 3 custom modes |
| Pro Monthly | $8.49/mo | Unlimited cloud/local AI, BYOK, translation, file transcription, speaker separation |
| Pro Annual | $84.99/yr | Same as monthly (~$7.08/mo effective) |
| Pro Lifetime | $249.99 | Perpetual license. Pays for itself in ~17 months vs Wispr Flow |
| Enterprise | Custom | SOC 2 Type II, centralized billing, model access controls, enterprise-hosted models |
| Student | 40% off Pro | Verified students |

## Pros and Cons

| Pros | Cons |
|------|------|
| Offline-first privacy — all transcription can run fully on-device | Unresponsive developer support — #1 community complaint, emails ignored for months |
| Context awareness via accessibility APIs (clipboard, selected text, active app) | $249 lifetime seen as steep vs VoiceInk ($39) and BetterDictation ($24) |
| Extensive mode system with per-app configuration | Steep learning curve — casual users find it overcomplicated |
| $249 lifetime license — unique among premium tools | Paywalling formerly free features ("Cloud" to "Pro" tier shift) upset users |
| Karpathy "vibe coding" endorsement — unmatched brand association | Windows version still catching up to macOS feature parity |
| Bundled unlimited LLM access across 6+ models | iOS keyboard has app-specific limitations |
| Cross-platform (Mac, Windows, iOS, Vision Pro) | No Linux support |
| Bootstrapped and profitable — no VC dependency or shutdown risk | Single-maintainer risk (small 1-3 person team) |
| Growing community ecosystem (Macrowhisper, Alfred, Raycast, custom modes) | Occasional UI glitches and key binding failures |
| 100+ language support with translation | BYOK alternatives make bundled LLM access less of a differentiator |
| Active development — frequent updates, enterprise features expanding | Setapp version reportedly inferior to direct version (now delisted) |
| 4.9/5 Product Hunt (1,200+ reviews), MacSources 9.7/10 | Accuracy degrades with heavy background noise and strong accents |

## Sources

### Official
- https://superwhisper.com
- https://superwhisper.com/docs
- https://apps.apple.com/us/app/superwhisper/id6471464415
- https://feedback.superwhisper.com
- https://github.com/superultrainc

### Reviews & Articles
- https://macsources.com/superwhisper-app-review/ (9.7/10, Feb 2026)
- https://www.latimes.com/business/story/2026-01-29/thanks-to-ai-voice-dictation-more-people-are-speaking-out-their-emails-messages-code
- https://madeinca.ca/voice-to-text-software-superwhisper/
- https://samwize.com/2025/11/10/review-of-whispr-flow-superwhisper-macwhisper-for-vibe-coding/
- https://andyabramson.medium.com/unleashing-the-power-of-voice-my-love-affair-with-superwhisper-d82716ffdf69
- https://rolloutit.net/code-without-typing-integration-between-cursor-ai-and-superwhisper/
- https://deepgram.com/podcast/aiminds-014-neil-chudleigh-creator-and-founder-of-superwhisper

### Comparisons
- https://betterdictation.com/blog/betterdictation-vs-superwhisper
- https://openwhispr.com/compare/superwhisper
- https://www.getvoibe.com/blog/superwhisper-alternatives/
- https://ottex.ai/compare/wispr-flow-vs-superwhisper/
- https://willowvoice.com/blog/super-whisper-vs-wispr-flow-comparison-reviews-and-alternatives-in-2025
- https://afadingthought.substack.com/p/best-ai-dictation-tools-for-mac

### Twitter/X
- https://x.com/karpathy/status/1886192184808149383 (vibe coding tweet)
- https://x.com/chrisalbon/status/1886192527491150256
- https://x.com/NeelNanda5/status/1938403515115970606
- https://x.com/SnazzyLabs/status/1899935011635421381
- https://x.com/superwhisperapp
- https://x.com/neilsuperduper

### LinkedIn
- https://www.linkedin.com/company/superwhisper
- https://www.linkedin.com/in/neilchudleigh/
- https://www.linkedin.com/pulse/superwhisper-review-mac-ios-transcription-finally-feels-effortless-zdrhc

### Reddit
- https://www.reddit.com/r/macapps/comments/1k67f55/superwhisper_vs_voiceink/
- https://www.reddit.com/r/superwhisper/comments/1kccyt8/unresponsive_developer/
- https://www.reddit.com/r/superwhisper/comments/1q4xbvo/todays_update_shamelessly_shifted_from_pay_for/
- https://www.reddit.com/r/superwhisper/comments/1oxjocz/good_bye_whisper/
- https://www.reddit.com/r/macapps/comments/1lg4wyj/a_definitive_dictation_app_comparison/
- https://www.reddit.com/r/macapps/comments/1qwn64o/looking_at_dictation_apps_typeless_clear_winner/

### GitHub (Community)
- https://github.com/ognistik/macrowhisper (150 stars)
- https://github.com/ognistik/alfred-superwhisper (121 stars)
- https://github.com/zachlatta/freeflow (658 stars — OSS alternative)

---
*Generated by Research Agent on 2026-02-19*
