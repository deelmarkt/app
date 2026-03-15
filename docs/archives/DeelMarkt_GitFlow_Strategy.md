# DeelMarkt GitFlow Strategy

> **Version**: 1.0.0
> **Last Updated**: 2026-03-15
> **Status**: Active
> **Authors**: Emre Dursun (Lead), Team DeelMarkt
> **Standard**: Aligned with Google, Amazon, and Netflix branching best practices

---

## 1. Philosophy

DeelMarkt follows a **Trunk-Based Development hybrid** — the same methodology employed by Google (35,000+ engineers), Amazon, and Netflix.

| Principle | Rationale |
|:----------|:----------|
| **Single integration branch** | All contributors merge into one shared `dev` branch, preventing N-way divergence |
| **Short-lived feature branches** | Branches live for hours to days (never weeks), reducing merge conflict risk |
| **Feature isolation, not developer isolation** | Branches represent *work items*, not *people* — enabling clean rollbacks and atomic PRs |
| **Always-releasable trunk** | `main` is always in a deployable state; `production` reflects live code |

---

## 2. Branch Architecture

```
feature/auth-module ──┐
feature/user-api ─────┤──→ dev ──→ main ──→ production
fix/login-bug ────────┘                  ↑
                                         │
hotfix/critical-fix ─────────────────────┘
```

### Environment Mapping

| Branch | Environment | Stability Level |
|:-------|:------------|:----------------|
| `production` | Production (live users) | 🟢 Stable — battle-tested |
| `main` | Staging / Pre-production | 🔵 Release-ready — fully reviewed |
| `dev` | Development / Integration | 🟡 Integration — CI on every PR |
| `feature/*` | Local / PR preview | 🟠 Experimental — developer workspace |

---

## 3. Branch Taxonomy

### Permanent Branches (never deleted)

| Branch | Receives from | Direct commits | Protection |
|:-------|:-------------|:---------------|:-----------|
| `production` | `main` only (via release PR) | ❌ Never | PR + approval + CI |
| `main` | `dev` (sprints), `hotfix/*` (emergency) | ❌ Never | PR + approval + CI |
| `dev` | `feature/*`, `fix/*`, `docs/*`, etc. | ❌ Never | PR + CI |

### Short-Lived Branches (deleted after merge)

| Prefix | Purpose | From → Into | Lifetime |
|:-------|:--------|:------------|:---------|
| `feature/` | New functionality | `dev` → `dev` | Hours – days |
| `fix/` | Bug fixes | `dev` → `dev` | Hours – days |
| `docs/` | Documentation updates | `dev` → `dev` | Hours |
| `refactor/` | Code improvements | `dev` → `dev` | Hours – days |
| `test/` | Test additions | `dev` → `dev` | Hours |
| `chore/` | Tooling, config, deps | `dev` → `dev` | Hours |
| `hotfix/` | Emergency production fixes | `main` → `main` + `dev` | Hours |

### Naming Convention

Use lowercase kebab-case: `<type>/<short-descriptive-name>`

```
feature/marketplace-listing-api
fix/cart-total-calculation
docs/api-endpoint-reference
hotfix/critical-auth-bypass
```

---

## 4. Contributor Workflow

```powershell
# 1. Ensure dev is up to date
git checkout dev
git pull origin dev

# 2. Create a feature branch
git checkout -b feature/marketplace-listing-api

# 3. Work in small, atomic commits
git add .
git commit -m "feat(marketplace): add listing creation endpoint"

# 4. Push and open PR → dev
git push -u origin feature/marketplace-listing-api
```

### Pull Request Lifecycle

```
┌─────────────────────────────────────────────────────┐
│               Pull Request Lifecycle                 │
├─────────────────────────────────────────────────────┤
│                                                      │
│  1. Developer opens PR (feature/* → dev)             │
│  2. CI pipeline runs automatically                   │
│     ├── Lint check                                   │
│     ├── Type check                                   │
│     ├── Unit tests                                   │
│     ├── Build verification                           │
│     └── Security scan (if configured)                │
│  3. Code review by at least 1 team member            │
│  4. Address review feedback (if any)                 │
│  5. Squash-merge into dev                            │
│  6. Delete the feature branch (auto or manual)       │
│                                                      │
└─────────────────────────────────────────────────────┘
```

### Staying Up to Date

```powershell
git fetch origin && git rebase origin/dev
git push --force-with-lease   # safe for feature branches only
```

---

## 5. Merge Strategy

| Source → Target | Method | Rationale |
|:----------------|:-------|:----------|
| `feature/*` → `dev` | **Squash merge** | Clean history, one commit per feature |
| `dev` → `main` | **Merge commit** | Preserves sprint boundary |
| `main` → `production` | **Merge commit** | Preserves release history with tags |
| `hotfix/*` → `main` | **Squash merge** | Fast, clean emergency fix |
| Hotfix backport → `dev` | **Cherry-pick** | Ensures dev includes the fix |

---

## 6. Commit Standards

Format: `<type>(<scope>): <description>`

| Type | Purpose | Example |
|:-----|:--------|:--------|
| `feat` | New feature | `feat(marketplace): add product listing API` |
| `fix` | Bug fix | `fix(cart): correct total calculation with discounts` |
| `docs` | Documentation | `docs(api): add endpoint reference for listings` |
| `refactor` | Code refactoring | `refactor(payment): extract validation logic` |
| `test` | Test changes | `test(auth): add JWT token expiry tests` |
| `chore` | Tooling, config | `chore(deps): update express to v5.1` |
| `perf` | Performance | `perf(search): add database index for product queries` |
| `ci` | CI/CD changes | `ci(github): add lint step to PR workflow` |

