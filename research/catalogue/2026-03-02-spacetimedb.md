---
topic: SpacetimeDB
slug: spacetimedb
date: 2026-03-02
sources: [github, reddit, twitter, linkedin, web]
---

# SpacetimeDB Research Report

## Overview

**SpacetimeDB** is a high-performance, in-memory relational database written in Rust that merges database and application server into a single deployable unit. Developed by **Clockwork Labs** (founded 2019, San Francisco), it allows developers to upload application logic as "modules" -- essentially stored procedures written in Rust, C#, TypeScript, or C++ -- that execute inside the database itself. Clients connect directly to the database, bypassing the need for a separate web or game server, with real-time state synchronization pushed automatically to all connected clients.

Originally built as the backend for **BitCraft Online**, Clockwork Labs' MMORPG where the entire game world (terrain, items, chat, player positions) runs as a single SpacetimeDB module, the technology was open-sourced and generalized for broader use. The project hit **1.0 in March 2025** and rapidly iterated to **2.0 in February 2026**, with the latest release claiming over 170,000 transactions per second for Rust modules and 100,000+ TPS for TypeScript modules.

SpacetimeDB has accumulated **21,891 GitHub stars** and **801 forks** with ~97 contributors. It is trending upward in developer attention, particularly in the game development and real-time applications communities. The project is licensed under **BSL 1.1** (Business Source License), which converts to AGPL v3.0 with a linking exception after a few years -- users are not required to open-source their own code.

## Technical Analysis

### Repository Health
- **URL:** https://github.com/clockworklabs/SpacetimeDB
- **Stars:** 21,891 | **Forks:** 801
- **Language:** Rust (primary)
- **License:** BSL 1.1 (converts to AGPL v3.0 + linking exception)
- **Created:** 2023-06-17
- **Last Push:** 2026-03-02 (actively maintained)
- **Latest Release:** v2.0.2 (Feb 26, 2026)
- **Open Issues:** 721
- **Contributors:** ~97
- **Status:** **Actively developed** -- multiple releases per month, consistent commits

### Architecture
SpacetimeDB's core design collapses the traditional three-tier architecture (client -> server -> database) into two tiers (client -> SpacetimeDB):

- **In-Memory Execution:** All application state is held in RAM for nanosecond lookups. Data is persisted via a Write-Ahead Log (WAL) for crash recovery.
- **Modules:** Application logic is compiled to WebAssembly and uploaded to the database. Modules define tables (schema), reducers (event handlers/mutations), and views.
- **Reducers:** The primary interface for mutations -- called directly from clients or via subscriptions. They execute transactionally with ACID guarantees.
- **Real-Time Sync:** Subscription queries allow clients to declaratively subscribe to subsets of data. Changes are pushed automatically.
- **Identity System:** Built-in authentication with SpacetimeAuth (v1.5.0+), plus integrations for Clerk and Auth0.

