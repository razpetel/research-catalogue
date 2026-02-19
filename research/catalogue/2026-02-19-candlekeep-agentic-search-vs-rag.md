# CandleKeep: Agentic Search vs RAG

> A knowledge library for AI agents that deliberately avoids RAG in favor of agentic search -- letting models browse, read, and follow threads like human researchers.

| Field | Value |
|-------|-------|
| **Date** | 2026-02-19 |
| **Author** | Sahar Carmel (Director of AI Enablement, Mixtiles) |
| **Source** | [Squid Club Blog](https://www.squid-club.com/blog/why-candlekeep-doesn-t-use-rag-and-why-that-s-the-point) |
| **Product** | [getcandlekeep.com](https://www.getcandlekeep.com/) |
| **Category** | AI Agent Knowledge Infrastructure |
| **Sentiment** | Mixed -- strong thesis, invisible product |

---

## Overview

CandleKeep is a knowledge library product by Sahar Carmel that enables AI agents to access book-length content through structured browsing rather than retrieval-augmented generation. The blog post "Why CandleKeep Doesn't Use RAG -- And Why That's the Point" (Feb 17, 2026) is both a product philosophy manifesto and a contribution to the growing "agentic search vs RAG" debate that Anthropic's Boris Cherny ignited when he revealed Claude Code abandoned vector databases in favor of agentic search.

The core argument is simple and compelling: RAG pre-indexes content into chunks and retrieves by similarity, but agents can now read documents directly, follow cross-references, and reason about what to read next. Carmel frames this as "RAG retrieves fragments. Agentic search reads, reasons, and follows threads." The product gives agents four tools: browse book listings, check tables of contents, read specific page ranges, and follow referenced concepts across sources.

CandleKeep itself (the product) launched as a freemium SaaS with CLI, Claude Code plugin, and web app interfaces. However, it has zero community visibility -- no GitHub repo, no Reddit mentions, no Twitter buzz, no independent reviews. The blog post's 498 views and 3 likes suggest minimal reach. The underlying methodology, though, aligns with a validated industry trend.

## The Argument: Why Not RAG

### The Human Analogy

Carmel's central analogy: humans don't pre-index books. They "walk to the shelf, look at the spines, pick up a promising book, flip to the table of contents, jump to the relevant chapter." CandleKeep replicates this workflow for AI agents.

### The Concrete Example

When seeking design patterns for distributed systems, RAG returns an Observer Pattern chunk but cannot follow an internal reference to the Event Sourcing Pattern in Chapter 12. An agentic system would autonomously pursue both sources, reading the reference and continuing the research thread.

### Four Advantages Over RAG

| Advantage | Explanation |
|-----------|-------------|
| **Staleness** | Indexes become outdated; agentic systems always access current versions |
| **Precision** | Direct text access beats cosine similarity matching |
| **Simplicity** | No vector databases, embedding pipelines, or chunking strategies |
| **Privacy** | Content never leaves the system for external embedding services |

### Honest Tradeoffs

The blog post acknowledges that agentic search "costs more tokens per query than a pre-built index lookup" and may require 3-4 reading rounds. Traditional indexes remain more efficient for repetitive, narrow queries against static datasets (e.g., FAQ answering).

### Historical Framing

RAG (introduced 2020) solved a real constraint: models couldn't use tools independently. By 2023-2025, autonomous tool use became standard, rendering the original motivation obsolete. The paradigm shift: from "how do we retrieve for a model?" to "what if the model retrieves itself?"

## Anthropic Validation

The blog post's strongest card is Boris Cherny's public confirmation:

> "Early versions of Claude Code used RAG + a local vector db, but we found pretty quickly that agentic search generally works better. It is also simpler and doesn't have the same issues around security, privacy, staleness, and reliability."
> -- Boris Cherny, Staff Engineer at Anthropic ([@bcherny](https://x.com/bcherny))

From the Latent Space podcast, Cherny elaborated that Claude Code's agentic search means "just using regular code searching, you know, glob, grep, just regular code search" in however many cycles the model needs. When asked about benchmarks: "This was just vibes."

This admission is both validating (Anthropic built a successful product on this approach) and limiting (no formal comparative data exists).

## Technical Analysis

### CandleKeep Product

| Feature | Detail |
|---------|--------|
| **Formats** | PDF, EPUB, Markdown |
| **Distribution** | CLI (Homebrew), Claude Code plugin, web app |
| **Authentication** | Clerk-based |
| **Stack detection** | Automatic (React, PostgreSQL, etc.) |
| **Citations** | Source attribution with page numbers and direct quotes |
| **Library** | Pre-built collections for React, PostgreSQL, Claude Code, security |

### Pricing

| Tier | Price | Items | Reads | Key Feature |
|------|-------|-------|-------|-------------|
| Free | $0/mo | 20 | 500/mo | Marketplace access |
| Pro | $10/mo | 200 | Unlimited | Publish & earn |
| Team | ~$30/mo | TBD | TBD | Shared libraries (coming soon) |

### Architecture (Inferred)

CandleKeep operates on progressive disclosure -- mirroring how developers read code:

```
Agent request
    ├── Browse shelf (list books with metadata)
    ├── Check table of contents (structural overview)
    ├── Read specific pages (targeted access)
    └── Follow threads (cross-reference exploration)
```

No vector database, no embedding pipeline, no chunking strategy. The agent decides what to read next based on what it has already read.

### Key Architectural Distinction

Carmel separates two concepts most tooling conflates:
- **Skills**: Procedures and workflows (how agents work)
- **Knowledge**: Reference materials and domain expertise (what agents know)

This is the "skills vs knowledge" gap: most tooling addresses skills while neglecting knowledge -- "comparable to training physicians in procedures while denying access to medical textbooks."

## User Sentiment

**Overall: Not Enough Data**

- **Reddit:** Zero mentions of CandleKeep as an AI product. All results are D&D's Candlekeep Mysteries. The agentic search vs RAG debate has moderate traction in r/Rag and r/AI_Agents, with growing consensus that agentic approaches outperform RAG for complex multi-document queries.
- **Twitter/X:** Zero mentions. Author (@augu144) has no visible CandleKeep promotion. The broader "Claude Code uses agentic search" narrative has significant traction via Boris Cherny.
- **LinkedIn:** Carmel's profile shows Director of AI Enablement at Mixtiles. No CandleKeep-specific posts found. No company page exists.

## Competitive Landscape

### CandleKeep's Self-Positioning

| Competitor | CandleKeep's Claim |
|------------|-------------------|
| **NotebookLM** | "For AI agents, not humans" |
| **DIY RAG** | "Stop building pipelines. Install a book in one command." |
| **CLAUDE.md** | "Teaches domain knowledge, not behavior" |
| **Code docs** | "Broader domain expertise beyond codebase description" |

### The Broader Agentic Search vs RAG Landscape

The industry is converging on a spectrum, not a binary:

| Approach | Best For | Weakness |
|----------|----------|----------|
| **Traditional RAG** | High-throughput, repetitive queries on static data (FAQ, search) | Staleness, chunk boundary problems, loss of cross-references |
| **Agentic RAG** | Complex multi-document reasoning with tool use | Higher token cost, latency, non-deterministic |
| **CandleKeep's approach** | Domain knowledge access for AI agents working on tasks | Token cost, no formal benchmarks, closed ecosystem |

### Industry Validation

- **NVIDIA** (Technical Blog): Published "Traditional RAG vs. Agentic RAG" comparison
- **IBM**: Formal definition and framework for Agentic RAG
- **arXiv (A-RAG paper)**: Showed agentic approach surpasses Graph-RAG and Workflow RAG
- **Reddit (r/Rag)**: Production test on ~1,300 files showed "99% fewer tokens and 2x better accuracy" for agentic search vs vector RAG
- **Rod Johnson (Jan 2026)**: "Pipelines Are the Past, Agentic Is the Future" -- claims 80% improvement in retrieval quality

## Author Context

**Sahar Carmel** is a repeat subject in this catalogue:

| Report | Date | Topic |
|--------|------|-------|
| [HDD: Human-Driven Development](2026-02-02-hdd-human-driven-development.md) | 2026-02-02 | Agent development methodology |
| This report | 2026-02-19 | CandleKeep product + agentic search thesis |

Carmel's body of work is coherent: HDD (observe experts, diagnose failures) led to CandleKeep (give agents the same reference materials experts use). The "skills vs knowledge" distinction is a natural evolution of HDD's "domain artifacts as gold" principle.

**Squid Club** is Carmel's community platform for AI agent integration, hosting 23+ blog articles across categories (General Agents, Programming, SDLC, Cybersecurity) by multiple authors including Sergei Benkovitch (Claude That Learns).

## Pros and Cons

| Pros | Cons |
|------|------|
| Strong thesis backed by Anthropic's own architectural decision | Zero community visibility (no Reddit, Twitter, GitHub, reviews) |
| Clear articulation of agentic search advantages | No public repository -- closed-source with no inspectable code |
| Honest about tradeoffs (token cost, latency) | D&D "Candlekeep" name collision creates SEO noise |
| Skills vs knowledge distinction is genuinely useful | No formal benchmarks -- "just vibes" per Anthropic too |
| Coherent with author's prior HDD methodology | Day-2 product with no visible adoption signals |
| Freemium pricing accessible for experimentation | Team tier "coming soon" -- product maturity unclear |
| Blog post cites primary sources (Boris Cherny, Anthropic) | 498 views / 3 likes suggests very limited reach |

## Assessment

The blog post succeeds as an articulation of the agentic search vs RAG argument. Carmel synthesizes Boris Cherny's public statements, Anthropic's architectural choices, and the broader industry trend into a clear, accessible narrative with honest tradeoff acknowledgment. The "skills vs knowledge" distinction and the progressive disclosure architecture (browse shelf, check TOC, read pages, follow threads) are genuinely insightful frameworks.

The product, however, is a different story. CandleKeep has all the hallmarks of a very early product: no GitHub repo, no community discussion, no independent reviews, no benchmarks, minimal blog engagement (498 views), and a freemium model with a "coming soon" team tier. The D&D name collision is a practical SEO problem. The product website exists and shows a real pricing page and feature set, but there is no evidence of adoption beyond the author's own use cases.

**Key question**: Is CandleKeep a product or a philosophy? The blog posts are more impactful than the product at this stage. The agentic search vs RAG argument stands regardless of whether CandleKeep succeeds as a business.

**Bottom line**: Read the blog post for the argument -- it's one of the clearest articulations of why agentic search beats RAG for complex knowledge work, with strong primary sourcing from Anthropic. Bookmark the product to revisit after it gains community visibility and independent validation. For immediate use, the methodology (give agents browsing tools over document collections rather than pre-indexed chunks) can be implemented independently using MCP servers or custom tool definitions.

## Sources

- [Why CandleKeep Doesn't Use RAG](https://www.squid-club.com/blog/why-candlekeep-doesn-t-use-rag-and-why-that-s-the-point) (Blog post, Feb 17, 2026)
- [Why I Built a Library for AI Agents](https://www.squid-club.com/blog/why-i-built-a-library-for-ai-agents) (Blog post, Feb 15, 2026)
- [CandleKeep Product](https://www.getcandlekeep.com/) (Product website)
- [Boris Cherny Tweet](https://x.com/bcherny/status/2017824286489383315) (Agentic search confirmation)
- [Latent Space Podcast: Claude Code](https://www.latent.space/p/claude-code) (Architecture deep dive)
- [WIRED: Claude Code Anthropic](https://www.wired.com/story/claude-code-success-anthropic-business-model/) (Cherny interview)
- [NVIDIA: Traditional RAG vs Agentic RAG](https://developer.nvidia.com/blog/traditional-rag-vs-agentic-rag-why-ai-agents-need-dynamic-knowledge-to-get-smarter/)
- [IBM: What is Agentic RAG?](https://www.ibm.com/think/topics/agentic-rag)
- [arXiv: A-RAG Paper](https://arxiv.org/html/2602.03442v1) (Hierarchical Retrieval Interfaces)
- [Sahar Carmel LinkedIn](https://www.linkedin.com/in/saharcarmel/)
- [Sahar Carmel GitHub](https://github.com/SaharCarmel)
- [Squid Club](https://www.squid-club.com/)

---

*Researched: 2026-02-19 | Sources: GitHub, Reddit, Twitter/X, LinkedIn, Web*
