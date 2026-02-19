---
topic: whatsapp-public-logan (Logan)
slug: whatsapp-public-logan
date: 2026-02-19
sources: [github, reddit, twitter, linkedin, web]
---

# Logan (whatsapp-public-logan) Research Report

## Overview

Logan is a self-hosted WhatsApp AI bot by Yuval Avidani (@hoodini), a 2x GitHub Star and 2x AWS Gen AI Superstar based in Israel who works as a Cyber Security Architect at The Jewish Agency. The bot was publicly released on February 13, 2026 as a sanitized open-source version of a private production codebase, co-authored with Claude Sonnet 4.5. Built with TypeScript on top of the Baileys unofficial WhatsApp multi-device API and Supabase for storage, it integrates multiple AI services: Groq (LLaMA 3.3 70B) for fast chat responses and spam detection, Claude 3.5 Sonnet for daily group summaries, Whisper for voice transcription, ElevenLabs for TTS, and Tavily for web search with hallucination detection.

The project has gained 47 stars and 19 forks in its first 6 days, showing real early interest. However, it has zero community visibility beyond GitHub -- no Reddit threads, no Twitter launch announcement, and no press coverage. The repository consists of a single commit (a sanitized dump), with no issues, PRs, or ongoing public development. The codebase itself is substantial and well-structured, with 90+ configurable environment variables, modular service architecture, and comprehensive documentation including a beginner-friendly setup guide.

Logan's most distinctive feature is its 4-layer Shabbat auto-lock system that automatically restricts WhatsApp groups to announcement-only mode before Shabbat and unlocks them after havdalah, integrating with the Hebcal Jewish calendar API and featuring cache, state persistence, and timezone fallback layers. This, combined with Hebrew-first design and Israeli tech community cultural awareness, gives it genuine niche appeal that no competitor matches.

## Technical Analysis

### Architecture
- **Runtime**: Node.js 18+ / TypeScript 5.3+
- **WhatsApp API**: Baileys v6.7.21 (unofficial WebSocket-based multi-device)
- **Database**: Supabase (PostgreSQL) -- messages, auth state, broadcast guards, pending responses
- **Web Framework**: Express.js v5.2.1 (REST API on port 7700)
- **Logging**: Pino (structured, configurable levels)
- **Scheduling**: node-schedule

### AI Services (Multi-LLM Strategy)
| Service | Purpose | Model | Cost |
|---------|---------|-------|------|
| Groq | Chat responses, spam detection | LLaMA 3.3 70B | Free (200K tokens/day) |
| Anthropic | Daily summaries | Claude 3.5 Sonnet | $5 free credit |
| Groq/Whisper | Voice transcription | Whisper | Free tier |
| ElevenLabs | Text-to-speech | Neural TTS | Optional, 10K chars/month free |
| Tavily | Web search | Search API | Optional, 1K searches/month free |

This multi-LLM approach is genuinely thoughtful -- using Groq's free tier for high-volume, low-latency chat responses while reserving Claude for higher-quality daily summaries is cost-effective.

### Core Features
1. **AI Mention Responses**: Context-aware (15 group + 5 user messages), rate-limited (3/user/min), multi-language (Hebrew/English)
2. **Daily Summaries**: Automated AI recaps at configurable time, multi-group, master channel support, Erev Shabbat awareness
3. **4-Layer Shabbat Auto-Lock**: Hebcal API + local cache + lock state file + timezone fallback
4. **AI Spam Detection**: LLM-based analysis with two-strike system, pre-filter optimization, whitelist support
5. **Join Request Processing**: Bot detection algorithm (profile pic, name patterns, phone patterns scoring)
6. **Voice Transcription**: Automatic Whisper transcription of voice messages
7. **Voice Summaries**: ElevenLabs TTS with anti-cutoff chunking
8. **Web Search**: Tavily integration with source citation and URL hallucination detection
9. **Broadcast System**: Supabase-backed atomic locks, partial recovery, race condition protection
10. **REST API**: Health checks, manual triggers, group management, message queue
11. **Multi-Tier Auth**: Admin numbers, public groups, free chat groups
12. **90+ Environment Variables**: Exhaustive configurability

### Codebase Quality
- **Total source**: ~190KB across 20 TypeScript files
- **Largest files**: `messageHandler.ts` (37KB), `shabbatLocker.ts` (34KB), `api.ts` (28KB)
- **Type safety**: Full TypeScript with interfaces
- **Documentation**: Extremely thorough README (54KB), additional docs for onboarding, phone change, Shabbat system, security
- **Security awareness**: SECURITY.md, RLS examples, API key protection, `.gitignore` for sensitive files

### Red Flags
- **Single commit**: Entire codebase dumped in one "initial public release" commit, making it impossible to see development history
- **Baileys dependency**: Unofficial WhatsApp API -- accounts can be banned by Meta
- **No tests**: No test suite visible in package.json or project structure
- **No CI/CD**: No GitHub Actions or similar
- **No releases/tags**: Just the master branch
- **Co-authored with Claude Sonnet 4.5**: Unclear how much is human-written vs AI-generated

## User Sentiment

**Overall: No Community Signal (Too New)**

