---
topic: Alex Christou - 30 Apps in 30 Days
slug: alex-christou-30-apps
date: 2026-02-19
sources: [github, reddit, twitter, linkedin, web]
---

# Alex Christou: 30 Apps in 30 Days Research Report

## Overview

Alex Christou (@alexchristou_) is a Brighton, UK-based product builder and content creator who ran a "30 apps in 30 days" challenge in August-September 2025, documenting every day on YouTube and Twitter. Previously a Growth Product Manager at VEED.IO ($40M ARR video editing platform) and a 4x hackathon winner, he brings a product-growth lens to vibe coding that distinguishes him from the typical developer-influencer archetype. Rather than optimizing for GitHub stars or open-source contributions, Christou ships live, deployed products on custom domains -- then films himself doing it.

The challenge produced a portfolio of 30+ micro-apps spanning SEO tools, AI content generators, meditation apps, writing productivity tools, AI agent marketplaces, and a Claude Code sentiment tracker. Notable standouts include RawTyping.com (a pressure-writing app that deletes your words if you stop typing), ContentUAV.com (an AI blog writer designed to rank on Google rather than produce "one-shot slop"), and a vibe-coded Opus Clip replacement that he claims saves $600/year. Day 8's failed logo generator and Day 9's deployment nightmare are documented with the same honesty as the wins, which is the content's key differentiator -- authentic build-in-public with real failures.

Post-challenge, Christou has evolved into an educator and tool ecosystem builder. He co-instructs the "4x4 Bootcamp" on Starter Story with Pat Walls ($495, ship 4 apps in 4 weeks, 3,000+ builder community), teaches an iOS Bootcamp, and has built an automated content pipeline using Remotion + Claude Code to auto-generate product videos, publish to YouTube, and link to blog posts. The tweet that triggered this research (Feb 12, 2026) showcases this pipeline: "Remotion keeps impressing me man. Auto generated in Claude Code with Remotion, published to youtube automatically and linked up with my blog post." This represents the maturation of the Remotion + Claude Code workflow our earlier research tracked.

## Technical Analysis

### Tech Stack
Christou's stack is pragmatic and modern, optimized for speed-to-ship:

| Layer | Tools |
|-------|-------|
| AI Coding | Claude Code (primary), Cursor (secondary) |
| Backend | Convex (primary), Supabase |
| Frontend | React/Next.js, Vercel deployment |
| AI APIs | OpenAI, Nano Banana (image gen) |
| Video | Remotion + Claude Code skill |
| Auth/Payments | Clerk + Stripe (when needed) |

### Development Approach
His approach is product-growth-driven vibe coding:
1. **Idea validation via SEO:** Find what people search for on Google (his Day 1 app is literally a tool for this)
2. **Rapid build:** Claude Code as primary tool, Plan Mode ("shift tab, measure twice or 5 times"), dual-window workflow
3. **Deploy daily:** Vercel for web, Expo for mobile, custom domains
4. **Film everything:** YouTube video per day during challenge
5. **Growth:** SEO, content marketing, Remotion-generated videos

### Key Technical Insights (from his 15 Claude Code tips)
1. Supabase MCP makes database work "10x easier"
2. Dual-wield Claude Code windows (run two instances simultaneously)
3. Plan Mode before implementation ("Shift tab")
4. $2K+ in Claude Code credits spent developing these practices
5. File-scoping: "Only modify [specific file]. Do not touch anything else unless you ask first."

### GitHub Presence
Minimal -- only 2 old repos (running-diary from 2021, BlackBerry-10-apps from 2012) with 0 stars. This is intentional: Christou is a product builder, not an OSS contributor. All 30+ apps are deployed as live products, not open-sourced.

## User Sentiment

**Overall:** Positive (with limited sample size)

- **Twitter:** Growing audience with authentic build-in-public narrative. Pieter Levels (@levelsio) reposted his Day 17 content -- significant validation from the indie hacker community's most prominent figure. His product-growth analysis tweets (Claude Code's Christmas "gift a free pass" growth lever) show industry-level thinking.

- **Reddit:** One identified post on r/vibecoding ("Vibe coded 30+ apps. Here's how I avoid debugging nightmares") with practical tips. Not yet mentioned in the popular "Best Claude Code YouTubers" threads on r/ClaudeAI, suggesting his audience skews more toward builders/entrepreneurs than developer-tool enthusiasts.

- **LinkedIn:** Professional background verified: Growth Product Manager at VEED.IO, Reforge member (Senior PM), hackathon track record confirmed (2nd place at Nuitee hackathon with VEED colleagues, building "Surf Now" app for EUR 5,000).

- **Starter Story Bootcamp Reviews:** Trustpilot reviews for Starter Story mention the bootcamp as "a gamechanger" that took participants "from tinkering with AI builds to deploying real working apps."

## Competitive Landscape

Christou occupies a specific niche: **the product-growth-minded vibe coder who documents the messy middle.** His position relative to comparable figures:

