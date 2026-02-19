---
topic: LEAP Stacks v2
slug: leapstacks
date: 2026-02-19
sources: [github, reddit, twitter, linkedin, web]
---

# LEAP Stacks v2 Research Report

## Overview

LEAP Stacks v2 ("Launch. Explore. Adapt. Prototype.") is an open-source platform by Basil Fateen, an AWS Principal Startup Advocate for EMEA, that deploys production-ready AI agents, RAG systems, and chatbots into your own AWS account in under 7 minutes via a single CloudFormation template. The project addresses what Fateen calls the "Production Valley of Despair" -- the gap between a working local AI demo and a secure, observable, cost-controlled deployment on AWS. It includes 12 pre-built prototype stacks organized into three tiers (AWS Foundations, GenAI Foundations, Advanced Agentic Workflows), each deployable with a single click through a web dashboard.

The tool is effectively a semi-official AWS project: v1 lived under the `aws-samples` GitHub organization, and the project has been featured on AWS's own Serverless Office Hours YouTube series with Julian Wood. However, v2 (leapstacks2) lives under Fateen's personal GitHub account with 57 stars, and despite endorsement from AWS colleagues (12 named contributors/testers including security reviewers), the project has zero community visibility outside AWS's own channels -- no Reddit discussions, no Twitter mentions, no news coverage, and no GitHub issues.

LEAP Stacks occupies a unique niche: more opinionated and complete than raw CloudFormation/CDK but simpler than AWS's own Bedrock AgentCore managed service. Its killer feature is the 2-hour auto-cleanup timer that eliminates bill shock -- the #1 fear preventing developers from experimenting on AWS. The live cost-per-message tracking and GitHub export for production migration are thoughtful additions that show real-world experience with developer pain points.

## Technical Analysis

**Architecture:** The entire platform is a single 311KB CloudFormation YAML template (`leap-installer-setup.yaml`) that provisions a web dashboard with Cognito authentication, from which users can launch any of the 12 prototype stacks. Each prototype deploys its own set of AWS resources (Lambda, API Gateway, S3, Bedrock, OpenSearch/Aurora, etc.) and includes real-time cost tracking, logging to DynamoDB, and configurable auto-cleanup.

**12 Prototype Stacks:**
- **AWS Foundations (4):** Serverless CRUD app, Photo Gallery, Authentication/User Management, Deploy from GitHub (Amplify)
- **GenAI Foundations (4):** GenAI Chatbot, RAG with OpenSearch, RAG with Aurora, Website Chat (Multimodal)
- **Advanced Agentic (4):** Agent with MCP Tools, Autonomous Agent Runtime, Voice AI Agent (Amazon Nova Sonic 2), Agentic Automation (n8n)

**v2 Additions:**
- One-click GitHub export for production migration
- Vibe Coding integration with Kiro (AWS's agentic IDE)
- External app hosting for Lovable and Replit apps
- Live memory editing for AgentCore agents
- Support for 20+ Bedrock models including Claude Sonnet 4.5 and Amazon Nova Pro

**Development Patterns:**
- 30 commits, all by Basil Fateen, all via "Add files via upload" (GitHub web UI)
- Most development concentrated in a Jan 19-22, 2026 burst
- No CI/CD, no tests, no standard git workflow
- The 311KB single-file approach is pragmatic for CloudFormation one-click deployment but unwieldy for maintenance

**Relationship to aws-samples/sample-ai-full-stacks:** The v1 repository under the official `aws-samples` organization (4 stars, last updated July 2025) is the predecessor. The v2 under Fateen's personal account is the active version, suggesting the project may not have passed the threshold for continued official AWS samples hosting, or that Fateen wanted faster iteration outside of AWS's review process.

## User Sentiment

**Overall:** Insufficient data (no community discussion found)

- **Reddit:** No mentions found across any subreddit. The complete absence from r/aws (200K+ members) is notable for an AWS developer tool, suggesting the project hasn't achieved organic community adoption.
- **Twitter:** No mentions found beyond the creator's own account (@basilfateen). No influencer endorsements or community discussion.
- **LinkedIn:** Basil Fateen has an active professional presence (TEDx speaker, World Investment Forum, Sifted feature) but no LinkedIn posts specifically promoting LEAP Stacks were found in search results.

The signal pattern -- AWS official channel promotion (Serverless Office Hours) but zero organic community discussion -- suggests this is primarily an internal AWS advocacy tool for workshops and startup programs rather than a community-adopted project.

## Competitive Landscape

LEAP Stacks competes in the "AWS AI deployment simplification" space, which has multiple approaches:

| Competitor | Approach | Complexity | Flexibility |
|-----------|----------|------------|-------------|
| **LEAP Stacks** | One-click CloudFormation templates | Very Low | Medium (12 templates) |
| **AWS Bedrock AgentCore** | Managed service + IaC | Medium | High |
| **Strands Agents + AgentCore Starter** | Framework + starter kit | Medium-High | High |
| **AWS Generative AI App Builder** | Official AWS Solution | Medium | High |
| **Kiro** | Agentic IDE | Medium | High |
| **Terraform/CDK** | General IaC | High | Maximum |
| **Leap.new** (unrelated) | AI developer agent | Low | High |

LEAP Stacks' unique value is the combination of (1) zero prerequisite AWS knowledge, (2) auto-cleanup preventing bill shock, (3) built-in cost observability, and (4) a progressive path from playground to production via GitHub export. No other tool in this space offers all four.

However, AWS's own trajectory with AgentCore (launched 2025, gaining CloudFormation/CDK/Terraform support) and Kiro may make LEAP Stacks' niche smaller over time as official tooling becomes more accessible.

## Pros and Cons

| Pros | Cons |
|------|------|
| Genuinely solves "bill shock" fear with auto-cleanup | Zero community adoption outside AWS channels |
| 7-minute deployment, no AWS expertise needed | Single contributor, non-standard git workflow |
| 12 well-curated stacks covering full GenAI spectrum | 311KB monolithic YAML; maintenance concerns |
| Built-in cost-per-message observability | No CI/CD or tests |
| Creator is credible AWS insider (Principal Advocate) | May be superseded by AWS's own improving tooling |
| Featured on AWS official channels | v2 moved to personal account (unclear official status) |
| GitHub export provides escape hatch to production | No community issues, PRs, or discussions |
| Discord community available | No independent reviews or benchmarks |

## Sources

- https://www.leapstacks.dev/
- https://github.com/bfateen/leapstacks2
- https://github.com/aws-samples/sample-ai-full-stacks
- https://dev.to/basilfateen/why-deploying-ai-agents-on-aws-is-so-hard-when-it-shouldnt-be-52g7
- https://www.youtube.com/watch?v=q_gikoRqDSg (Serverless Office Hours, 54:58)
- https://www.youtube.com/watch?v=2K-Bw5FD2oc (Introduction, 41:46)
- https://sifted.eu/articles/aws-genai-founder-startup-brnd
- https://www.linkedin.com/in/basilfateen/
- https://x.com/basilfateen
- https://discord.gg/DXhFXDQ8

---
*Generated by Research Agent on 2026-02-19*
