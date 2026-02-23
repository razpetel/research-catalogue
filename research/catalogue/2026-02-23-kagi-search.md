# Kagi Search

**Date**: 2026-02-23
**Sentiment**: Positive

## Overview

Kagi Search is a premium, ad-free search engine founded in 2018 by Vladimir Prelovac (ex-WordPress ecosystem) and headquartered in Palo Alto, California. The core thesis is radical: make the user the customer instead of the product. You pay $10/month, Kagi delivers clean search results with no ads, no tracking, and no algorithmic manipulation for advertiser benefit. With 65,564 subscribers and 1M+ daily queries as of February 2026, Kagi occupies a small but passionate niche -- The Verge calls it "a better search engine than Google," and Ars Technica declared they'd "dumped Google's enshittified search" for it.

## Key Statistics

| Metric | Value |
|--------|-------|
| Subscribers | 65,564 (up from 50K mid-2025) |
| Daily Queries | 1M+ |
| Founded | 2018 |
| Founder/CEO | Vladimir Prelovac |
| Funding | Self-funded (no VC) |
| GitHub Repos | 25 public repos (kagisearch org) |
| Top Repo Stars | smallweb (1,177), kite-public (930), pyllms (820) |
| MCP Server Stars | 303 (kagimcp) |

## Pricing

| Plan | Price | Searches | AI Features |
|------|-------|----------|-------------|
| Trial | Free | 100 | Limited |
| Starter | $5/mo | 300 | Basic AI |
| Professional | $10/mo | Unlimited | AI interactions |
| Ultimate | $25/mo | Unlimited | Premium models (Claude, GPT-4o, Gemini, DeepSeek) |
| Family | ~$15/mo | 6 seats | Shared |

Kagi frames this against Google's hidden cost: an estimated $277/year in ad revenue extracted per user. At $120/year, the Professional plan is "cheaper than free."

## Product Ecosystem

Kagi has expanded well beyond search into a privacy-first internet platform:

1. **Kagi Search** -- Core premium search engine with domain ranking, lenses, bangs, Privacy Pass
2. **Kagi Assistant** -- Multi-LLM AI assistant (Claude, GPT-4o, Gemini, DeepSeek) with web search integration; switchable models per query
3. **Kagi Translate** -- Privacy-focused translation app for iOS/Android (launched Feb 5, 2026); Fast Company: "like Google Translate--plus privacy"; Reddit: "one of the most exciting tools I've come across"
4. **Kagi Kids** -- Child-safe search
5. **Orion Browser** -- Native WebKit browser for macOS/iOS (Chrome extensions supported)
6. **Kite** -- Open-source news app (930 GitHub stars, 63 open issues)
7. **Small Web** -- Curated index of personal/indie websites (1,177 stars); the anti-SEO initiative
8. **FastGPT** -- Fast AI summaries via API

## Key Differentiating Features

