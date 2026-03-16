# DeelMarkt

> Trust-first Dutch P2P marketplace — a modern alternative to Marktplaats. *"Deel wat je hebt."*

**Domain:** deelmarkt.com | **Stack:** Flutter + Supabase + Mollie | **MVP cost: ~€25-35/mo**

---

## Quick Start

```bash
git clone <repo-url> DeelMarkt && cd DeelMarkt
bash scripts/setup.sh          # macOS/Linux
# or: .\scripts\setup.ps1      # Windows PowerShell
```

Then read [CLAUDE.md](CLAUDE.md) for development rules and start with [Epic E07](docs/epics/E07-infrastructure.md).

---

## Documentation

| Document | Purpose |
|:---------|:--------|
| [CLAUDE.md](CLAUDE.md) | Development rules, architecture, coding standards |
| [Setup Guide](docs/SETUP.md) | Environment setup, prerequisites, troubleshooting |
| [Sprint Plan](docs/SPRINT-PLAN.md) | Per-developer tasks, ownership, conflict prevention |
| [ARCHITECTURE.md](docs/ARCHITECTURE.md) | Tech stack, backend, search, observability, ADRs |
| [COMPLIANCE.md](docs/COMPLIANCE.md) | Trust, security, GDPR, DSA, PSD2, legal |
| [Design System](docs/design-system/) | Tokens, components, patterns, accessibility |
| [Epics](docs/epics/README.md) | 8 development epics with acceptance criteria |
| [ROADMAP.md](docs/ROADMAP.md) | Phased timeline with KPIs |

## Tech Stack

| Layer | Service | Cost |
|:------|:--------|:-----|
| Frontend | Flutter 3.x + Dart 3.x | — |
| Backend | Supabase Pro | $25/mo |
| Payments | Mollie Connect (iDEAL) | per-tx |
| Feature Flags | Unleash (self-hosted) | $0-7/mo |
| Push/Crashes/Analytics | Firebase (free) | $0 |
| CDN + WAF | Cloudflare (free) | $0 |
| Images | Cloudinary (free) | $0 |
| Cache | Upstash Redis (free) | $0 |

## License

All rights reserved.
