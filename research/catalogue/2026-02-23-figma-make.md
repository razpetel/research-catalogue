---
topic: Figma Make
slug: figma-make
date: 2026-02-23
sources: [github, reddit, twitter, linkedin, web]
---

# Figma Make Research Report

## Overview

Figma Make is the AI prototype-and-code generation tool built directly into Figma, the dominant collaborative design platform ($1.056B revenue in 2025). Launched at Config 2025 (May 2025) and powered by Anthropic's Claude 3.7 Sonnet, Make converts text prompts, screenshots, and existing Figma design frames into interactive prototypes with functional code (React/HTML). It evolved from an internal hackathon project building on Figma Sites' Code Layers infrastructure, where a designer asked: "What if static design components could become functional with AI?"

The product has become central to Figma's financial narrative. Q4 2025 earnings (reported Feb 18, 2026) showed Make's weekly active users grew 70% quarter-over-quarter, with 50%+ of customers spending over $100K ARR building in Make weekly. Figma's stock jumped 15% on these results, and analysts at Investing.com wrote that "Figma's Anthropic Integration Could Flip the SaaSpocalypse Script" -- positioning Make as proof that incumbent SaaS can monetize AI rather than being disrupted by it. The Feb 17 "Code to Canvas" partnership with Anthropic, enabling Claude Code output to flow back into editable Figma designs via Remote MCP, further cemented this narrative.