- **Zero ads, zero tracking**: Revenue exclusively from subscriptions -- no external shareholders
- **Domain ranking/blocking**: Users can boost, lower, or permanently block specific domains; after blocking "a few hundred" SEO-spam sites, results improve dramatically
- **Lenses**: Category-based result filtering (programming, news, forums, academic)
- **Bangs**: Quick redirects to other search engines (!g for Google, !w for Wikipedia)
- **Privacy Pass**: Use Kagi Search without revealing identity (cryptographic approach)
- **Small Web integration**: Actively surfaces personal websites and indie blogs over corporate content
- **Auto Quick Answer**: AI-powered summaries (crucially, can be disabled -- unlike Google's forced AI Overviews)
- **100 free trial searches**: No credit card required to start

## Community Sentiment

### What Users Love

The consistent theme across Reddit (r/SearchKagi, r/degoogle, r/privacy), The Verge, and Ars Technica is relief:

- "Using Kagi Search was this feeling of relief from Google's awful results"
- "I'm still using Kagi, and it's hard to imagine switching back" (The Verge)
- "It does filter out SEO better than Google does" (Reddit)
- "The search engine equivalent of a Honda Civic: reliable, unobtrusive" (Nieman Lab)
- "Best thing out there in web search right now" (r/browsers)

Kagi surfaced HouseFresh (independent product reviews) at position 1 where Google buried it at position 64 -- a concrete example of how incentive alignment produces different results.

### What Users Criticize

- **Price barrier**: "I truly cannot understand why someone would pay $10 a month for search" -- the fundamental adoption challenge
- **$5 Starter plan is broken**: 300 searches/month is "not enough" for anyone who discovered Kagi, burning through in days for researchers
- **Non-English/local weakness**: "Quite bad for local searches and searches in different languages" -- English-Anglosphere bias
- **Limited result depth**: Only 20-80 results per query vs Google's hundreds; problematic for deep research
- **"Unlimited" AI is not unlimited**: Ultimate plan has a fair use policy; heavy users get contacted
- **AI features tension**: Some subscribers "really dislike their ethos around AI" -- they pay for search quality, not AI
- **Kagi News AI summaries unreliable**: "No, you can't trust them" -- GitHub and forums document many incorrect examples
- **Assistant hallucinations**: Search results injected into LLMs can propagate errors across models
- **PCMag dropped Kagi** from their 2026 recommended alternatives list (Dec 2025) -- community suspects editorial/payment reasons

### The Inversion Paradox

Kagi revealed a counterintuitive cost structure: "Search costs them more to operate than AI does" -- search queries are 10-100x more expensive than AI operations. Users who only search (no AI) are the most expensive to serve, inverting the common assumption that AI is the cost driver.

## GitHub & Developer Ecosystem

The kagisearch GitHub organization hosts 25 public repos, signaling a company that builds in the open despite being a paid product:

| Repository | Stars | Purpose |
|-----------|-------|---------|
| smallweb | 1,177 | Curated small website index |
| kite-public | 930 | Open-source news app |
| pyllms | 820 | Multi-LLM Python library (MIT) |
| vectordb | 782 | Minimal vector DB for text (MIT) |
| kagi-docs | 359 | Product documentation (574 forks) |
| bangs | 319 | Community-driven search bangs (MIT) |
| kagimcp | 303 | Official MCP server (MIT) |
| fastfeedparser | - | High-performance RSS parser |
| ask | - | CLI for AI queries via OpenRouter |

**MCP Server (kagimcp)**: 303 stars, supports Claude Desktop, Claude Code, and Codex CLI. However, the Search API is in **closed beta** (request access via support@kagi.com), and the repo has not been updated since November 2025. The MCP server provides search and summarizer tools with configurable summarization engines.

**Notable development**: Draft PRs for webmaster tools and crawler/indexer documentation suggest Kagi is building out its own index infrastructure, reducing dependence on external index providers.

## Competitive Position

| Engine | Index | Cost | Privacy | AI | Best For |
|--------|-------|------|---------|-----|---------|
| **Kagi** | Hybrid (own + external) | $5-25/mo | No tracking | Multi-LLM Assistant | Power users, researchers, developers |
| Google | Proprietary | Free (ads) | Full tracking | Gemini forced | General population, local/maps |
| DuckDuckGo | Bing-based | Free | No tracking | Limited | Privacy-conscious free users |
| Brave Search | Independent (30B+) | Free | No tracking | Leo AI | Privacy + independence |
| Perplexity | Various | Free-$20/mo | Some tracking | AI-first | AI-native research |
| Startpage | Google-proxied | Free | No tracking | None | Google results without tracking |

**vs Google**: Better at surfacing independent content and blocking SEO spam. Weaker on local search, non-English queries, and sheer technical depth. The ad-free experience fundamentally changes the search feel.

**vs Brave Search**: The closest free competitor. Both privacy-focused, both building independent indexes. Some Reddit users report "very little difference" in results. Kagi's advantage is customization (domain blocking, lenses); Brave's advantage is free.

**vs Perplexity**: Different categories converging. Perplexity is AI-first; Kagi is search-first with AI layered on. Kagi Assistant's multi-model switching (DeepSeek for search, Claude for analysis, Gemini for counting) is unique.

## Recent Developments (2026)

- **Kagi Translate mobile apps** (Feb 5): iOS/Android launch with context-aware image translation; Fast Company and AlternativeTo coverage
- **Fastmail partnership** (Feb 9): "Friends of Kagi" program offering Fastmail customers 3 months free on Professional plan
- **Assistant reliability upgrades** (Feb 7): Improved follow-up prompts, tab switching, citation checking
- **Localization improvements**: Manual location setting for more accurate local searches
- **Google antitrust implications**: Medium analysis exploring how Google antitrust ruling could benefit Kagi if forced index access materializes
- **Google ending free Programmable Search**: Some concern about Kagi's reliance on Google index components

## Risks & Considerations

1. **Scale challenge**: 65K subscribers is tiny. The company must grow substantially to sustain infrastructure costs, but the price barrier limits mass adoption
2. **Index dependency**: Kagi functions partly as a metasearch engine aggregating from external indexes. If Google restricts access or terms change, Kagi's result quality could be affected (the crawler/indexer docs suggest they're working to mitigate this)
3. **AI feature creep**: Tension between users who pay for clean search and the company's push into AI products (Assistant, Translate, FastGPT). The "search costs more than AI" economics incentivize Kagi to push AI, potentially alienating core search purists
4. **Non-English gap**: Substantial weakness outside English-language, Anglosphere searches limits global addressable market
5. **MCP server stale**: The official MCP server (kagimcp) hasn't been updated in 3+ months, and the Search API remains in closed beta -- a notable gap given MCP's growing importance in AI workflows