### Key Features (v2.0)
| Feature | Detail |
|---------|--------|
| **Module Languages** | Rust, C#, TypeScript/JavaScript, C++ |
| **Client SDKs** | Rust, C#, TypeScript, Python, Unreal Engine (C++) |
| **Game Engine Support** | Unity (official C# SDK), Unreal Engine (official), Godot (community SDK), Bevy (community) |
| **Web Framework Support** | React, Vue, Next.js, Svelte, Remix, Nuxt, Angular, TanStack, Bun, Deno |
| **Real-Time Sync** | Subscription queries with automatic client push |
| **Typed Query Builder** | Strongly-typed client-side queries (v1.12.0+) |
| **Event Tables** | Short-lived data auto-deleted at transaction end |
| **View Functions** | Automatic row-level security based on client identity |
| **Procedures** | HTTP calls from within modules (external API integration) |
| **Postgres Wire Protocol** | Basic `psql` compatibility for direct SQL queries |
| **SpacetimeAuth** | First-party authentication and user management |
| **spacetime dev** | Hot-reload development command (watch, compile, publish, generate bindings) |

### Performance Claims (v2.0)
- **170,000 TPS** for Rust modules
- **100,000+ TPS** for TypeScript modules
- Described as "eye-watering throughput even for tiny transactions with high contention"
- Entire database held in memory; practical limit is available RAM

### Ecosystem & SDKs
Clockwork Labs maintains several companion repositories:
- `com.clockworklabs.spacetimedbsdk` -- C# SDK (Unity integration)
- `spacetimedb-typescript-sdk` -- TypeScript/JavaScript SDK
- `spacetimedb-python-sdk` -- Python SDK
- `spacetimedb-cookbook` -- Example patterns and recipes
- `spacetimedb-minecraft` -- Minecraft server implementation in Rust on SpacetimeDB

Community projects:
- `bevy_spacetimedb` -- Bevy engine integration (JulienLavocat)
- `Godot-SpacetimeDB-SDK` -- GDScript SDK for Godot (flametime)
- `SpacetimeDB-Admin` -- Admin interface (JulienLavocat)
- `vibe-coding-starter-pack-3d-multiplayer` -- Three.js + React + SpacetimeDB starter kit

### Release Cadence
SpacetimeDB has maintained an aggressive release schedule:
- **v1.0** (Mar 2025) -- Initial stable release
- **v1.5.0** -- SpacetimeAuth & Postgres Wire Format
- **v1.8.0** (Nov 2025) -- Module Defined Views
- **v1.10.0** (Nov 2025) -- Procedures and HTTP Requests
- **v1.11.0** (Dec 2025) -- Typed Query Builder
- **v1.12.0** (Feb 2026) -- Client-side Typed Query Builder
- **v2.0.1** (Feb 20, 2026) -- Major release: TypeScript out of beta, C++ modules, UE5 support, massive performance gains
- **v2.0.2** (Feb 26, 2026) -- Bug fixes

### Pricing (Maincloud)
| Tier | Price | Energy Credits |
|------|-------|----------------|
| Free | $0/month | 2,500 TeV |
| Pro | $25/month | 100,000 TeV |
| Team/Enterprise | Custom | Custom |

Scales to zero when idle -- pay only for what you use. Self-hosting is free (install via CLI, Docker, or build from source).

## User Sentiment

### Reddit Sentiment (20+ threads analyzed)

**Positive:**
- r/gamedev: "SpacetimeDB 1.0 just released, it tries to make it possible for indie devs to build MMOs" -- 223 upvotes, 104 comments. Strong enthusiasm from indie game developers who see it as a breakthrough for small teams building multiplayer games.
- r/rust: "SpacetimeDB 2.0 is out!" -- Active discussion with SpacetimeDB developers (including Centril/etareduce) answering questions directly. Developers praise the performance improvements.
- r/bevy: Users sharing projects built with SpacetimeDB ("FriginRain" MMO), positive reception for the Bevy integration.
- r/godot: Community-built SDK getting traction, users reporting success with multiplayer games.
- r/devops: "If real it seems revolutionary" -- enthusiasm tempered by healthy skepticism.
- r/SpacetimeDB: Active subreddit with release announcements and non-game use case discussions.

**Skeptical/Critical:**
- r/theprimeagen: "Debunking SpacetimeDB's performance claims" -- Skepticism about benchmark methodology, noting different clients/protocols/concurrency settings across comparisons.
- r/programming: "Is SpacetimeDB a Yak-Shaving Success Story?" -- Questions about whether a game studio making a database is a viable business model. Founder Tyler Cloutier responded directly.
- r/gamedev: "Is SpacetimeDB really what it claims to be or just extremely over-advertised tech?" -- Mixed responses. Some users report good experience for thin-client architectures but warn against use cases with significant client-side state.
- BSL license is a recurring concern in r/rust threads -- "I'm not a fan of the BSL license."

**Neutral/Informative:**
- Non-game use cases are being explored (r/SpacetimeDB: "Non-game uses?")
- Go community (r/golang) asking for Go module support
- Community SDK development for Godot shows grassroots adoption

### Hacker News Sentiment
- An "honest analysis" of SpacetimeDB 2.0 benchmarks gained traction, criticizing the methodology as potentially misleading due to inconsistent comparison parameters (different clients, protocols, concurrency levels). The author characterized it as "a little dishonest" but invited correction.
- HN commenters compare SpacetimeDB to Elixir and Node.js in terms of "adopting a stack for rare guarantees while accepting new limits."

### News & Blog Coverage
- **Medium:** Multiple developer blog posts about building MMORPGs with SpacetimeDB. Martin Erlic's "From Starter Pack to Full MMORPG" chronicles building an open-source survival game.
- **DEV Community:** SpacetimeDB trending on GitHub (Feb 2026), featured in daily intelligence recaps.
- **Local First News:** Covered as "a real-time backend framework and database for apps and games."
- **YouTube:** Founder Tyler Cloutier's "FASTEST database in the world - SpacetimeDB 2.0" video drove significant attention, followed by third-party analysis videos ("How FAST is SpacetimeDB REALLY!?", "SpacetimeDB Reaction by System Architect").

### LinkedIn / Professional
- **Clockwork Labs** has 3,559 LinkedIn followers. The company describes itself as "Creating virtual worlds through precision engineering."
- Founded 2019 in San Francisco.
- Active posting about SpacetimeDB releases, Pragma conference appearances, and the expansion into web development.
- Team members (Tyler Cloutier, Tyler Lefky) are active on LinkedIn discussing SpacetimeDB.

### Twitter/X
- Official account: @spacetime_db, founder: @TylerFCloutier
- SpacetimeDB 2.0 launch generated significant X engagement
- Shayan (@ImSh4yy): "Ok, SpacetimeDB is actually pretty cool! It gives you almost everything you need on the server side to build a multiplayer game. Think of it as Supabase but for building games."

## Competitive Landscape

### Direct Comparisons

| Feature | SpacetimeDB | Firebase | Supabase | Nakama | Colyseus |
|---------|------------|----------|----------|--------|----------|
| **Type** | DB + Server | BaaS | BaaS (Postgres) | Game server | Game server |
| **Data Model** | Relational (in-memory) | NoSQL (Firestore) | Relational (Postgres) | Relational + NoSQL | In-memory state |
| **Server Logic** | Modules (Rust/C#/TS/C++) | Cloud Functions | Edge Functions | Go/Lua hooks | Node.js rooms |
| **Real-Time** | Native subscriptions | Native listeners | Realtime channels | Native | Native |
| **Self-Host** | Yes (BSL 1.1) | No | Yes (Apache 2.0) | Yes (Apache 2.0) | Yes (MIT) |
| **Game Focus** | Primary | Secondary | No | Primary | Primary |
| **In-Memory** | Yes (all data) | No | No | Partial | Yes (room state) |
| **ACID** | Yes | Limited | Yes | Limited | No |
| **Persistence** | WAL | Built-in | Built-in | Built-in | External DB |
| **Pricing** | Free tier + $25/mo Pro | Free tier + pay-as-go | Free tier + $25/mo | Free (self-host) | Free (self-host) |

### Key Differentiators vs Competitors
- **vs Firebase/Supabase:** SpacetimeDB runs application logic *inside* the database, eliminating cold starts and network hops between server and DB. Firebase/Supabase require separate cloud/edge functions.
- **vs Nakama/Colyseus:** SpacetimeDB provides full ACID guarantees with a relational model. Traditional game servers handle state in memory without transactional guarantees.
- **vs Smart Contracts:** SpacetimeDB draws an analogy to smart contracts (code executed in a shared state machine) but is orders of magnitude faster and has no blockchain overhead.
- **vs Traditional Game Servers:** One SpacetimeDB module replaces the web server, game server, and database. Claimed to reduce infrastructure complexity dramatically.

### Potential Weaknesses
- **Memory-bound:** All data must fit in RAM. Not suitable for OLAP, analytics, or datasets larger than available memory.
- **BSL License:** Not true open source. Some developers and organizations are wary of BSL restrictions.
- **Vendor Risk:** Small company (team of ~8-15 people) with a complex, novel technology.
- **Single-node Limitation:** Current architecture appears to be single-node for a given module (horizontal scaling not yet documented).
- **Benchmark Controversy:** Independent analysis suggests marketing benchmarks may use inconsistent methodology.
- **Maturity:** Still a young product (1.0 only in March 2025). 721 open issues suggest active but incomplete feature set.

## Pros and Cons

| Pros | Cons |
|------|------|
| Dramatically simplifies multiplayer game backend architecture | All data must fit in RAM -- not suitable for large datasets |
| Extremely high throughput (100K-170K TPS claimed) | BSL 1.1 license is not true open source |
| Write server logic in Rust, C#, TypeScript, or C++ | Relatively new -- 1.0 was only March 2025 |
| Native real-time sync eliminates custom networking code | Benchmark claims have been questioned by independent analysis |
| ACID transactions with relational model | Small team creates vendor/sustainability risk |
| Official Unity, Unreal Engine, and web framework integrations | 721 open issues indicate many rough edges remain |
| Free self-hosting and generous free cloud tier | Horizontal scaling story is unclear |
| Active development with rapid release cadence | Lock-in: application logic tightly coupled to SpacetimeDB paradigm |
| Production-proven (BitCraft Online MMORPG) | Not suited for OLAP/analytics workloads |
| Growing community SDKs (Godot, Bevy) | Module debugging and testing workflow still maturing |
| SpacetimeAuth and Postgres wire protocol add versatility | Non-game use cases are still early and less proven |

## Sources

### GitHub
- https://github.com/clockworklabs/SpacetimeDB (main repo, 21.9K stars)
- https://github.com/clockworklabs/SpacetimeDB/releases/tag/v2.0.1 (2.0 release)
- https://github.com/clockworklabs/com.clockworklabs.spacetimedbsdk (C# SDK)
- https://github.com/clockworklabs/spacetimedb-typescript-sdk (TypeScript SDK)
- https://github.com/flametime/Godot-SpacetimeDB-SDK (Community Godot SDK)
- https://github.com/JulienLavocat/bevy_spacetimedb (Community Bevy integration)

### Reddit
- https://www.reddit.com/r/gamedev/comments/1j3dy5k/ (1.0 release, 223 upvotes)
- https://www.reddit.com/r/rust/comments/1rdoip9/ (2.0 release discussion)
- https://www.reddit.com/r/theprimeagen/comments/1rf87kw/ (benchmark skepticism)
- https://www.reddit.com/r/programming/comments/1k0oste/ (yak-shaving discussion)
- https://www.reddit.com/r/devops/comments/1jv21uy/ (DevOps perspective)
- https://www.reddit.com/r/gamedev/comments/1j91y94/ (real-world evaluation)
- https://www.reddit.com/r/SpacetimeDB/comments/1nve6vp/ (v1.5.0 SpacetimeAuth)
- https://www.reddit.com/r/unrealengine/comments/1nolb2w/ (Unreal Engine support)

### Hacker News
- https://news.ycombinator.com/item?id=47148920 (benchmark analysis)
- https://news.ycombinator.com/item?id=43631822 (general discussion)

### LinkedIn
- https://www.linkedin.com/company/clockwork-labs (Clockwork Labs company page)
- https://www.linkedin.com/in/tylercloutier/ (Tyler Cloutier, founder)

### Web & News
- https://spacetimedb.com (official website)
- https://spacetimedb.com/docs/intro/faq/ (FAQ with comparisons)
- https://spacetimedb.com/blog/introducing-spacetimedb-1-0 (1.0 announcement)
- https://medium.com/@SeloSlav/from-starter-pack-to-full-mmorpg-how-spacetimedb-and-ai-helped-me-ship-my-dream-game-bf8f9da59b89 (developer experience blog)
- https://dev.to/dantesbytes/spacetimedb-a-new-era-of-multiplayer-apps-386p (DEV Community overview)
- https://gist.github.com/britg/75d629f6f3706bfdc3471146efd4e052 (benchmark analysis gist)

### YouTube
- https://www.youtube.com/watch?v=C7gJ_UxVnSk ("FASTEST database in the world - SpacetimeDB 2.0")
- https://www.youtube.com/watch?v=Gowrwaou-UI ("How FAST is SpacetimeDB REALLY!?")
- https://www.youtube.com/watch?v=lhRUZ1iLdYU ("SpacetimeDB Reaction by System Architect")
