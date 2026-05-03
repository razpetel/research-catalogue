---
topic: Nano Banana Pro Prompts Recommend Skill
slug: nano-banana-pro-prompts-recommend-skill
date: 2026-03-18
sources: [github, reddit, twitter, linkedin, web]
---

# Nano Banana Pro Prompts Recommend Skill — Research Report

## Overview

The **nano-banana-pro-prompts-recommend-skill** is an open-source AI agent skill by YouMind-OpenLab that provides intelligent prompt recommendation from a library of 10,000+ curated Nano Banana Pro (Google Gemini) image generation prompts. Created in January 2026, it has quickly gained 1,249 GitHub stars and 123 forks. The skill works as a plugin for Claude Code, OpenClaw, Cursor, Codex, and Gemini CLI — users describe what image they need in natural language and the skill returns the top 3 matching prompts with sample images, ready to paste into any image generation model.

The skill is part of a broader ecosystem built by YouMind-OpenLab (the open-source arm of YouMind.com, an AI content creation platform). Their flagship repo, awesome-nano-banana-pro-prompts, holds 9,260 stars and serves as the world's largest curated Nano Banana Pro prompt gallery. The recommend-skill wraps this data in an agent-friendly interface with semantic search, content remix (paste an article → get a matching prompt), and multi-language support. Prompts are auto-synced from YouMind's PayloadCMS backend twice daily via GitHub Actions.

The Nano Banana Pro prompt ecosystem on Reddit and LinkedIn is thriving — multiple posts with hundreds of upvotes share curated prompt collections, prompting guides, and use-case-specific recommendations. The skill itself was announced on r/GeminiAI and r/ClaudeAI with moderate engagement. While sentiment is generally positive, users note that Google's transition from Nano Banana Pro to Nano Banana 2 has introduced safety filter friction, and not all prompts work equally well.

## Technical Analysis

**Architecture:** The skill follows a SKILL.md-based pattern standard in the Claude Code/OpenClaw ecosystem. The 16KB SKILL.md file contains complete agent instructions — category signal mapping, token-efficient search via grep (never loads full JSON files), a 5-step workflow (auto-update → clarify → search → present → remix), and mandatory sample image display. The `references/` directory holds categorized JSON files (social-media-post.json being the largest at 6,382 prompts), with a manifest.json for dynamic category discovery.

**Stack:** TypeScript, pnpm, Node.js 20+. Dependencies are minimal (dotenv, qs-esm). A postinstall hook (`scripts/setup.js`) auto-downloads prompt references from GitHub on install. A `--check` flag determines if references are stale (>24h) and silently updates. The `generate-references.ts` script fetches from a PayloadCMS API (requires CMS_HOST and CMS_API_KEY secrets).

**Prompt categories** (11 categories, dynamically loaded from manifest):
- Social Media Post: 6,382 prompts
- Product Marketing: 3,709 prompts
- Profile / Avatar: 744 prompts
- Others: 677 prompts
- Infographic / Edu Visual: 359 prompts
- Poster / Flyer: 345 prompts
- Game Asset, Comic/Storyboard, E-commerce: ~215 each
- YouTube Thumbnail: 117, App/Web Design: 116

**Open PR #1** adds defense-tech and technical-diagram categories (30 new prompts) — first external contribution.

**Concerns:**
- No test coverage
- Heavy keyword stuffing in package.json (30 keywords targeting every major image model name)
- Prompt data flows from a proprietary CMS; community can't directly contribute to the source dataset — they contribute via YouMind.com or X, and YouMind curates
- Git history is dominated by automated twice-daily reference update commits

## User Sentiment

**Overall:** Positive

- **Reddit:** Enthusiastic adoption across 9+ subreddits. r/GeminiAI is the epicenter. Users praise the organization and sample images. Complaints center on Google's model transitions breaking existing prompts, and variable prompt quality ("I tested 100+ and narrowed to 74 that actually work"). The skill's launch post on r/ClaudeAI and r/GeminiAI received moderate but positive engagement.
- **Twitter/X:** Nano Banana Pro prompts are widely shared on X (the primary source of curated prompts), but the skill itself has minimal direct X discussion. X functions as the upstream content source rather than a conversation venue for this tooling.
- **LinkedIn:** Content creators and marketers share Nano Banana Pro prompt tips. Influencers like Allie K Miller and Jafar Najafov have posted about Nano Banana Pro techniques. The tool is positioned as a creative productivity hack, not enterprise infrastructure.