**Rules**: imperative mood, max 72 chars subject, include scope per module.

---

## 7. Hotfix Protocol

Hotfixes bypass the normal `feature → dev → main` flow because they address critical production issues.

```
                    main
                      │
        ┌─────────────┤
        │             │
   hotfix/fix-name    │
        │             │
        ├─────────────┤ (squash merge to main)
        │             │
        │         production
        │             │
        │             ├── (merge main → production)
        │             │
        └──→ dev      │   (cherry-pick to dev)
```

```powershell
# 1. Create hotfix from main
git checkout main && git pull origin main
git checkout -b hotfix/critical-auth-bypass

# 2. Fix (minimal, surgical changes only)
git commit -m "fix(auth): patch critical authentication bypass"

# 3. PR → main → merge → deploy to production
# 4. Cherry-pick into dev
git checkout dev && git cherry-pick <sha> && git push origin dev
```

---

## 8. Release Lifecycle

```
                    Sprint Boundary
                         │
  dev  ──────────────────┤
                         │
                    Create PR: dev → main
                    Title: "Release v1.2.0 — Sprint 3"
                         │
                    Review + CI Gates
                         │
                    Merge (merge commit)
                         │
  main ──────────────────┤
                         │
                    Create PR: main → production
                    Title: "Deploy v1.2.0"
                         │
                    Final review
                         │
                    Merge + Tag: v1.2.0
                         │
  production ────────────┤
```

### Semantic Versioning

| Change Type | Version Bump | Example |
|:------------|:-------------|:--------|
| Breaking changes | Major | `v1.0.0` → `v2.0.0` |
| New features | Minor | `v1.0.0` → `v1.1.0` |
| Bug fixes / Hotfixes | Patch | `v1.0.0` → `v1.0.1` |

```powershell
# Tag after merging main → production
git checkout production && git pull origin production
git tag -a v1.2.0 -m "Release v1.2.0 — Sprint 3: Marketplace MVP"
git push origin v1.2.0
```

---

## 9. Branch Protection Rules

| Branch | PR Required | Approvals | CI Must Pass | Force Push | Delete |
|:-------|:------------|:----------|:-------------|:-----------|:-------|
| `production` | ✅ | 1 min | ✅ | ❌ Never | ❌ Never |
| `main` | ✅ | 1 min | ✅ | ❌ Never | ❌ Never |
| `dev` | ✅ | 0 (self-merge OK) | ✅ | ❌ Never | ❌ Never |

---

## 10. Complete Flow Overview

```
┌──────────────────────────────────────────────────────────────────────┐
│                     DeelMarkt GitFlow Strategy                       │
├──────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  CONTRIBUTOR WORKSPACE                                               │
│  ┌────────────────────────┐                                          │
│  │  feature/listing-api   │──┐                                       │
│  │  feature/user-auth     │──┤                                       │
│  │  fix/cart-bug           │──┤── PR (squash) ──→ dev                │
│  │  docs/api-reference    │──┤                    │                  │
│  │  refactor/payments     │──┘                    │                  │
│  └────────────────────────┘                       │                  │
│                                                    │                  │
│  INTEGRATION                                       │                  │
│  ┌──────────────────────────────────┐              │                  │
│  │  dev (shared development)        │◄─────────────┘                 │
│  │  CI: lint + type + test + build  │                                │
│  └──────────────┬───────────────────┘                                │
│                 │                                                     │
│                 │ PR (merge commit) — Sprint Release                  │
│                 ▼                                                     │
│  STAGING                                                             │
│  ┌──────────────────────────────────┐                                │
│  │  main (release-ready)            │◄── hotfix/* (emergency)        │
│  │  Full quality gates              │                                │
│  └──────────────┬───────────────────┘                                │
│                 │                                                     │
│                 │ PR (merge commit) + Tag (v1.x.x)                   │
│                 ▼                                                     │
│  PRODUCTION                                                          │
│  ┌──────────────────────────────────┐                                │
│  │  production (live)               │                                │
│  │  Tagged releases only            │                                │
│  └──────────────────────────────────┘                                │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 11. Anti-Patterns

| Anti-Pattern | Correct Pattern |
|:-------------|:----------------|
| Per-developer long-lived branches | Short-lived feature branches |
| Direct commits to `main` or `production` | Always use PRs |
| Feature branches living > 1 week | Break into smaller tasks |
| Merging `dev` → `production` directly | Always go through `main` |
| Force-push to permanent branches | Only `--force-with-lease` on feature branches |
| Committing `.env`, secrets, `node_modules` | Use `.gitignore` + env variables |
| Vague commit messages | Follow Conventional Commits |

---

## Appendix: Industry Validation

| Company | Team Size | Strategy | Key Insight |
|:--------|:----------|:---------|:------------|
| **Google** | 35,000+ | Trunk-Based (monorepo) | Single trunk, feature flags, direct commits |
| **Amazon** | 10,000+ | Trunk-Based | Small commits, multiple daily integrations |
| **Netflix** | 2,000+ | Feature Branch + Trunk | Short-lived feature branches, PR reviews |
| **Meta** | 20,000+ | Trunk-Based (monorepo) | Ship from trunk, automated testing at scale |
| **Spotify** | 3,000+ | Squad-Based + Trunk | Autonomous squads, shared trunk, feature flags |

DeelMarkt's 3-branch model mirrors Netflix's approach — optimal for a small team building a marketplace platform.

---

> **Document Classification**: Strategic Architecture Document
> **Review Cycle**: Quarterly or upon team scaling events
> **Owner**: Emre Dursun, Lead Engineer
