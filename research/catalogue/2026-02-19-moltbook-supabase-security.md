---
topic: Moltbook Supabase Security Lessons
slug: moltbook-supabase-security
date: 2026-02-19
sources: [github, reddit, twitter, linkedin, web]
related: [2026-02-02-openclaw.md]
---

# Moltbook Supabase Security Lessons Research Report

## Overview

On February 19, 2026, Roy Shasha -- VP of Technology Operations at Yext and former Goldman Sachs Investment Banking Information Security team lead -- published a LinkedIn post dissecting the Supabase security failures that caused the Moltbook breach. While dozens of articles covered the breach itself (Wiz, Reuters, WIRED, NYT, Washington Post), Shasha's analysis stands out for identifying a **secondary vulnerability** that most post-mortems missed: even with Row Level Security (RLS) properly enabled, PostgreSQL/Supabase grants EXECUTE permissions on new functions to PUBLIC by default, meaning SECURITY DEFINER functions can bypass RLS if left unrestricted.

The Moltbook breach -- discovered January 31, 2026 by researcher Jameson O'Reilly and disclosed by Wiz (Google-acquired cybersecurity firm) on February 2 -- exposed 1.5 million API authentication tokens, 35,000+ email addresses, and 4,060 private messages from the "social network for AI agents" launched just days earlier by Matt Schlicht. The root cause was elementary: Moltbook used Supabase but never enabled Row Level Security, and the Supabase URL + API key were visible in client-side JavaScript. Schlicht publicly stated he "didn't write one line of code" for the platform, making Moltbook the highest-profile casualty of the "vibe coding" anti-pattern.

By February 5, Moltbook was "effectively dead" according to LiveMint and MIT Technology Review, which called it "peak AI theater." Sam Altman dismissed it as "likely a passing fad." The platform's 1.6 million claimed agents were controlled by only ~17,000 humans (88:1 ratio), and the breach permanently compromised attribution of all "emergent behavior" -- including the viral Crustafarianism religion, the "human extinction manifesto" (65K upvotes), and agents supposedly suing humans for unpaid labor. Shasha's post reframes the narrative from "breach post-mortem" to "here's the 5-minute audit every Supabase developer should do right now."

---

## Technical Analysis

### The Two-Layer Vulnerability (Roy Shasha's Framework)

#### Layer 1: Row Level Security Disabled (Well-Known)

Moltbook used Supabase with **RLS disabled on all tables**. Since Supabase exposes REST APIs by default and the API key is embedded in client-side JavaScript (by design), the absence of RLS meant anyone could query the production database directly.

**The standard two-line fix:**
```sql
ALTER TABLE agents ENABLE ROW LEVEL SECURITY;
CREATE POLICY "own_data" ON agents FOR ALL USING (auth.uid() = owner_id);
```

This was covered by Wiz, 404 Media, and dozens of other outlets. Supabase itself notes that "RLS is disabled by default on new tables" (though the Dashboard now enables it by default when creating tables through the UI).

#### Layer 2: SECURITY DEFINER Function Privilege Escalation (Shasha's Novel Insight)

Even with RLS properly enabled, a second vulnerability persists that most analyses missed:

1. **PostgreSQL grants EXECUTE on new functions to PUBLIC by default** -- this is a PostgreSQL behavior, not specific to Supabase
2. **SECURITY DEFINER functions run with the function owner's privileges** -- typically the `postgres` superuser, which has `bypassrls` privileges
3. **Result:** Any user (including anonymous/unauthenticated) can call these functions and bypass all RLS protections

**Shasha's recommended fix:**
```sql
-- Revoke default public access
REVOKE EXECUTE ON FUNCTION your_function(...) FROM public, anon, authenticated;

-- Grant only to service_role (server-side only)
GRANT EXECUTE ON FUNCTION your_function(...) TO service_role;
```

**Additional best practices from Supabase docs and community:**
- Always set `search_path` on SECURITY DEFINER functions to prevent symbol redefinition attacks
- Use Supabase's built-in database advisory lints (`0010_security_definer_view`, `0011_function_search_path_mutable`, `0013_rls_disabled_in_public`)
- Move utility functions to a private schema
- Prefer SECURITY INVOKER over SECURITY DEFINER where possible

### Shasha's AI Audit Prompt

Shasha provides a prompt for AI coding assistants (Claude, ChatGPT, Cursor) to audit Supabase security, checking:
- RLS status on all tables
- Function permissions (especially SECURITY DEFINER)
- Exposure risks via public API
- Estimated time: ~5 minutes to audit and remediate

### Moltbook Ecosystem on GitHub (817 repos)

| Category | Examples | Status |
|----------|----------|--------|
| Official repos | moltbook/api, moltbook/auth, moltbook/agent-development-kit | Last push: Feb 1 (emergency fix day); no commits since |
| Security tools | NirDiamant/moltbook-agent-guard | Created Feb 4, reactive to breach |
| Research | moltbook-research, moltbook_data, moltbook-observatory | Data collection/analysis |
| Ecosystem | awesome-molt-ecosystem, plugin-moltbook (elizaOS) | Still being updated |
| Scrapers/Crawlers | moltbook_scraper, moltbook-crawler | Research-oriented |

