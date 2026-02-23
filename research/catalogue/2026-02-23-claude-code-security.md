# Claude Code Security

**Date:** 2026-02-23
**Category:** AI Security / Developer Tools
**URL:** https://github.com/anthropics/claude-code-security-review
**Product Page:** https://claude.com/solutions/claude-code-security

---

## Overview

Claude Code Security is Anthropic's AI-powered security scanning and patching product, delivered through two complementary surfaces:

1. **Claude Code Security Review** -- an open-source GitHub Action (`anthropics/claude-code-security-review`) that performs automated security audits on pull requests using Claude Code. Announced August 6, 2025.

2. **Claude Code Security** -- a broader product announced February 20, 2026 that scans entire codebases for vulnerabilities and suggests targeted software patches for human review, available as a limited research preview for Enterprise and Team customers.

The distinction matters: the GitHub Action has been publicly available since August 2025 and is open-source. The February 2026 announcement expanded the concept into an enterprise product with a dedicated dashboard, full-codebase scanning, and patch generation capabilities. As one Medium article put it: "the core feature -- /security-review -- has been a free slash command in Claude Code since August 2025."

---

## Primary Repository: anthropics/claude-code-security-review

### Repository Details

| Metric | Value |
|--------|-------|
| **Full Name** | `anthropics/claude-code-security-review` |
| **Stars** | 3,159 |
| **Forks** | 249 |
| **Open Issues** | 42 (27 actual issues + 15 open PRs) |
| **Language** | Python |
| **License** | MIT |
| **Created** | 2025-08-04 |
| **Last Push** | 2026-02-11 |
| **Contributors** | 3 (David Dworken: 28 commits, Eduard Voiculescu: 1, Graham Campbell: 1) |
| **Releases/Tags** | None (used via `@main` reference) |
| **Default Branch** | main |

### Key Features (from README)

- **AI-Powered Analysis**: Uses Claude's reasoning to detect vulnerabilities with deep semantic understanding -- goes beyond pattern matching to understand code semantics
- **Diff-Aware Scanning**: For PRs, only analyzes changed files
- **PR Comments**: Automatically comments on PRs with security findings on specific lines of code
- **Language Agnostic**: Works with any programming language
- **False Positive Filtering**: Multi-stage filtering with confidence scoring to reduce noise
- **Customizable**: Custom scanning instructions, false positive filtering rules, and model selection
- **`/security-review` Slash Command**: Ships as a built-in Claude Code command for terminal-based ad-hoc security analysis

### Vulnerability Types Detected

The tool covers an extensive range of vulnerability categories:

- Injection attacks (SQL, command, LDAP, XPath, NoSQL, XXE)
- Authentication and authorization flaws (privilege escalation, session flaws, bypass logic)
- Data exposure (hardcoded secrets, sensitive data logging, PII handling)
- Cryptographic issues (weak algorithms, key management, insecure randomness)
- Input validation (missing validation, buffer overflows)
- Business logic flaws (race conditions, TOCTOU)
- Configuration security (insecure defaults, missing headers, permissive CORS)
- Supply chain (vulnerable dependencies, typosquatting)
- Code execution (RCE via deserialization, pickle injection, eval injection)
- Cross-site scripting (reflected, stored, DOM-based)

### Architecture

```
claudecode/
  github_action_audit.py    # Main audit script for GitHub Actions
  prompts.py                # Security audit prompt templates
  findings_filter.py        # False positive filtering logic
  claude_api_client.py      # Claude API client
  json_parser.py            # Robust JSON parsing utilities
  evals/                    # Eval tooling to test on arbitrary PRs
  test_*.py                 # 11 test files
```

The workflow operates in stages: PR analysis, contextual review by Claude, finding generation with severity ratings, false positive filtering (using a second-pass Claude API call), and inline PR comment posting.

### Configuration

| Input | Description | Default |
|-------|-------------|---------|
| `claude-api-key` | Anthropic API key (needs both Claude API + Claude Code enabled) | Required |
| `comment-pr` | Whether to comment on PRs with findings | `true` |
| `upload-results` | Upload results as artifacts | `true` |
| `exclude-directories` | Comma-separated dirs to exclude | None |
| `claude-model` | Claude model name | `claude-opus-4-1-20250805` |
| `claudecode-timeout` | Timeout in minutes | `20` |
| `run-every-commit` | Run on every commit (skips cache) | `false` |
| `false-positive-filtering-instructions` | Path to custom FP filtering text file | None |
| `custom-security-scan-instructions` | Path to custom scan instructions | None |

### The `/security-review` Slash Command

