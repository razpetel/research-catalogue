# Chatterbox TTS

**Date:** 2026-02-04
**Sentiment:** Positive
**TL;DR:** Production-grade open-source TTS by Resemble AI with 22.2K GitHub stars. Three model variants (Turbo/Original/Multilingual) offering zero-shot voice cloning, emotion control, and paralinguistic tags. Claims to beat ElevenLabs in blind evaluations. MCP server available for Claude integration. Strong for English voice agents; multilingual and long-form audio need more work.

---

## Overview

Chatterbox is a family of three MIT-licensed text-to-speech models developed by Resemble AI, a Y Combinator-backed company. Released in 2025, it has rapidly become one of the most popular open-source TTS options with 22.2K GitHub stars.

### Model Variants

| Variant | Parameters | Languages | Best For |
|---------|------------|-----------|----------|
| **Turbo** | 350M | English | Real-time voice agents, sub-150ms latency |
| **Original** | 500M | English | Creative content, emotion control |
| **Multilingual** | 500M | 23 languages | Global applications |

### Supported Languages (Multilingual)
Arabic, Chinese, Danish, Dutch, English, Finnish, French, German, Greek, Hebrew, Hindi, Italian, Japanese, Korean, Malay, Norwegian, Polish, Portuguese, Russian, Spanish, Swedish, Swahili, Turkish

---

## Key Features

### Voice Cloning
Zero-shot cloning from ~5 seconds of reference audio. No transcription required (unlike F5-TTS which needs Whisper).

### Emotion Control
- **Exaggeration** (0.0-1.0): Controls emotional expressiveness
- **CFG Weight** (0.0-1.0): Classifier-free guidance strength
- **Paralinguistic Tags**: `[laugh]`, `[cough]`, `[chuckle]` for natural speech

### Perth Watermarking
Built-in imperceptible watermarks that survive MP3 compression and editing. Can be disabled with single line comment.

---

## Installation & Usage

```bash
pip install chatterbox-tts
```

### Basic Example
```python
import torchaudio as ta
from chatterbox.tts import ChatterboxTTS

model = ChatterboxTTS.from_pretrained(device="cuda")

text = "Hello, this is Chatterbox speaking."
wav = model.generate(text)
ta.save("output.wav", wav, model.sr)

# Voice cloning
wav = model.generate(text, audio_prompt_path="reference.wav")
```

### Turbo with Paralinguistic Tags
```python
from chatterbox.tts_turbo import ChatterboxTurboTTS

model = ChatterboxTurboTTS.from_pretrained(device="cuda")

text = "Hi there [chuckle], how can I help you today?"
wav = model.generate(text)
```

---

## Benchmarks

Evaluated via Podonos standardized suite against:
- ElevenLabs Turbo v2.5
- Cartesia Sonic 3
- VibeVoice 7B

Resemble claims Chatterbox "consistently outperforms ElevenLabs in blind evaluations" on preference, naturalness, and expressiveness.

**Community sentiment is mixed**: Some users agree, others find ElevenLabs still better, especially for non-English languages.

---

## Claude Integration

### MCP Server (digitarald/chatterbox-mcp)
10 GitHub stars. Lightweight single-purpose MCP server.

**Configuration (Claude Desktop):**
```json
{
  "mcpServers": {
    "chatterbox-tts": {
      "command": "python",
      "args": ["/path/to/chatterbox_mcp_server.py", "--auto-load-model"],
      "env": {}
    }
  }
}
```

**Tool:** `speak_text`
- `text` (required): Content to vocalize
- `exaggeration` (optional): 0.0-1.0
- `cfg_weight` (optional): 0.0-1.0

**Limitations:**
- macOS only (uses `afplay`)
- Significant GPU/CPU memory during model loading
- 10 stars = early adoption phase

---

## Ecosystem

### Community Projects
| Project | Purpose |
|---------|---------|
| **devnen/Chatterbox-TTS-Server** | OpenAI-compatible API + Web UI |
| **chatterbox-vllm** | vLLM port, ~300 it/s with batching |
| **ComfyUI_Fill-ChatterBox** | ComfyUI integration |
| **FluentVox** | Laravel PHP wrapper |

### Platform Availability
- Hugging Face Spaces (interactive demo)
- fal.ai (hosted inference)
- Replicate (API access)
- LocalAI (self-hosted)

---

## Limitations & Gotchas

1. **Long audio degrades**: Can sound robotic or produce artifacts on extended text
2. **Non-major languages struggle**: Microsoft VibeVoice-Large reportedly better for multilingual
3. **Reference audio quality matters**: Poor input = poor cloning
4. **Watermark by default**: One-line code change to disable
5. **Dependency issues**: Use `uv sync` for exact versions on problematic systems

---

## Competitive Landscape

| Model | Type | Strength |
|-------|------|----------|
| **ElevenLabs** | Closed | Production quality, multilingual |
| **Cartesia Sonic 3** | Closed | Speed |
| **Qwen3-TTS** | Open | Streaming, Alibaba ecosystem |
| **F5-TTS** | Open | Quality, but requires Whisper |
| **Chatterbox** | Open | Emotion control, no Whisper, MIT license |

---

## Who Should Use This

**Good fit:**
- Developers building voice agents with emotion
- Projects needing MIT-licensed TTS
- English-first applications
- Those wanting local/self-hosted TTS

**Wait or look elsewhere:**
- Production multilingual needs (consider ElevenLabs or VibeVoice)
- Long-form audiobook generation (quality degrades)
- Non-technical users (no polished UI)

---

## Links

- **GitHub:** https://github.com/resemble-ai/chatterbox
- **Hugging Face:** https://huggingface.co/ResembleAI/chatterbox
- **Demo:** https://huggingface.co/spaces/ResembleAI/Chatterbox
- **MCP Server:** https://github.com/digitarald/chatterbox-mcp
- **Benchmarks:** https://www.podonos.com/resembleai/chatterbox-turbo-vs-elevenlabs-turbo
- **Company:** https://www.resemble.ai/chatterbox/