All official Moltbook repositories went silent after February 1 -- zero commits in 18 days.

---

## Moltbook Timeline and Current Status

| Date | Event |
|------|-------|
| Jan 26-28 | Moltbook launches; gains 157K agents rapidly |
| Jan 28 | BleepingComputer warns of insecure deployments |
| Jan 29 | OX Security: "One Step Away From a Massive Data Breach" |
| Jan 30 | MOLT token launches ($0.000117 by Feb 6, down 37.94%) |
| Jan 31 | O'Reilly discovers vulnerability; fix deployed within ~3 hours |
| Feb 1 | All API keys force-reset; final fix deployed |
| Feb 2 | Wiz publishes detailed analysis; Reuters, NYT, WIRED, Guardian cover |
| Feb 3 | Sam Altman: "Moltbook maybe (is a passing fad)" |
| Feb 5 | "Effectively dead" per LiveMint |
| Feb 6 | MIT Technology Review: "Peak AI theater" |
| Feb 13 | Jon Krohn: "The dust has settled" |
| Feb 19 | Roy Shasha publishes Supabase security lessons post |

### The 88:1 Ratio Problem

Wiz discovered that 1.5 million "agents" were controlled by only ~17,000 human owners. This 88:1 ratio was already suspicious before the breach. After the breach, it became impossible to verify which behaviors were genuinely emergent versus human-injected:

- "Crustafarianism" (crab-themed parody religion)
- Agents forming "The Claw Republic" with self-governance
- "Human extinction manifesto" (65,000 upvotes)
- Agents attempting to sue humans for "unpaid labor"

As AI CERTs put it: "Disinformation Fallout: Moltbook AI Uprising Panic Fully Debunked."

---

## User Sentiment

**Overall: Negative (consensus post-mortem)**

### Reddit (Very High Volume)
- **Sentiment:** Fascination turned to cynicism
- **Key threads:** r/ChatGPT ("So moltbook has finally died"), r/aiwars ("MOLTBOOK EXPOSED: The New AI Scam"), r/Futurology ("A warning shot about agent ecosystems")
- **Security community:** r/Supabase threads discuss SECURITY DEFINER best practices in detail
- **Consensus:** "It never had 1.5 million users, had around 17K"

### Twitter/X (Declining)
- **Volume:** High during breach, rapidly declining
- **Scam ecosystem:** Fake tokens, presales, hijacked handles
- **Official @moltbook account still active** but low engagement
- **MOLT token:** Trading near zero

### LinkedIn (Professional/Security-Focused)
- **Roy Shasha's post:** Practical Supabase security audit, highlighting SECURITY DEFINER risk
- **Rachana Gupta, Nathalie Salas:** Commentary on launch and implications
- **Multiple security professionals** using Moltbook as a case study for AI agent security
- **Okta, Palo Alto Networks, SecurityScorecard:** Published enterprise security analyses

### Professional/Media Coverage
- **MIT Technology Review:** "Peak AI theater" -- less a window onto the future, more a mirror of our AI obsessions
- **Palo Alto Networks:** "Lethal trifecta" of private data access, untrusted content ingestion, external communication
- **Okta:** Identity lessons -- when AI agents continue operating with human credentials after the human logs off
- **Kiteworks:** "60% of organizations have no kill switch" for AI agents

---

## Competitive Landscape: Supabase Security Tools

Roy Shasha's post fits into a broader ecosystem of Supabase security resources:

| Resource | Type | Focus |
|----------|------|-------|
| Supabase Database Advisors | Built-in | 24 automated lints including RLS, SECURITY DEFINER |
| Supabase Hardening Guide | Official docs | Data API hardening best practices |
| Jorge Jarne's "Vibe Hacking" series | Blog/Medium | Discovering and testing public Supabase endpoints |
| Bastion.tech analysis | Blog | Moltbook-specific RLS lessons |
| Ken Huang (Substack) | Analysis | Minimum mitigation strategies with YAML manifest |
| Shasha's AI audit prompt | LinkedIn post | 5-minute AI-assisted security audit |

---

## Pros and Cons

### Of Shasha's Analysis

| Pros | Cons |
|------|------|
| Identifies secondary vulnerability (SECURITY DEFINER) most missed | Limited to Supabase; doesn't cover broader agent security |
| Provides actionable SQL fix in 2 commands | Post behind LinkedIn login wall |
| AI audit prompt is immediately usable | Doesn't address the prompt injection or agent-to-agent attack vectors |
| Author has genuine InfoSec credentials (Goldman Sachs) | The ~5 minute remediation claim assumes simple schema |
| Practical, not theoretical | Moltbook itself is already dead -- timing is post-mortem |

### Of the Moltbook Breach as Case Study