## Competitive Landscape

The skill operates in the emerging "AI agent skills/plugins" space, specifically for image prompt curation:

| Competitor | Positioning | Key Difference |
|------------|------------|----------------|
| zerolu/awesome-nanobanana-pro | Static awesome list | No agent integration, manual browsing only |
| picotrex/awesome-nano-banana-images | Curated gallery | Smaller (16 snippets), image-focused |
| Independent gists (e.g., kousen) | One-off Claude Code skills | Single gists, not backed by a 10K+ library |
| YouMind-OpenLab/ai-image-prompts-skill | Model-agnostic sibling | Same library, positioned for non-Gemini models |
| Manual X/Twitter browsing | Direct prompt discovery | Unstructured, time-consuming, no agent integration |

YouMind-OpenLab has a strong moat: they control the largest curated dataset (10,000+ prompts with images) and have both the static gallery (awesome list) and the smart agent interface (this skill). The twice-daily automated sync creates a living library that static competitors can't match.

## Pros and Cons

| Pros | Cons |
|------|------|
| Massive curated library (10,000+ prompts with sample images) | No test coverage |
| Token-efficient grep-based search — works in context-limited agents | Proprietary CMS backend — community can't directly contribute to source |
| Multi-platform support (Claude Code, OpenClaw, Cursor, Codex, Gemini CLI) | Heavy SEO/keyword stuffing suggests growth-hacking mindset |
| Twice-daily automated updates — always current | Nano Banana Pro → Nano Banana 2 transition may break older prompts |
| Content remix mode — paste article, get custom prompt | Attribution footer is mandatory in every response — promotional |
| Free and open source (MIT) | Prompt quality is variable — not all 10K+ prompts are tested |
| Backed by a strong parent ecosystem (9,260-star awesome list) | Only 1 external contribution (PR #1) — not yet a true community project |
| Well-structured SKILL.md with clear agent instructions | Prompts are Nano Banana Pro-optimized; "works with other models" is secondary |

## Sources

### GitHub
- https://github.com/YouMind-OpenLab/nano-banana-pro-prompts-recommend-skill
- https://github.com/YouMind-OpenLab/awesome-nano-banana-pro-prompts
- https://github.com/YouMind-OpenLab

### Reddit
- https://www.reddit.com/r/GeminiAI/comments/1qj1bod/
- https://www.reddit.com/r/ClaudeAI/comments/1qj1hse/
- https://www.reddit.com/r/GeminiAI/comments/1piyqpa/
- https://www.reddit.com/r/PromptEngineering/comments/1pid4cs/
- https://www.reddit.com/r/GeminiAI/comments/1q2puu2/
- https://www.reddit.com/r/ThinkingDeeplyAI/comments/1pw6ng1/

### LinkedIn
- https://www.linkedin.com/posts/jafarnajafov_this-is-how-you-get-100-accuracy-in-nano-activity-7404570466017046529-9yus
- https://www.linkedin.com/posts/mike-futia-108709126_claude-code-nano-banana-2-is-fcking-cracked-activity-7433626247869526016-SIMA
- https://www.linkedin.com/pulse/top-10-viral-nano-banana-pro-prompts-use-case-transform-your-qsluf

### Web
- https://agentskills.so/skills/youmind-openlab-nano-banana-pro-prompts-recommend-skill-nano-banana-pro-prompts-recommend-skill
- https://playbooks.com/skills/youmind-openlab/nano-banana-pro-prompts-recommend-skill/nano-banana-pro-prompts-recommend-skill
- https://context7.com/youmind-openlab/nano-banana-pro-prompts-recommend-skill
- https://youmind.com/nano-banana-pro-prompts

---
*Generated by Research Agent on 2026-03-18*