## Recommendation

**For power users, researchers, and developers**: Kagi is the best search experience money can buy in 2026. The $10/month Professional plan eliminates ads, surfaces independent content, and the domain blocking/lenses customization creates a search engine that improves with use. If you search frequently and value your time over $10/month, the trial's 100 free searches should be enough to decide.

**For AI developers**: The MCP server ecosystem exists but is constrained -- Search API is in closed beta and the official server is stale. The unofficial kagi-ken-mcp (session token-based, no API needed) may be more practical. Wait for the Search API to open up before building workflows around it.

**For casual users**: The $5/month Starter plan (300 searches) is not viable for anyone who searches regularly. Either commit to the $10 Professional plan or use Brave Search (free, independent index, good privacy) as the next best option.

**For non-English users**: Evaluate carefully. Kagi's strengths are concentrated in English-language, Anglosphere searches. Local search and non-English language support remain notably weak.

**Watch for**:
- Google antitrust ruling outcomes that could mandate index access for competitors
- Kagi's own crawler/indexer development (reducing external index dependency)
- Search API opening from closed beta
- Whether the company can grow past the ~65K subscriber plateau without compromising the ad-free model

## Sources

- [Kagi Search](https://kagi.com/)
- [kagisearch GitHub Organization](https://github.com/kagisearch)
- [kagimcp - Official MCP Server](https://github.com/kagisearch/kagimcp)
- [The Verge: Kagi is a better search engine than Google](https://www.theverge.com/web/631636/kagi-review-best-search-engine)
- [Ars Technica: Dumping Google's enshittified search for Kagi](https://arstechnica.com/gadgets/2025/08/enough-is-enough-i-dumped-googles-worsening-search-for-kagi/)
- [Nieman Journalism Lab: Testing Kagi](https://www.niemanlab.org/2025/04/testing-kagi-a-premium-search-engine-for-a-broken-internet/)
- [Fast Company: Kagi Translate](https://www.fastcompany.com/91488655/kagi-translate-google-translate-alternative)
- [Fastmail + Kagi Partnership](https://www.fastmail.com/blog/safer-internet-day-why-your-search-engine-matters-more-than-you-think/)
- [Momor: Best Search Engines 2026](https://www.momor.ai/blog/best-search-engines-2026/)
- [Search Engine Journal: 25 Alternatives to Google](https://www.searchenginejournal.com/alternative-search-engines/271409/)
- [PCMag: Removed Kagi Dec 2025](https://www.pcmag.com/picks/dont-just-google-it-smarter-search-engines-to-try)
- r/SearchKagi, r/degoogle, r/privacy, r/browsers Reddit communities
- [Kagi Inc. LinkedIn](https://www.linkedin.com/company/kagi-inc)