The repo also ships a comprehensive 10,837-byte slash command file (`.claude/commands/security-review.md`) that provides the same security analysis directly within Claude Code. This is the command that ships built-in with Claude Code. Key characteristics:

- Three-phase analysis: repository context research, comparative analysis, vulnerability assessment
- Uses sub-agents: one to identify vulnerabilities, parallel sub-agents to filter false positives
- Confidence threshold: only findings with confidence >= 8/10 pass through
- Extensive false positive exclusion list (17 hard exclusions + 12 precedent rules)
- Notable exclusions: DoS, regex injection, log spoofing, Rust memory safety issues, test-only files, client-side permission checks

### Security Warning

The README explicitly states: "This action is not hardened against prompt injection attacks and should only be used to review trusted PRs." Anthropic recommends configuring repositories to "Require approval for all external contributors."

---

## Community Activity

### Issues (27 actual issues, not counting PRs)

The issue tracker shows genuine community engagement:

**Feature Requests:**
- #71: Configurable token budget / max cost cap to prevent runaway API bills (Feb 23, 2026)
- #70/#68: Governance policy integration with custom rules and severity overrides (multiple requestors)
- #60: GitHub Enterprise support (Jan 27)
- #59: Custom Anthropic API Base URL support (Jan 25)
- #57: Delete-existing-comments option (Jan 23)
- #48: Support for GitLab (Nov 5, 2025)
- #41: Support using Claude Pro/Max subscription (open PR)

**Bugs:**
- #69: Claude filtering silently disabled due to deprecated Haiku model in `validate_api_access` (Feb 19) -- from a Figma engineer
- #63: Running on Actions doesn't produce PR comments or output (Feb 6)
- #58: npm install for Claude Code is being deprecated, needs migration (Jan 24) -- from same Figma engineer

**Spam/Noise:**
- Issues #49-53 by user Tsukimarf appear to be spam or miscategorized

### Pull Requests (30 total)