However, the designer community is deeply divided. Reddit threads consistently describe Make as "really just a strong AI prototyping tool" that "misses the point" of what makes Figma great as a design tool. The fundamental tension: Make generates code, not editable Figma design layers (that's the companion "First Draft" feature). Enterprise design organizations report that while Make handles theme colors and fonts from design systems, actual component usage is "unrecognizable." Independent reviewers score it 58/100 (Roger Wong) and describe it as "buggy, clunky, and limited to basic use cases" (LogRocket), though they acknowledge its promise.

## Technical Analysis

### Architecture & AI Model

Figma Make is powered by Anthropic's Claude 3.7 Sonnet, with additional Gemini 3 Pro integration. It accepts three input types:
- **Text prompts** for generating new prototypes from scratch
- **Screenshots/images** for converting visual references
- **Figma Design frames** that provide rich structured data (layers, metadata, styling) rather than flat images

Generated output is code-based (React/HTML with Shadcn UI components), not native Figma layers. This is the critical architectural distinction: Make produces functional prototypes you can interact with, not design files you can edit in Figma's canvas tools.

### Key Features

1. **Text-to-prototype:** Full interactive app generation from natural language prompts (~3 minutes for standard flows)
2. **Visual editing:** Point-and-click modification of specific components without re-prompting
3. **Multiplayer code editor:** Real-time collaborative code editing within Figma
4. **MCP Connectors (12+):** Pull context from external tools directly into Make:
   - Notion, Atlassian (Confluence/Jira), GitHub, Linear, Asana, monday.com
   - Amplitude (analytics), Dovetail (research), Box (enterprise content)
   - Granola (meeting notes), Marvin (feedback), zeroheight (design systems)
   - Use `@connector-name` in Make chat to pull external context
5. **Embeds:** Embed Make prototypes into Figma Design, FigJam, and Figma Slides
6. **Code to Canvas (Feb 2026):** Anthropic partnership converting Claude Code UI output into editable Figma frames via `claude mcp add --transport http figma https://mcp.figma.com/mcp`
7. **Design system integration:** Import component libraries for themed generation (limited effectiveness per community feedback)

### Related Figma AI Features

- **First Draft:** Generates editable Figma Design layers (not code) from AI prompts -- the design-native counterpart to Make
- **Figma Draw:** AI image generation within design canvas
- **Figma Sites:** Web publishing with Code Layers (Make's origin infrastructure)
- **Figma Buzz:** AI-assisted design exploration

### Evaluation Methodology (per First Round Review)

Figma developed a rigorous four-type eval process for Make quality:
- **Deterministic:** Binary pass/fail (code compilation, text shortening)
- **Taste & Judgment:** Subjective human ratings on 1-4 scale for design quality and functionality
- **AI-as-Judge:** Trained AI evaluator with human-created guidelines
- **Usage Analytics:** A/B testing model performance in production

The "Great Figma Bakeoff" (15 in-person sessions) revealed unexpected use cases and broader persona interest than the team anticipated.

### Code Quality Concerns

- Downloaded React code lacks `package.json`, making it non-functional locally (Roger Wong)
- AI makes autonomous UX decisions without user consultation (LogRocket)
- Manual edits get overwritten by subsequent AI generations
- Typography and image scaling don't match input designs faithfully
- Make files cannot be exported back to Figma Design -- a "dead end" workflow

## Pricing

### AI Credits per Plan (Monthly per Seat)

| Plan | Full Seat Credits | Cost |
|------|------------------|------|
| Starter | 500 | Free |
| Professional | 3,000 | $15/editor/mo |
| Organization | 3,500 | $45/editor/mo |
| Enterprise | 4,250 | Custom |

Dev/Collab/View seats: 500 credits across all plans.

### Credit Consumption

- **Figma Make:** ~30-100+ credits per generation (varies by complexity)
- **First Draft:** 20 credits per use
- **Image generation:** 5-25 credits
- **Free features:** AI search, rename layers, FigJam stickies

### Additional Credits (Starting March 2026)

| Tier | Credits | Monthly Cost |
|------|---------|-------------|
| Tier 1 | +5,000 | $120 |
| Tier 2 | +7,500 | $180 |
| Tier 3 | +10,000 | $240 |
| Pay-as-you-go (Q2 2026) | Variable | $0.03/credit |

Credits reset monthly and do not roll over. Full seat credit enforcement begins March 18, 2026.

## User Sentiment

**Overall: Mixed** -- business/investor enthusiasm vs. designer skepticism

### Reddit (High Confidence -- 20+ active threads)
- **Praise:** Fast prototyping for stakeholder alignment; effective for user flow communication; improving design system integration
- **Criticism:** "Figma is not a coding platform, it's a place for creative expression"; can't export to Figma Design; design system components are "unrecognizable"; not enough AI credits; AI overrides manual edits; unclear differentiation from Lovable/v0
- **Enterprise feedback:** "Fine for a quick concept, but without using our components and patterns, it was useless to make a prototype"
- **Power user view:** "I'm just going to use VS Code or Cursor with Figma MCP and build my own high fidelity prototype"

### Twitter/X
- Figma official accounts driving announcements around credit system and product updates
- Investor community very bullish on Make as AI monetization proof point
- Dylan Field (CEO): "Figma gets better as AI gets better"
- Code to Canvas partnership generated significant buzz (Feb 17)

### LinkedIn
- Professional commentary focused on Figma's financial story and AI strategy
- monday.com engineering blog detailed their custom design-to-code approach using Figma MCP (distinct from Make)
- LinkedIn Learning courses available on AI in Figma
- Limited deep technical discussion due to login walls

### Expert Reviews
- **LogRocket:** Promising but "buggy, clunky, limited to basic use cases"; AI makes UX decisions alone
- **Roger Wong:** 58/100; "wouldn't use it for any actual work" but acknowledges potential
- **Aakash Gupta:** "Buttery smooth...generated UIs look polished, not like generic AI output"
- **Forrester (Config 2025):** "In an AI world, design matters more than ever"
- **First Round Review:** Praised eval methodology; team culture of role-blending (designers coding, PMs prototyping)
- **TechBullion (Feb 23, 2026):** "Easiest AI tool to adopt if your team already designs in Figma"

## Financial Context

| Metric | Value |
|--------|-------|
| Figma FY 2025 Revenue | $1.056B |
| Q4 2025 Revenue | $303.8M (40% YoY) |
| FY 2026 Guidance | $1.37B (30% growth) |
| Net Dollar Retention | 136% |
| Adjusted Gross Margin | 86% |
| Customers >$1M ARR | 67 |
| Make WAU Growth (Q4 QoQ) | 70%+ |
| >$100K Customers Using Make Weekly | 50%+ |
| Make WAU Also Using Figma Design | 80% |
| Paid >$10K Customers Using AI Credits | ~75% weekly |
| Stock Price (post-earnings) | ~$25 (+15%) |

The 80% cross-usage stat (Make users also using Figma Design) is strategically critical -- it shows Make isn't cannibalizing the core product but driving deeper engagement. However, RBC Capital lowered its target to $31 (Sector Perform), noting AI risk remains despite growth.

## Competitive Landscape

```
                    Design Control (Native Layers)
                           ^
                     First Draft
                    /         \
            Figma Design    Visily
              /                    \
         UX Pilot ←——————————————→ Figma Make
              \                    /
            Uizard          v0/Stitch
                    \         /
                     Lovable/Bolt
                           v
                    Code Generation
```

### Direct Competitors

| Tool | Key Difference | Pricing |
|------|---------------|---------|
| **Google Stitch** | Free (350 gen/mo), Gemini 3-powered, no design ecosystem lock-in | Free |
| **v0 (Vercel)** | React/Next.js-focused, superior code quality, developer-first | $0-30/mo |
| **Lovable** | Full-stack app generation including backend | $20+/mo |
| **Bolt** | Full-stack, more autonomous | $20+/mo |
| **Framer AI** | Live deployable websites, not app prototypes | EUR15-75/mo |
| **Cursor + Figma MCP** | Developer-controlled, reads Figma designs, generates in IDE | $20/mo |

### Make's Unique Advantages
1. **Native Figma integration:** 80%+ of designers already use Figma
2. **Design context richness:** Receives structured layer/metadata data, not just screenshots
3. **MCP connector ecosystem:** 12+ verified integrations pulling PRDs, tickets, research
4. **Code to Canvas pipeline:** Bidirectional flow between AI code and design (unique with Anthropic)
5. **Multiplayer collaboration:** Real-time co-editing built into the platform

### Make's Disadvantages vs. Competitors
1. **Not editable design layers:** Output is code, not Figma frames (First Draft partially addresses this)
2. **Credit-gated:** 3,000 credits/mo on Pro vs. Stitch's free 350 generations
3. **Code quality:** Missing package.json, AI overrides manual edits
4. **Design system handling:** Components not faithfully reproduced
5. **Closed ecosystem:** Can't export Make files back to other Figma products

## Pros and Cons

| Pros | Cons |
|------|------|
| Native to the dominant design platform (80%+ market share) | Generates code, not editable Figma layers |
| 70% QoQ WAU growth showing real adoption | 58/100 expert review score; "wouldn't use for actual work" |
| 12+ MCP connectors for contextual prototyping | Enterprise design systems poorly handled ("unrecognizable") |
| Multiplayer code editing and collaboration | Credit system too restrictive (3,000/mo Pro) |
| Code to Canvas with Anthropic (bidirectional flow) | AI makes autonomous UX decisions, overrides manual edits |
| 80% cross-usage with Figma Design | Code export lacks package.json, non-functional locally |
| Backed by $1B+ company with 86% gross margins | "Dead end" workflow -- can't return to Design canvas |
| Claude 3.7 Sonnet produces polished UI output | Blurs Figma's identity away from design-first tool |

## Recommended Workflow

For teams already in Figma:
1. **First Draft** (editable layers) for exploring design concepts
2. **Figma Make** (interactive code) for stakeholder demos and flow validation
3. **MCP Connectors** to pull PRD context from Notion/Jira/Linear
4. **Code to Canvas** to round-trip Claude Code output back to design
5. **Figma Design** for production-quality refinement

For developers:
1. **Claude Code + Figma MCP** (`claude mcp add --transport http figma https://mcp.figma.com/mcp`) for implementation
2. **Code to Canvas** to send implementations back to design review

## Sources

### News & Financial
- [CNBC: Figma stock jumps 15% on AI monetization](https://www.cnbc.com/2026/02/18/figma-fig-q4-earnings-report-2025.html)
- [CNBC: Figma partners with Anthropic for Code to Canvas](https://www.cnbc.com/2026/02/17/figma-anthropic-ai-code-designs.html)
- [Reuters: Figma jumps as AI push boosts design spending](https://www.reuters.com/business/figma-jumps-ai-push-boosts-software-design-spending-2026-02-19/)
- [Investing.com: Figma's Anthropic Integration Could Flip the SaaSpocalypse Script](https://investing.com/analysis/figmas-anthropic-integration-could-flip-the-saaspocalypse-script-200675400)
- [Diginomica: Figma crosses $1B revenue](https://diginomica.com/figma-crosses-1-billion-revenue-its-whos-doing-designing-matters)
- [Motley Fool: Figma vs Adobe AI stock comparison](https://www.fool.com/investing/2026/01/29/better-ai-software-stock-figma-vs-adobe/)
- [Motley Fool: Beaten-Down Figma Shares Rebound](https://www.fool.com/investing/2026/02/23/beaten-down-figma-shares-rebound-stock-buy/)
- [TradingNews: FIG Stock Forecast](https://tradingnews.com/news/figma-stock-price-forecast-fig-at-25-usd-40-percent-growth-ai-tailwind)
- [Alex Heath/Sources: Figma's answer to the AI software sell-off](https://sources.news/p/figmas-answer-to-the-ai-software)
- [Techbuzz: Figma stock soars on AI revenue breakthrough](https://www.techbuzz.ai/articles/figma-stock-soars-16-on-ai-revenue-breakthrough)

### Reviews & Analysis
- [LogRocket: I tried Figma Make -- here's what it gets right and what's still broken](https://blog.logrocket.com/ux-design/figma-make-review/)
- [Roger Wong: Figma Make -- Great Ideas, Nowhere to Go (58/100)](https://rogerwong.me/2025/05/figma-make-great-ideas-nowhere-to-go/)
- [First Round Review: How Figma Put People at the Center of its AI Eval Process](https://review.firstround.com/figma-ai-eval-process/)
- [Creator Economy: Figma's AI Prototyping Tool is Here](https://creatoreconomy.so/p/figmas-make-ai-prototyping-tool-is-here)
- [Aakash Gupta: Figma Just Launched an AI Prototyping Tool. It Might Kill the Competition](https://aakashgupta.medium.com/figma-just-launched-an-ai-prototyping-tool-it-might-kill-the-competition-d183d906172d)
- [Banani: Figma Make AI Tool Review](https://www.banani.co/blog/figma-make-ai-tool)
- [Geeky Gadgets: Build a Pro AI Design System Using Figma Make](https://www.geeky-gadgets.com/minimum-viable-ai-design-system/)
- [TechBullion: 12 Best AI Tools for UI/UX Design 2026](https://techbullion.com/12-best-ai-tools-for-ui-ux-design-2026-guide-for-modern-product-teams/)
- [Forrester: Figma Config 2025 -- Design Matters More Than Ever](https://www.forrester.com/blogs/figma-config-2025-in-an-ai-world-design-matters-more-than-ever/)
- [InfoQ: How Figma Uses AI to Support, Not Replace, the Designer](https://www.infoq.com/news/2025/08/figma-ai/)

### Official Figma
- [Figma: How AI Credits Work](https://help.figma.com/hc/en-us/articles/33459875669015-How-AI-credits-work)
- [Figma: Updates to AI Credits](https://www.figma.com/blog/updates-to-ai-credits-in-figma/)
- [Figma: Introducing Make Embeds](https://www.figma.com/blog/introducing-figma-make-embeds/)
- [Figma: Connect External Tools Using Make Connectors](https://help.figma.com/hc/en-us/articles/35440096186007-Connect-external-tools-using-Figma-Make-connectors)
- [Figma: Pricing](https://www.figma.com/pricing/)
- [Wikipedia: Figma](https://en.wikipedia.org/wiki/Figma)

### Reddit Discussions
- [Figma Make: Another AI prototype builder and everything wrong about it](https://www.reddit.com/r/FigmaDesign/comments/1n2rh2x/)
- [What do you think of Figma's AI push?](https://www.reddit.com/r/FigmaDesign/comments/1n4q59w/)
- [How to prepare design system library for AI](https://www.reddit.com/r/FigmaDesign/comments/1mh87m1/)
- [Enterprise Figma AI Tools](https://www.reddit.com/r/UXDesign/comments/1ouu07z/)
- [Figma Make doesn't provide enough AI credits](https://www.reddit.com/r/FigmaDesign/comments/1piq4oj/)
- [I tried building prototype with Figma Make -- it's useless](https://www.reddit.com/r/FigmaDesign/comments/1mq0cqj/)
- [Who is using Figma Make?](https://www.reddit.com/r/FigmaDesign/comments/1obkktj/)
- [Anyone actually using Figma Make for design output?](https://www.reddit.com/r/FigmaDesign/comments/1qfj8w4/)
- [How to design the project generated by Figma Make AI?](https://www.reddit.com/r/FigmaDesign/comments/1msww31/)

### GitHub
- [figma/mcp-server-guide](https://github.com/figma/mcp-server-guide)
- [GLips/Figma-Context-MCP](https://github.com/GLips/Figma-Context-MCP)

---
*Generated by Research Agent on 2026-02-23*
