---
topic: DeepInfra (OpenRouter Provider)
slug: deepinfra-openrouter-provider
date: 2026-02-23
sources: [github, reddit, twitter, linkedin, web]
---

# DeepInfra (OpenRouter Provider) Research Report

## Overview

DeepInfra is a serverless AI inference platform founded in September 2022 by Nikola Borisov, Georgios Papoutsis, and Yessenzhar Kanapin — elite competitive programmers who previously built backend infrastructure for imo, a messaging app serving 200M+ users with billions of daily messages. The company has raised $28.6M across two rounds ($8M seed in Nov 2023, $20.6M Series A in Nov 2024) from Felicis Ventures, A.Capital Ventures, and others.

On OpenRouter, DeepInfra serves 73+ models and is consistently one of the cheapest providers, achieved through aggressive quantization (FP4/FP8) and deep infrastructure optimization. The surprising finding: this quantization doesn't measurably harm quality. DeepInfra scored 100% on MoonshotAI's K2-Vendor-Verifier precision benchmark (1365/1365), received a 10/10 writing quality rating from 16x Engineer's evaluation (beating Claude Sonnet 4's 9.5), and was included in OpenRouter's own Exacto quality routing system. As OpenRouter noted: "Deepinfra, which is the only provider quantizing the model to fp4, is quite competitive."

In February 2026, DeepInfra was featured prominently in NVIDIA's Blackwell cost-reduction announcement alongside Baseten, Fireworks AI, and Together AI, demonstrating up to 20x cost reduction through their three-layer optimization stack: Blackwell hardware + MoE architectures + proprietary software optimizations (TensorRT-LLM, speculative decoding, KV-cache-aware routing, off-GPU KV cache offloading). Latitude (AI Dungeon) uses DeepInfra on Blackwell for latency-critical gaming inference.

## Technical Analysis

### Infrastructure
- **Hardware:** NVIDIA H100, A100, and now Blackwell B200 GPUs
- **Optimization stack:** TensorRT-LLM, NVFP4 quantization, Multi-Token Prediction, Eagle speculative decoding, KV-cache-aware routing, off-GPU KV cache offloading
- **Architecture:** Serverless GPU hosting across multiple regions
- **API compatibility:** OpenAI-compatible APIs for easy migration
- **Model support:** 73+ models including Llama 4, DeepSeek V3, Qwen3, Kimi K2, GLM-5, MiniMax, and more
- **Context windows:** Up to 1M tokens (Llama 4 Maverick FP8)
- **Custom models:** LoRA fine-tuning support for text and image models, dedicated instances for custom deployments

### Performance Benchmarks

| Metric | DeepInfra | Groq | Together AI | Source |
|--------|-----------|------|-------------|--------|
| Cost (DeepSeek R1) | $0.55/$2.19 MTok | Higher | Higher | Helicone |
| Throughput (R1) | 13 tok/s | 275 tok/s | 134 tok/s | Helicone |
| TTFT (R1) | 0.54s | Lower | Similar | Helicone |
| Speed (Kimi K2) | 60-73 tok/s | 170-230 tok/s | 38-42 tok/s | 16x Engineer |
| Writing Quality (K2) | 10/10 | 8/10 | 8.5/10 | 16x Engineer |
| K2 Precision | 100% | 100% | — | K2-Vendor-Verifier |

**Key insight:** DeepInfra is not the fastest provider (Groq and Cerebras win on raw speed), but achieves the best quality-per-dollar ratio. The FP4 quantization that enables their low prices appears to have minimal impact on actual output quality across multiple independent benchmarks.

### Pricing Highlights
- **Cheapest models:** $0.02/MTok (Llama 3.2 3B, Llama 3.1 8B Turbo FP8)
- **Blackwell MoE pricing:** $0.05/MTok for 400B MoE models with NVFP4 on B200 (20x cheaper than dense 405B on H200)
- **Model:** Pay-per-token for language models, pay-per-second for other modalities
- **No long-term contracts** — pure pay-as-you-go
- **Privacy:** Zero data retention, no prompt training

### GitHub Presence
- Official org: github.com/deepinfra — minimal presence
- **deepinfra-node:** TypeScript SDK (stale since May 2024)
- **deepinfra-chat:** Sample Next.js app (Mar 2025)
- Community activity: Multiple third-party wrappers and "free API" proxy projects, indicating cost-conscious developer interest
- Vercel Labs maintains official AI SDK starter for DeepInfra

## User Sentiment

**Overall:** Mixed-to-Positive

### Reddit: The Primary Forum
- **Cost:** Universally praised — "deepinfra was by far the cheapest and has so far been very reliable," "best performance vs cost imo"
- **Quality:** Surprisingly good despite quantization — "96%+ is basically unnoticeable," "DeepInfra (fp4) scores higher than SiliconFlow (fp8)"
- **Privacy:** Favorably cited — zero retention policy, no prompt training
- **Reliability concerns:** Occasional outages during peak demand, context window reductions on free tier, model availability disruptions (pulled DeepSeek at one point)
- **Blacklist mentions:** Some users blacklist DeepInfra for "consistently producing low quality output" (minority view, contradicted by benchmark data)
- **Creative writing community:** SillyTavern/JanitorAI users frequently use DeepInfra through OpenRouter for uncensored access at low cost
- **Consensus:** "Don't marry a provider" — use DeepInfra when cost matters, official APIs when guaranteed precision matters