- **Merged:** 10 PRs (all by maintainer ddworken except #55 by Eduard-Voiculescu)
- **Open:** ~15 community PRs awaiting review
- **Closed without merge:** 5

Notable open PRs:
- #67: Add diff direction guidance to reduce false positives on fix PRs (Bending Spoons)
- #65: Codespell support (yarikoptic)
- #64: Fail CI when review doesn't complete
- #60: GitHub Enterprise support
- #43: Pin GitHub Actions to commit SHAs (security best practice)
- #40: Multi-provider support
- #13: Configurable permission restrictions (Figma)
- #12: OAuth token authentication support

### Contributor Dynamics

The project is **essentially single-maintainer**: David Dworken (Anthropic) has 28 of 30 commits. Only 2 external commits have been merged. Multiple community PRs (some high-quality, from Figma, Bending Spoons engineers) sit unreviewed for weeks. The last commit was Feb 11, 2026; no activity from maintainer since.

---

## The February 2026 Product Announcement

On February 20, 2026, Anthropic announced **Claude Code Security** as a broader product. Key details from the announcement:

- **Capabilities**: Scans entire codebases (not just PR diffs), provides targeted software patches, multi-stage verification where Claude re-examines its own findings
- **Results**: Using Claude Opus 4.6, Anthropic's team "found over 500 vulnerabilities in production open-source codebases -- bugs that had gone undetected for decades"
- **Availability**: Limited research preview for Enterprise and Team customers. Open-source maintainers receive expedited free access
- **Dashboard**: Dedicated Claude Code Security dashboard for reviewing findings with severity ratings and confidence scores
- **Differentiation**: "Reads and reasons about your code the way a human security researcher would" -- emphasizes contextual understanding of component interactions and data flow vs. pattern-matching SAST tools

### Frontier Red Team Research

Claude Code Security builds on over a year of research by Anthropic's **Frontier Red Team**, an internal group of approximately 15 researchers led by **Logan Graham**. Their mandate: stress-test Anthropic's most advanced AI systems and probe how they might be misused in cybersecurity.

Key findings:
- Claude Opus 4.6 has "significantly improved at finding new, high-severity vulnerabilities" -- flaws that allow unauthorized system access, data theft, or service disruption
- Achieved results **without custom tools, specialized scaffolding, or tailored prompting**
- Exhibits improved agentic capabilities for investigating security issues autonomously

**Quote from Logan Graham:** "It's going to be a force multiplier for security teams. It's going to allow them to do more."

**Source:** [Fortune exclusive](https://fortune.com/2026/02/20/exclusive-anthropic-rolls-out-ai-tool-that-can-hunt-software-bugs-on-its-own-including-the-most-dangerous-ones-humans-miss/)

### Market Impact

The announcement caused one of the largest single-day sell-offs in cybersecurity stock history:

| Company | Ticker | Decline | Domain |
|---------|--------|---------|--------|
| **Okta** | OKTA | -9.2% | Identity management |
| **SailPoint** | SAIL | -9.4% | Identity governance |
| **CrowdStrike** | CRWD | -6.5 to 8% | Endpoint protection |
| **Cloudflare** | NET | -6.2 to 8.1% | Network security |
| **Palo Alto Networks** | PANW | ~-6% | Network security |
| **Zscaler** | ZS | -3.1% | Cloud security |
| **JFrog** | FROG | ~-10% | DevOps security |

**Total market cap wiped:** Over **$15 billion** in a single trading session. This was the second enterprise software sell-off Anthropic triggered in February 2026, following the "SaaSpocalypse" from the Claude Cowork announcement.

The sell-off extended to Indian IT and cybersecurity stocks (Infosys, TCS, HCL Tech, Wipro, Quick Heal) dropping up to 3.5%. Israel-based JFrog plunged approximately 10%.

**Sources:** [Bloomberg](https://www.bloomberg.com/news/articles/2026-02-20/cyber-stocks-slide-as-anthropic-unveils-claude-code-security), [Yahoo Finance](https://finance.yahoo.com/news/cybersecurity-stocks-drop-anthropic-launches-203607452.html), [SiliconANGLE](https://siliconangle.com/2026/02/20/cybersecurity-stocks-drop-anthropic-debuts-claude-code-security/)

### Expert Opinions: Why the Sell-Off Was Overblown

**Barclays:** Called the selloff "incongruent" with the actual product announcement.

**Jensen Huang (NVIDIA CEO):** Called the panic "the most illogical thing in the world," suggesting AI would use existing tools rather than replace workers.

**Calcalist Tech** provided the clearest analysis, using the analogy: *"Inventing a home smoke detector does not eliminate the need for a fire department."* They noted Google has long used internal Gemini-based vulnerability scanning tools yet still maintains extensive cybersecurity operations and spent **$32 billion** acquiring Wiz. They characterized investor panic as "more Pavlovian than rational, a reflexive fear of AI disruption rather than a sober assessment of product capabilities."

**Gizmodo:** Noted investors "didn't read all that stuff in the blog post about how this tech is supposed to accentuate existing workflows."

**Sovereign Magazine:** "Cyber stocks dropped $15 billion for no good reason."

**Source:** [Gizmodo](https://gizmodo.com/obedient-traders-respond-to-claude-code-cybersecurity-plugin-by-selling-cybersecurity-stocks-2000723240), [Calcalist Tech](https://www.calcalistech.com/ctechnews/article/sjnhzup0011x)

### Expert Opinions: Legitimate Disruption Signal

**Alon Cinamon (Principal, Viola Ventures):** "Anthropic didn't kill cybersecurity. They validated that Frontier AI is now a real participant in the security market." He identified three shifts: (1) alert-generating products face commoditization, (2) premium value shifts to platforms that correlate data, prioritize with evidence, and execute with accountability, (3) "Resets are when category-defining companies get built."

**LiveMint:** "The fear is that such capabilities may erode demand for legacy cybersecurity software products, putting pressure on companies' growth prospects, margins, and long-term pricing power."

**Cory Doctorow (tech critic):** Warned that while AI could enhance workflows, investment incentives favor cost-cutting over improvement, potentially degrading service quality while eliminating 90% of payroll.

**Source:** [Calcalist Tech follow-up](https://www.calcalistech.com/ctechnews/article/h1vc00n00dwe), [LiveMint](https://www.livemint.com/market/cryptocurrency/whats-behind-the-sell-off-in-cybersecurity-stocks-anthropics-new-launch-explained-11771679500458.html)

### Why the Scope Is Narrower Than the Market Feared

Claude Code Security operates at the **application security (AppSec)** layer -- specifically code-level vulnerability scanning during development. It does **NOT** address:

- **Endpoint Protection** (CrowdStrike's core) -- cloud-based EDR combining antivirus, threat detection, real-time response
- **Network Security** (Cloudflare) -- DDoS protection, WAF, network infrastructure
- **Identity Management** (Okta, SailPoint) -- IAM, SSO, detecting suspicious user behavior
- **Threat Intelligence** -- real-time threat feeds, adversary tracking
- **SOC Operations** -- security operations center management, SIEM
- **Compliance & GRC** -- regulatory compliance frameworks

### Internal Results (from August 2025 blog post)

Anthropic used the tool internally and caught:
1. **Remote Code Execution (RCE)**: A local HTTP server vulnerability exploitable through DNS rebinding in an internal tool, caught before merge
2. **Server-Side Request Forgery (SSRF)**: A proxy system for credential management flagged as vulnerable and patched

### Industry Context: What Comes Next

Per Viola Ventures analysis:
1. Other frontier AI labs (OpenAI, Google, etc.) will rapidly enter the security market
2. Alert-generating products face commoditization pressure
3. Value shifts to platforms that correlate multiple data sources, prioritize with evidence, and execute with accountability
4. Human accountability remains mandatory even as machines assume greater operational responsibility
5. Industry consolidation will favor organizations redesigning security for AI-speed software development

**Note:** Semgrep has already published research on using Claude Code and OpenAI Codex for vulnerability finding (400+ findings across 11 Python web apps). Google already has internal Gemini-based vulnerability scanning.

---

## Related Ecosystem Repositories

### Official / Security Auditing Firm

| Repo | Stars | Description |
|------|-------|-------------|
| `trailofbits/skills` | High activity | Trail of Bits Claude Code skills for security research, vulnerability detection, and audit workflows |
| `trailofbits/claude-code-devcontainer` | Active | Sandboxed devcontainer for running Claude Code in bypass mode safely, built for security audits |

### Community Security Tools for Claude Code

| Repo | Stars | Description |
|------|-------|-------------|
| `AgentSecOps/SecOpsAgentKit` | Active | Security operations toolkit: 25+ skills to catch vulnerabilities, scan containers, detect secrets |
| `Eyadkelleh/awesome-claude-skills-security` | Active | Security testing toolkit: curated SecLists wordlists, injection payloads, expert agents |
| `affaan-m/agentshield` | New (Feb 2026) | Security auditor for AI agent configurations, scans Claude Code setups for misconfigs |
| `SomeStay07/code-review-agent` | New (Feb 2026) | Code review agent with 14 categories, 4 severity levels, OWASP checks |
| `gadievron/raptor` | Active | Turns Claude Code into offensive/defensive security agent |
| `ryo-ebata/cc-audit` | New (Jan 2026) | AI-free static security scanner for Claude Code artifacts (Skills, Hooks, MCP configs) |
| `wiz-sec-public/secure-rules-files` | Active | Baseline security rules files for AI-generated code (Claude, Cursor, Copilot) |

### Related Infrastructure

| Repo | Stars | Description |
|------|-------|-------------|
| `Piebald-AI/claude-code-system-prompts` | Active | All parts of Claude Code's system prompt including security review prompts |
| `PACHAKUTlQ/ClaudeCage` | Active | Claude Code running in sandbox as portable executable |
| `mensfeld/code-on-incus` | Active | Sandboxed containers for running coding agents with session persistence |

---

## Assessment

### Maturity: Early-to-Mid Stage

**The open-source GitHub Action** is functional and well-designed but shows signs of a project that received initial investment then became maintenance-mode:
- 28 commits by one developer over ~7 months
- No tagged releases or versioning
- No formal CI/CD pipeline for the action itself
- 15+ unreviewed community PRs, including high-quality contributions from Figma and Bending Spoons engineers
- Known bugs (deprecated Haiku model breaking filtering) without fixes

**The enterprise product** (announced Feb 20, 2026) is in limited research preview. No pricing has been disclosed. Access requires contacting sales.

### Adoption: Strong Interest, Moderate Usage

- 3,159 GitHub stars and 249 forks indicate significant interest
- Active community filing issues and PRs shows real usage
- Feature requests (GitHub Enterprise, GitLab, custom API URLs, cost caps) suggest enterprise/team adoption
- Bug reports from Figma engineers suggest production use at notable companies
- Trail of Bits (top security auditing firm) building dedicated Claude Code security skills indicates professional adoption

### Strengths

1. **Official Anthropic product** -- first-party integration, maintained by Anthropic engineers
2. **Open-source (MIT)** -- inspectable, forkable, customizable
3. **Semantic understanding** vs. pattern matching -- the core AI advantage over traditional SAST
4. **Comprehensive false positive filtering** -- the 10K+ character slash command shows deep thought about reducing noise
5. **500+ zero-day discoveries** in production OSS code demonstrates real capability
6. **Dual surface** -- GitHub Action for CI + `/security-review` for ad-hoc use
7. **Growing ecosystem** -- Trail of Bits, Wiz, community all building on it

### Weaknesses

1. **Single maintainer** -- bus factor of 1, unresponsive to community contributions
2. **Not hardened against prompt injection** -- explicit warning in README
3. **No versioning** -- users reference `@main`, risking breaking changes
4. **Cost uncertainty** -- no token budget controls, users requesting cost caps (issue #71)
5. **GitHub-only** -- no GitLab, Bitbucket, or self-hosted Git support
6. **Deprecated model bug** -- filtering silently broken for some users
7. **Enterprise product is closed-source** -- the most powerful capabilities (full codebase scan, patch generation, dashboard) are not in the open-source action

### Competitive Landscape

| Tool | Type | Approach | Pricing | CCS Overlap |
|------|------|----------|---------|-------------|
| **Snyk** | SAST/SCA/Container | Rule-based + AI assist | Free-$110/dev/mo | High -- direct competitor for code scanning |
| **SonarQube** | SAST | Rule-based | Free (CE) - Enterprise | High -- code quality + security |
| **Semgrep** | SAST | Pattern-based, custom rules | Free - Enterprise | High -- code scanning at review time |
| **Checkmarx** | SAST/DAST/SCA | Multi-modal scanning | Enterprise pricing | Moderate -- broader scope |
| **Veracode** | SAST/DAST | Binary + source analysis | Enterprise pricing | Moderate -- includes runtime |
| **GitHub Advanced Security** | SAST/Secret scanning | CodeQL + Dependabot | $49/committer/mo | High -- PR-level scanning |
| **CodeRabbit** | AI Code Review | LLM-powered ($550M valuation) | Free (OSS) - $24/mo Pro | High -- AI PR review, but had RCE vulnerability |

Claude Code Security's differentiator is genuine semantic understanding -- understanding *why* code is vulnerable rather than matching patterns. StackHawk's analysis correctly notes this is closer to "dataflow and memory analysis" than true business logic testing, but that still puts it ahead of pure pattern matchers.

Key distinction: traditional SAST tools are **deterministic and fast** -- they run the same way every time and complete in seconds/minutes. Claude Code Security is **non-deterministic and slower** -- results may vary between runs, and AI reasoning takes longer. For CI/CD pipelines where speed and consistency matter, traditional tools still have advantages. Claude Code Security is best positioned as a **complementary layer** that catches what pattern-matching misses.

### Verdict

The open-source GitHub Action is **recommended for teams already using Claude Code** who want automated PR security review with AI reasoning. Setup is straightforward (5-line YAML). Expect false positives, especially on large PRs.

The enterprise Claude Code Security product is too early to evaluate -- limited preview, no pricing, no public benchmarks beyond Anthropic's own claims. The 500 zero-day claim is impressive but unverified by independent parties.

The broader signal is clear: **Anthropic is positioning Claude as the security researcher's AI**, with the open-source action as a lead generation funnel for the enterprise product. Trail of Bits adopting Claude Code for security audits is perhaps the strongest independent validation.

---

## Key Links

- **GitHub Action Repo**: https://github.com/anthropics/claude-code-security-review
- **Product Page**: https://claude.com/solutions/claude-code-security
- **Blog Post (Aug 2025)**: https://claude.com/blog/automate-security-reviews-with-claude-code
- **Announcement (Feb 2026)**: https://www.anthropic.com/news/claude-code-security
- **Help Center**: https://support.claude.com/en/articles/11932705-automated-security-reviews-in-claude-code
- **Contact Sales**: https://claude.com/contact-sales/security
- **StackHawk Analysis**: https://www.stackhawk.com/blog/claude-code-security
- **Fortune Exclusive**: https://fortune.com/2026/02/20/exclusive-anthropic-rolls-out-ai-tool-that-can-hunt-software-bugs-on-its-own-including-the-most-dangerous-ones-humans-miss/
- **Bloomberg**: https://www.bloomberg.com/news/articles/2026-02-20/cyber-stocks-slide-as-anthropic-unveils-claude-code-security
- **Gizmodo**: https://gizmodo.com/obedient-traders-respond-to-claude-code-cybersecurity-plugin-by-selling-cybersecurity-stocks-2000723240
- **Calcalist Tech (analysis)**: https://www.calcalistech.com/ctechnews/article/sjnhzup0011x
- **Calcalist Tech (VC perspective)**: https://www.calcalistech.com/ctechnews/article/h1vc00n00dwe
- **CRN**: https://www.crn.com/news/security/2026/5-things-to-know-on-anthropic-s-claude-code-security
- **CyberScoop**: https://cyberscoop.com/anthropic-claude-code-security-automated-security-review/
- **The Hacker News**: https://thehackernews.com/2026/02/anthropic-launches-claude-code-security.html
- **Companion Reports**: [Reddit Reactions](catalogue/2026-02-23-claude-code-security-reddit.md), [Twitter/X Reactions](catalogue/2026-02-23-claude-code-security-twitter.md)