- **Reddit**: Zero direct mentions. The broader Baileys-based WhatsApp bot ecosystem has mixed sentiment -- enthusiasts appreciate the flexibility, but the dominant advice on r/node and r/automation is "use the official WhatsApp Business API to avoid bans." Self-hosted AI chatbot interest is growing on r/selfhosted.
- **Twitter/X**: Author (@yuvalav) has a presence (585 following) but no discoverable tweets about this specific project. No influencer amplification detected.
- **LinkedIn**: Author is active (500+ connections) as a Cyber Security Architect and AI Developer. No posts about the Logan bot found. Professional context adds credibility -- security expertise is relevant to the bot's security features.

## Competitive Landscape

### Self-Hosted WhatsApp AI Bots
| Name | Approach | Differentiator |
|------|----------|----------------|
| **EvolutionAPI** | Open-source WhatsApp integration API | Most popular, multi-messaging-service support |
| **KnightBot-MD** | Baileys group management bot | Simpler, focused on group moderation |
| **wa_llm** | AI-powered group conversation bot | Similar concept, lighter feature set |
| **KHAN-MD / STARK-MD** | Feature-rich Baileys bots | Media tools, plugin loaders, but less AI-focused |
| **Python + Gemini bots** | r/selfhosted community favorites | Lower cost ($6/mo), but less WhatsApp-native |

### Enterprise Alternatives
| Name | Approach | Difference from Logan |
|------|----------|----------------------|
| **Wati** | Official WhatsApp Business API | No-code, no ban risk, but $49+/mo |
| **WaliChat** | Official API provider | Cheaper entry, but commercial |
| **Wassenger** | WhatsApp automation platform | Commercial, full dashboard |
| **n8n + Evolution API** | No-code + open-source combo | Visual workflow builder |

### Logan's Unique Position
Logan occupies a niche nobody else fills: a **feature-complete, self-hosted WhatsApp AI bot designed specifically for Hebrew-speaking and observant Jewish communities**. The Shabbat auto-lock system with 4-layer fallback is completely unique in the ecosystem. The multi-LLM cost optimization strategy (free Groq for chat, paid Claude for summaries) is also more sophisticated than most alternatives.

## Pros and Cons

| Pros | Cons |
|------|------|
| Unique Shabbat auto-lock (4-layer, Hebcal integration) | Uses unofficial Baileys API (WhatsApp ban risk) |
| Hebrew-first with cultural awareness | Single commit dump -- no development history |
| Multi-LLM cost optimization (Groq free + Claude paid) | No test suite or CI/CD |
| 90+ configurable environment variables | Zero community beyond GitHub (no Reddit/Twitter) |
| Comprehensive documentation (54KB README) | No ongoing public development visible |
| MIT licensed | AI co-authored -- quality verification unclear |
| Credible author (GitHub Star, cybersecurity background) | Requires multiple API keys and Supabase setup |
| Modular TypeScript architecture | No analytics dashboard or CRM integration |
| Hallucination detection for web search results | Large codebase for a WhatsApp bot (~190KB source) |
| Bot detection algorithm for join requests | Express 5.2.1 (relatively new, less battle-tested) |

## Recommendation

Logan is a well-engineered passion project from a credible developer with genuine niche appeal. If you are managing Hebrew-speaking WhatsApp groups, especially those requiring Shabbat observance, this is the only open-source solution that addresses your specific needs. The multi-LLM architecture is cost-effective and thoughtful.

However, three factors warrant caution:
1. **Ban risk**: Baileys is unofficial. WhatsApp can and does ban accounts using unofficial APIs.
2. **Single-commit opacity**: The entire codebase was dumped at once from a private repo. There is no public development history, no test suite, and no CI/CD. You are trusting a sanitized snapshot.
3. **No community**: 47 stars and 19 forks in 6 days is promising, but with zero Reddit/Twitter/LinkedIn discussion, there is no community to support you if things break.

**Best for**: Hebrew-speaking community admins who need AI-powered group management with Shabbat awareness and are comfortable self-hosting and accepting WhatsApp ban risk.

**Not suitable for**: Business-critical WhatsApp automation (use official Business API), non-technical users (complex setup), or anyone needing guaranteed account safety.

## Sources

### GitHub
- https://github.com/hoodini/whatsapp-public-logan
- https://github.com/hoodini
- https://github.com/hoodini/ai-agents-skills

### Author
- https://yuv.ai/
- https://x.com/yuvalav
- https://il.linkedin.com/in/yuval-avidani-87081474
- https://dev.to/yuval_avidani_d8354e6f91a
- https://www.youtube.com/@yuv-ai

### Ecosystem
- https://github.com/EvolutionAPI/evolution-api
- https://github.com/mruniquehacker/Knightbot-MD
- https://github.com/WhiskeySockets/Baileys

### Reddit (Broader Ecosystem)
- https://www.reddit.com/r/node/comments/1j4wczu/baileys_whatsapp_bot/
- https://www.reddit.com/r/selfhosted/comments/1l948ov/showoff_i_built_an_opensource_selfhosted_whatsapp/
- https://www.reddit.com/r/automation/comments/1ldf76c/whats_the_best_way_to_build_a_whatsapp_bot_in_2025/

---
*Generated by Research Agent on 2026-02-19*