### Twitter: Minimal
- Near-zero social media presence; growth is word-of-mouth and platform-mediated (OpenRouter, NVIDIA partnerships)
- Unlike Groq (dramatic speed demos) or Cerebras (marketing buzz), DeepInfra operates quietly as infrastructure

### LinkedIn: Limited (Login-Gated)
- Company details sourced via Crunchbase/Tracxn/Felicis instead
- Professional visibility appears limited compared to better-funded competitors

## Competitive Landscape

### Direct Competitors on OpenRouter

| Provider | Funding | Strength | Weakness |
|----------|---------|----------|----------|
| **Groq** | $640M+ | Speed champion (LPU hardware) | Limited model selection, higher cost |
| **Together AI** | $246M | Broad model catalog, high quality | Slower throughput |
| **Fireworks AI** | $220M | Balanced speed/cost/quality | Less price-aggressive |
| **Cerebras** | $4.3B+ | Fastest inference (969 tok/s) | Limited model support |
| **SambaNova** | $1.1B+ | Enterprise focus, RDU chips | Higher cost, less flexible |
| **Novita AI** | Undisclosed | Cost-competitive | Quality/trust concerns on OpenRouter |
| **DeepInfra** | **$28.6M** | **Cheapest, quality despite quant** | **Speed mid-tier, minimal marketing** |

### Key Positioning
- **Felicis characterizes DeepInfra as** "the CDN of the LLM Age" — aspiring to globally distributed inference
- **Smallest funding** among major competitors by far ($28.6M vs $246M-$4.3B), yet competes effectively
- **Medium (Data Science Collective):** "DeepInfra and Novita are run by super-cracked engineers who are among the best in the world at optimized model serving. They exist to win the OpenRouter price leaderboards"
- **OpenRouter's Exacto system** includes DeepInfra among quality-verified providers for tool-calling routing

### NVIDIA Ecosystem
- Featured as one of 4 leading inference providers in NVIDIA's Blackwell announcements (Feb 2026)
- Alongside Baseten, Fireworks AI, Together AI — validated as tier-1 infrastructure partner
- Blackwell Ultra announcements continue to name DeepInfra as key partner

## Pros and Cons

| Pros | Cons |
|------|------|
| Cheapest or near-cheapest on OpenRouter | Speed mid-tier (not competing with Groq/Cerebras) |
| Aggressive quantization with minimal quality loss | Occasional model availability disruptions |
| 100% precision on K2 Vendor Verifier | Minimal GitHub/developer tooling presence |
| Zero data retention, no prompt training | Free tier context windows reduced |
| NVIDIA Blackwell partnership (20x cost reduction) | Smallest funding among major competitors |
| OpenAI-compatible API for easy migration | Near-zero marketing/social media presence |
| 73+ models, up to 1M context window | Some users report inconsistency with creative writing |
| Founded by ex-imo engineers (200M users) | FP4 quantization may matter for precision-critical tasks |
| Included in OpenRouter Exacto quality routing | Coding task response lengths inconsistent |

## Sources

### Company & Funding
- https://www.felicis.com/insight/deep-dive-deep-infra
- https://www.crunchbase.com/organization/deep-infra
- https://tracxn.com/d/companies/deep-infra/

### NVIDIA Partnership
- https://blogs.nvidia.com/blog/inference-open-source-models-blackwell-reduce-cost-per-token/
- https://deepinfra.com/blog/nvidia-blackwell-efficient-ai-inference
- https://venturebeat.com/infrastructure/ai-inference-costs-dropped-up-to-10x-on-nvidias-blackwell-but-hardware-is

### Benchmarks & Evaluations
- https://artificialanalysis.ai/providers/deepinfra
- https://eval.16x.engineer/blog/kimi-k2-provider-evaluation-results
- https://github.com/MoonshotAI/K2-Vendor-Verifier
- https://openrouter.ai/announcements/provider-variance-introducing-exacto

### Provider Comparisons
- https://www.helicone.ai/blog/llm-api-providers
- https://research.aimultiple.com/ai-providers/
- https://blog.gopenai.com/the-token-arbitrage-groq-vs-deepinfra-vs-cerebras-vs-fireworks-vs-hyperbolic-2025-benchmark

### Community Discussion
- https://www.reddit.com/r/LocalLLaMA/comments/1nsfkqd/
- https://www.reddit.com/r/openrouter/comments/1o1jwyv/
- https://www.reddit.com/r/LocalLLaMA/comments/1mk4kt0/
- https://www.reddit.com/r/openrouter/comments/1o223n2/
- https://www.reddit.com/r/SillyTavernAI/comments/1nu4fpb/

### Product
- https://openrouter.ai/provider/deepinfra
- https://deepinfra.com
- https://deepinfra.com/pricing
- https://deepinfra.com/models

---
*Generated by Research Agent on 2026-02-23*
