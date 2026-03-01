---
topic: skills-il/tax-and-finance
slug: skills-il-tax-and-finance
date: 2026-02-26
sources: [github, reddit, twitter, linkedin, web]
---

# skills-il/tax-and-finance Research Report

## Overview

skills-il/tax-and-finance is a monorepo of 7 AI agent skills covering Israeli tax, invoicing, VAT, payroll, pension, banking, and currency conversion. Created on February 23, 2026 by Alex Choroshin (Tel Aviv-based Full Stack Developer at YooTech), it is part of the **Skills IL** GitHub organization — an ambitious effort to build a comprehensive library of Israel-specific AI agent skills across 9 category repos (tax-and-finance, government-services, localization, developer-tools, security-compliance, communication, food-and-dining, health-services, and org-level .github).

Each skill follows a structured SKILL.md format with YAML frontmatter, step-by-step instructions, concrete examples, bundled Python scripts, reference documents, and troubleshooting guides. The skills are designed for installation into Claude Code via `claude install github:skills-il/tax-and-finance/<skill-name>` and are compatible with Claude.ai and Cursor. The project is bilingual, with Hebrew SKILL_HE.md files being added alongside English versions.

Despite impressive depth and structure, the project is only 3 days old with zero community adoption — no stars, no forks, no issues, no external contributors, and zero visibility across Reddit, Twitter/X, LinkedIn, or the broader web. It represents a genuinely novel first-mover effort in Israeli tax AI skills, but is pre-launch and unproven.

## Technical Analysis

### Repository Structure
- **Monorepo** with 7 skill subdirectories + scripts directory
- **30 commits**, all by a single author (Alex Choroshin)
- **CI/CD:** GitHub Actions workflows, dependabot (GitHub Actions updates), labeler
- **Templates:** PR template, issue templates
- **CLAUDE.md:** Comprehensive contributor guidance with validation rules
- **CODEOWNERS** for review routing

### Skills (7)
| Skill | Description | Script | References |
|-------|-------------|--------|------------|
| israeli-e-invoice | E-invoices per SHAAM, types 300-400, allocation numbers | `validate_invoice.py` | 3 (SHAAM API, invoice types, compliance timeline) |
| israeli-vat-reporting | VAT reports (Doch Maam), Form 874, Eilat zone | `calculate_vat.py` | 3 (VAT regs, calendar, special cases) |
| israeli-payroll-calculator | Gross-to-net, 7 tax brackets, Bituach Leumi, pension | `calculate_payroll.py` | 3 (brackets, NI rates, credit points) |
| shekel-currency-converter | Bank of Israel rates, 30+ currencies, historical | `fetch_rates.py` | 2 (BOI API, currency codes) |
| israeli-tax-withholding | Nikui mas bemakor, certificates, Form 856 | `calculate_withholding.py` | 2 (rates, certificate guide) |
| israeli-pension-advisor | Keren pensia, bituach menahalim, keren hishtalmut | `calculate_pension.py` | 2 (fund types, tax benefits) |
| israeli-bank-connector | Transaction analysis, spending categorization | `categorize_transactions.py` | 2 (categories, supported banks) |

### Skill Format Quality
- **Frontmatter:** Well-structured YAML with bilingual display names (he/en), tags, allowed-tools restrictions, compatibility notes
- **Instructions:** Step-by-step with tables, formulas, thresholds, and Israeli regulatory specifics
- **Examples:** Concrete scenarios with "User says" → "Result" format
- **Scripts:** Python helpers for each skill (calculate, validate, fetch)
- **References:** Detailed reference docs for regulations, APIs, rates
- **Troubleshooting:** Error → Cause → Solution format
- **Validation:** CI enforces naming, frontmatter, word limits, security (no hardcoded secrets)

### Ecosystem Integration
- **israeli-bank-mcp** (mottibec): MCP server for Israeli bank data — referenced by israeli-bank-connector skill
- **il-bank-mcp** (glekner): Alternative Israeli bank MCP server
- **israeli-bank-scrapers**: Underlying scraping library for Israeli banks
- **SHAAM API:** Israeli Tax Authority API for e-invoice allocation numbers
- **Bank of Israel API:** Official exchange rates for currency conversion

### Broader Organization (skills-il)
9 repos planned, 4 actively developed (tax-and-finance, government-services, localization, developer-tools), 4 placeholder (food-and-dining, health-services, communication, security-compliance).

## User Sentiment

**Overall:** No awareness / Too early to assess

- **Reddit:** Zero mentions. General interest in AI agents for tax/finance exists, but skepticism is high ("stay away from any AI agent platform, all of them are pure bullsh*t" — r/Accounting). TaxHacker (self-hosted invoice parser) and BlueJ/TaxGPT show demand for tax AI tools.
- **Twitter/X:** Zero mentions. No launch announcement detected.
- **LinkedIn:** Author (Alex Choroshin) has a profile but no posts about skills-il. Related israeli-bank-mcp has some LinkedIn activity from the Israeli developer MCP community.
- **Web:** Zero coverage. Snyk published "Top 8 Claude Skills for Finance" (Feb 2026) but skills-il is not mentioned. The Claude Code skills ecosystem is growing rapidly with multiple marketplaces and directories.

## Competitive Landscape

| Competitor | Difference |
|-----------|------------|
| No direct competitor | skills-il is first-mover in Israel-specific AI agent skills for tax/finance |
| TaxHacker (self-hosted) | Invoice parser + accounting app; not agent skills, not Israel-specific |
| BlueJ / TaxGPT | US-focused tax research AI; commercial, not open source |
| israeli-bank-scrapers | Low-level bank scraping library; skills-il builds higher-level workflows on top |
| israeli-bank-mcp | MCP server for bank data; skills-il's bank-connector skill enhances it |

## Pros and Cons

| Pros | Cons |
|------|------|
| First-mover in Israeli tax AI skills | 3 days old, zero community adoption |
| Deeply localized with Hebrew terminology and bilingual content | Bus factor of 1 (single contributor) |
| Well-structured SKILL.md format with scripts, references, troubleshooting | Tax calculations and rates need ongoing verification |
| Covers comprehensive Israeli tax landscape (7 interconnected skills) | Python scripts not yet validated for accuracy |
| Integrates with existing ecosystem (israeli-bank-mcp, SHAAM API, BOI API) | 5 of 9 org repos are empty placeholders |
| MIT licensed, open source | No tests visible for the Python scripts |
| Follows Anthropic's Agent Skills standard | No usage documentation or install verification |
| CI validation enforces quality | No community governance or contribution history |

## Sources
- https://github.com/skills-il/tax-and-finance
- https://github.com/orgs/skills-il/repositories
- https://www.linkedin.com/in/choroshin/
- https://github.com/mottibec/israeli-bank-mcp
- https://github.com/glekner/il-bank-mcp
- https://snyk.io/articles/top-claude-skills-finance-quantitative-developers
- https://github.com/anthropics/skills

---
*Generated by Research Agent on 2026-02-26*