| Creator | Audience | Focus | Differentiator |
|---------|----------|-------|----------------|
| **Alex Christou** | Growing (small-medium) | Ship-first product building | Product growth background, daily documentation, honest failures |
| **Alex Finn** | Larger YouTube | Non-coder vibe coding | Vibe Coding Academy ($297), "number 1 vibe coding channel" claim |
| **Cole Medin** | Large (26K+ stars) | Methodology/frameworks | PIV Loop, more technical/structured |
| **Pieter Levels** | Massive | Indie hacking | Icon of the movement, endorsed Alex |
| **Pat Walls** | Large (Starter Story) | Business/entrepreneurship | Alex's bootcamp partner, platform provider |

### Key Differentiator
Most Claude Code content creators focus on either:
- **Technical workflows** (superpowers, skills, hooks) -- the "how to use Claude Code better" niche
- **Hype content** ("I built X in Y minutes") -- clickbait without substance

Christou sits between these: he uses Claude Code as a means to an end (shipping products), documents failures as honestly as wins (Day 8-9 crisis), and applies product-growth thinking (SEO-driven idea validation, Fiverr for inspiration, automated video pipelines).

## The 30 Apps Challenge: Selected Portfolio

| Day | App | Description | Status |
|-----|-----|-------------|--------|
| 1 | BuildSomethingPeopleSearchFor.com | SEO-driven idea validator | Live |
| 2 | ContentUAV.com | AI blog writer that ranks on Google | Live |
| 3 | Claude Cave Timer | Deep work timer for Claude Code users | Live |
| 4 | tryNSDR.vercel.app | NSDR meditation app | Live |
| 5 | NameGameStrong.com | Name generator | Live |
| 7 | RawTyping.com | Pressure writing (deletes words if you stop) | Live |
| 8 | Logo generator | Failed -- 10 hours, 6 AI models, 0 good logos | Failed |
| 16 | PullClips | Opus Clip replacement (saves $600/yr) | Live |
| 17 | FiveAgents | Fiverr for AI agents | Live |
| 19 | Claude Vibe Check | Claude Code sentiment tracker (scrapes Reddit) | Live |
| 22 | 5 micro marketing apps | One-shot in single prompt | Live |

### Post-Challenge Pipeline (Jan-Feb 2026)
- Revenue review: "6 projects: Here's the numbers" (Jan 23, 2026)
- Remotion + Claude Code automated video generation
- YouTube auto-publishing + blog post integration
- Starter Story 4x4 Bootcamp co-instruction
- iOS Bootcamp teaching

## Connection to Remotion Research

The triggering tweet (Feb 12, 2026) provides real-world evidence for our earlier Remotion research findings:

| Our Prior Finding | Alex's Experience |
|-------------------|-------------------|
| "10-30 min simple promos, 1-2 hrs polished" | "incredible out of the box, but takes quite a bit of back and forth to go from 60% to 100%" (Jan 25) |
| Second-gen ecosystem emerging | Auto-publishing to YouTube, blog integration pipeline |
| Moving from demos to real product videos | Using for actual content pipeline, not just demos |
| Remotion founder tempering expectations | Alex's assessment aligns: great but not instant |

## Pros and Cons

| Pros | Cons |
|------|------|
| Authentic build-in-public with real failures | Limited audience size compared to top creators |
| Product-growth background adds unique lens | No open-source contributions (can't evaluate code quality) |
| Practical, actionable Claude Code tips | Revenue numbers from challenge apps not publicly confirmed |
| Daily documentation builds comprehensive resource | Bootcamp ($495) may not differentiate enough from free content |
| Pieter Levels endorsement signals quality | Reddit/community visibility still nascent |
| Post-challenge evolution shows sustained trajectory | Some apps appear to be simple MVPs with unclear longevity |

## Sources

### Twitter/X
- https://x.com/alexchristou_
- https://x.com/alexchristou_/status/2022009787664544051 (triggering tweet)
- https://x.com/alexchristou_/status/1949870632524533939 (15 Claude Code tips)
- https://x.com/alexchristou_/status/1957806711563227497 (Day 1)
- https://x.com/alexchristou_/status/1961018518729564264 (Day 9)
- https://x.com/alexchristou_/status/1963913724890058820 (Levels repost)
- https://x.com/alexchristou_/status/1965809074974425276 (Day 22)
- https://x.com/alexchristou_/status/2015533282687901918 (Remotion assessment)
- https://x.com/alexchristou_/status/2008094210545586413 (Claude Code growth analysis)

### YouTube
- https://www.youtube.com/channel/UCHPNbnWIZ5gTqU4k863hzNQ
- https://www.youtube.com/watch?v=wGMyIM2X-g0 (How I'm growing my apps)
- https://www.youtube.com/watch?v=uqDyU0npM_4 (Day 9 broke me)
- https://www.youtube.com/watch?v=EKoNqvdCUe8 (Hackathon stack)
- https://www.youtube.com/watch?v=JO7J2OAXHPY (RawTyping - Day 7)

### Web
- https://www.alexchristou.co.uk/
- https://www.stener.co.uk/
- https://build.starterstory.com/build/4x4-bootcamp
- https://www.producthunt.com/@alexchristou17

### Reddit
- https://www.reddit.com/r/vibecoding/comments/1qwo1qt/

### LinkedIn
- https://www.linkedin.com/in/alex-christou-80a719261
- https://www.reforge.com/profiles/alex-christou

### GitHub
- https://github.com/alexchristou

---
*Generated by Research Agent on 2026-02-19*