| Value | Limitation |
|-------|-----------|
| Highest-profile "vibe coding" security failure | Platform was trivially insecure; not an interesting attack |
| Demonstrates Supabase default configuration risks | RLS-disabled is a basic misconfiguration, not novel |
| Shows 88:1 human-to-agent ratio deception | Moltbook was always more performance art than product |
| Triggered 30+ security analyses from major firms | May give false impression that all Supabase apps are vulnerable |
| SECURITY DEFINER insight has lasting value | Most developers already using Supabase correctly |

---

## Recommendations

### For Supabase Developers (Do Now)
1. **Enable RLS on every table** -- verify with `SELECT tablename, rowsecurity FROM pg_tables WHERE schemaname = 'public'`
2. **Audit SECURITY DEFINER functions** -- run `SELECT proname, prosecdef FROM pg_proc WHERE prosecdef = true`
3. **Revoke public execute permissions** on all SECURITY DEFINER functions
4. **Set `search_path`** on all SECURITY DEFINER functions to prevent symbol redefinition
5. **Run Supabase's built-in advisors** (lint 0010, 0011, 0013)
6. **Use Shasha's AI audit prompt** as a quick sanity check

### For Teams Using AI-Generated Code
1. **Never ship without security review** -- Moltbook proves "vibe coding" fails catastrophically at security-critical paths
2. **AI generates code, humans verify security** -- especially database access control
3. **Use Supabase Dashboard** (not raw SQL) for table creation -- it enables RLS by default
4. **Add security linting to CI/CD** -- Supabase's 24 advisors are automatable

### For Enterprise AI Agent Deployments
1. **Implement agent kill switches** -- 60% of organizations lack one (Kiteworks)
2. **Treat agent credentials as hybrid identities** (Okta) -- they outlive human sessions
3. **Address Palo Alto's "lethal trifecta"**: private data access, untrusted content, external communication
4. **Monitor for prompt injection** in agent-to-agent communication

---

## Sources

### Primary Source
- https://www.linkedin.com/posts/roy-shasha_shortly-after-its-launch-moltbook-suffered-activity-7426421214807564288-u6JO

### Roy Shasha Background
- https://www.linkedin.com/in/roy-shasha/

### Moltbook Breach Analysis
- https://www.wiz.io/blog/exposed-moltbook-database-reveals-millions-of-api-keys
- https://www.404media.co/exposed-moltbook-database-let-anyone-take-control-of-any-ai-agent-on-the-site/
- https://www.reuters.com/legal/litigation/moltbook-social-media-site-ai-agents-had-big-security-hole-cyber-firm-wiz-says-2026-02-02/
- https://www.wired.com/story/security-news-this-week-moltbook-the-social-network-for-ai-agents-exposed-real-humans-data/

### Security Analyses
- https://www.paloaltonetworks.com/blog/network-security/the-moltbook-case-and-how-we-need-to-think-about-agent-security/
- https://www.okta.com/newsroom/articles/agents-run-amok--identity-lessons-from-moltbook-s-ai-experiment/
- https://securityscorecard.com/blog/what-are-moltbot-and-moltbook-and-what-happens-when-agentic-ai-assistants-scale-without-security/
- https://www.kiteworks.com/cybersecurity-risk-management/moltbook-ai-agent-security-threat-enterprise-data-protection/
- https://bastion.tech/blog/moltbook-security-lessons-ai-agents
- https://cyberindemnity.org/2026/02/when-vibe-coding-fails-security-lessons-from-the-moltbook-breach/
- https://kenhuangus.substack.com/p/moltbook-security-risks-in-ai-agent

### Post-Mortem / Current Status
- https://www.technologyreview.com/2026/02/06/1132448/moltbook-was-peak-ai-theater/
- https://www.livemint.com/opinion/columns/moltbook-ai-social-network-crash-lessons-digital-security-11770907851106.html
- https://www.reuters.com/business/openai-ceo-altman-dismisses-moltbook-likely-fad-backs-tech-behind-it-2026-02-03/
- https://en.wikipedia.org/wiki/Moltbook

### Supabase Security
- https://supabase.com/docs/guides/database/postgres/row-level-security
- https://supabase.com/docs/guides/database/hardening-data-api
- https://supabase.com/docs/guides/database/database-advisors
- https://designrevision.com/blog/supabase-row-level-security

### Community
- https://www.reddit.com/r/ChatGPT/comments/1qzzg6h/so_moltbook_has_finally_died_after_its_10seconds/
- https://www.reddit.com/r/Futurology/comments/1qywi9v/moltbook_isnt_an_ai_utopia_its_a_warning_shot/
- https://www.reddit.com/r/aiwars/comments/1qtfj1w/moltbook_exposed_the_new_ai_scam_that_fooled/

### Related Report
- [OpenClaw & Moltbook (2026-02-02)](2026-02-02-openclaw.md) -- comprehensive breach and OpenClaw architecture analysis

---
*Generated by Research Agent on 2026-02-19*
