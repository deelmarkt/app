# DeelMarkt GitFlow Strategy

> **Version**: 1.0.0
> **Last Updated**: 2026-03-15
> **Status**: Active
> **Authors**: Emre Dursun (Contributor), Team DeelMarkt
> **Standard**: Aligned with Google, Amazon, and Netflix branching best practices

---

## Table of Contents

1. [Philosophy](#1-philosophy)
2. [Branch Architecture](#2-branch-architecture)
3. [Branch Taxonomy](#3-branch-taxonomy)
4. [Contributor Workflow](#4-contributor-workflow)
5. [Merge Strategy](#5-merge-strategy)
6. [Commit Standards](#6-commit-standards)
7. [Hotfix Protocol](#7-hotfix-protocol)
8. [Release Lifecycle](#8-release-lifecycle)
9. [Branch Protection Rules](#9-branch-protection-rules)
10. [Visual Reference](#10-visual-reference)
11. [Quick Reference Card](#11-quick-reference-card)
12. [Anti-Patterns](#12-anti-patterns)

---

## 1. Philosophy

DeelMarkt follows a **Trunk-Based Development hybrid** — the same methodology employed by Google (35,000+ engineers), Amazon, and Netflix. The core principles are:

| Principle                                      | Rationale                                                                               |
| :--------------------------------------------- | :-------------------------------------------------------------------------------------- |
| **Single integration branch**                  | All contributors merge into one shared `dev` branch, preventing N-way divergence        |
| **Short-lived feature branches**               | Branches live for hours to days (never weeks), reducing merge conflict risk             |
| **Feature isolation, not developer isolation** | Branches represent _work items_, not _people_ — enabling clean rollbacks and atomic PRs |
| **Always-releasable trunk**                    | `main` is always in a deployable state; `production` reflects live code                 |

### Why NOT Per-Developer Branches?

Per-developer long-lived branches (`dev/emre`, `dev/mahmut`, etc.) are an anti-pattern because:

- **Branch proliferation**: Scales linearly with team size (10 devs = 10 persistent branches)
- **Merge conflict amplification**: Each branch diverges independently, creating complex N-way merges
- **No feature isolation**: A developer's branch accumulates unrelated changes, making rollbacks impossible
- **No industry precedent**: No FAANG company uses this model

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

| Branch       | Environment               | Deployment         | Stability Level                                |
| :----------- | :------------------------ | :----------------- | :--------------------------------------------- |
| `production` | Production (live users)   | Automated on merge | 🟢 Stable — battle-tested                      |
| `main`       | Staging / Pre-production  | Automated on merge | 🔵 Release-ready — fully reviewed              |
| `dev`        | Development / Integration | CI on every PR     | 🟡 Integration — may have in-progress features |
| `feature/*`  | Local / PR preview        | None               | 🟠 Experimental — developer workspace          |

---

## 3. Branch Taxonomy

### 3.1 Permanent Branches

These branches exist for the entire lifetime of the project. They are **never deleted**.

#### `production`

- **Purpose**: Reflects exactly what is running in production
- **Receives merges from**: `main` only (via release PR)
- **Direct commits**: ❌ Never
- **Protection**: Full — requires PR, review approval, passing CI
- **Tagging**: Every merge is tagged with a semantic version (`v1.0.0`)

#### `main`

- **Purpose**: Stable integration branch — always release-ready
- **Receives merges from**: `dev` (sprint releases), `hotfix/*` (emergency fixes)
- **Direct commits**: ❌ Never
- **Protection**: Full — requires PR, review approval, passing CI

#### `dev`

- **Purpose**: Active development integration point for all contributors
- **Receives merges from**: `feature/*`, `fix/*`, `docs/*`, `refactor/*`, `test/*`
- **Direct commits**: ❌ Never (PR required from feature branches)
- **Protection**: Semi-protected — requires PR, CI must pass

### 3.2 Short-Lived Branches

These branches are created for specific work items and deleted after merging.

| Prefix      | Purpose                                | Branches from | Merges into    | Lifetime     |
| :---------- | :------------------------------------- | :------------ | :------------- | :----------- |
| `feature/`  | New functionality                      | `dev`         | `dev`          | Hours – days |
| `fix/`      | Bug fixes                              | `dev`         | `dev`          | Hours – days |
| `docs/`     | Documentation updates                  | `dev`         | `dev`          | Hours        |
| `refactor/` | Code improvements (no behavior change) | `dev`         | `dev`          | Hours – days |
| `test/`     | Test additions or improvements         | `dev`         | `dev`          | Hours        |
| `chore/`    | Tooling, config, dependency updates    | `dev`         | `dev`          | Hours        |
| `hotfix/`   | Emergency production fixes             | `main`        | `main` + `dev` | Hours        |

### 3.3 Naming Convention

```
<type>/<short-descriptive-name>
```

**Examples:**

```
feature/marketplace-listing-api
feature/user-authentication
fix/cart-total-calculation
docs/api-endpoint-reference
refactor/payment-service-cleanup
hotfix/critical-auth-bypass
```

**Rules:**

- Use lowercase with hyphens (kebab-case)
- Keep names descriptive but concise (2–5 words)
- No developer names in branch names
- No ticket/issue numbers unless a ticket system is in use

---

## 4. Contributor Workflow

### 4.1 Starting Work on a New Feature

```powershell
# 1. Ensure dev is up to date
git checkout dev
git pull origin dev

# 2. Create a feature branch
git checkout -b feature/marketplace-listing-api

# 3. Work in small, atomic commits
git add .
git commit -m "feat(marketplace): add listing creation endpoint"

# 4. Push the feature branch
git push -u origin feature/marketplace-listing-api

# 5. Open a Pull Request: feature/marketplace-listing-api → dev
```

### 4.2 Pull Request Lifecycle

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

### 4.3 Keeping Feature Branches Up to Date

When `dev` has moved forward while you're working:

```powershell
# Rebase your feature branch onto latest dev
git checkout feature/marketplace-listing-api
git fetch origin
git rebase origin/dev

# If conflicts arise, resolve them and continue
git rebase --continue

# Force-push the rebased branch (safe for feature branches)
git push --force-with-lease
```

> **Note**: Prefer `rebase` over `merge` for feature branches to maintain a linear history. Use `--force-with-lease` (not `--force`) for safety.

---

## 5. Merge Strategy

| Merge Type              | Source → Target       | Method           | Rationale                                          |
| :---------------------- | :-------------------- | :--------------- | :------------------------------------------------- |
| Feature → `dev`         | `feature/*` → `dev`   | **Squash merge** | Clean history, one commit per feature              |
| Dev → `main`            | `dev` → `main`        | **Merge commit** | Preserves sprint boundary, creates release point   |
| Main → `production`     | `main` → `production` | **Merge commit** | Preserves release history with tags                |
| Hotfix → `main`         | `hotfix/*` → `main`   | **Squash merge** | Fast, clean emergency fix                          |
| Hotfix backport → `dev` | `hotfix/*` → `dev`    | **Cherry-pick**  | Ensures dev includes the fix without extra history |

### Why Squash Merge for Features?

```
# WITHOUT squash (noisy history in dev):
abc1234 feat: WIP auth
def5678 fix: typo
ghi9012 feat: more auth work
jkl3456 fix: linting

# WITH squash (clean history in dev):
mno7890 feat(auth): implement JWT authentication module (#12)
```

---

## 6. Commit Standards

DeelMarkt follows **Conventional Commits** — the same standard used across the Antigravity AI Kit ecosystem.

### Format

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type       | Purpose          | Example                                                    |
| :--------- | :--------------- | :--------------------------------------------------------- |
| `feat`     | New feature      | `feat(marketplace): add product listing API`               |
| `fix`      | Bug fix          | `fix(cart): correct total calculation with discounts`      |
| `docs`     | Documentation    | `docs(api): add endpoint reference for listings`           |
| `refactor` | Code refactoring | `refactor(payment): extract validation logic`              |
| `test`     | Test changes     | `test(auth): add JWT token expiry tests`                   |
| `chore`    | Tooling, config  | `chore(deps): update express to v5.1`                      |
| `perf`     | Performance      | `perf(search): add database index for product queries`     |
| `style`    | Formatting       | `style(components): fix indentation in marketplace module` |
| `ci`       | CI/CD changes    | `ci(github): add lint step to PR workflow`                 |

### Rules

- Use imperative mood: "add feature" not "added feature"
- Max 72 characters for the subject line
- Include scope when the change is specific to a module
- Reference issue numbers in the footer when applicable

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

### Steps

```powershell
# 1. Create hotfix from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-auth-bypass

# 2. Fix the issue (minimal, surgical changes only)
git commit -m "fix(auth): patch critical authentication bypass vulnerability"

# 3. Open PR: hotfix/critical-auth-bypass → main
# 4. After merge to main, immediately merge main → production
# 5. Cherry-pick the fix into dev
git checkout dev
git cherry-pick <commit-sha>
git push origin dev
```

---

## 8. Release Lifecycle

### Sprint Release (dev → main → production)

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

| Change Type                        | Version Bump | Example             |
| :--------------------------------- | :----------- | :------------------ |
| Breaking changes                   | Major        | `v1.0.0` → `v2.0.0` |
| New features (backward-compatible) | Minor        | `v1.0.0` → `v1.1.0` |
| Bug fixes                          | Patch        | `v1.0.0` → `v1.0.1` |
| Hotfixes                           | Patch        | `v1.0.1` → `v1.0.2` |

### Tagging Convention

```powershell
# After merging main → production
git checkout production
git pull origin production
git tag -a v1.2.0 -m "Release v1.2.0 — Sprint 3: Marketplace MVP"
git push origin v1.2.0
```

---

## 9. Branch Protection Rules

### Recommended GitHub Settings

#### `production` Branch

| Rule                            | Setting          |
| :------------------------------ | :--------------- |
| Require PR before merging       | ✅ Enabled       |
| Required approvals              | 1 minimum        |
| Require status checks to pass   | ✅ Enabled       |
| Require conversation resolution | ✅ Enabled       |
| Restrict who can push           | Maintainers only |
| Allow force pushes              | ❌ Never         |
| Allow deletions                 | ❌ Never         |

#### `main` Branch

| Rule                          | Setting    |
| :---------------------------- | :--------- |
| Require PR before merging     | ✅ Enabled |
| Required approvals            | 1 minimum  |
| Require status checks to pass | ✅ Enabled |
| Allow force pushes            | ❌ Never   |
| Allow deletions               | ❌ Never   |

#### `dev` Branch

| Rule                          | Setting                             |
| :---------------------------- | :---------------------------------- |
| Require PR before merging     | ✅ Enabled                          |
| Required approvals            | 0 (self-merge allowed for velocity) |
| Require status checks to pass | ✅ Enabled                          |
| Allow force pushes            | ❌ Never                            |
| Allow deletions               | ❌ Never                            |

---

## 10. Visual Reference

### Complete Flow Overview

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

## 11. Quick Reference Card

### Daily Commands

```powershell
# Start new work
git checkout dev && git pull origin dev
git checkout -b feature/<name>

# Save progress
git add . && git commit -m "feat(scope): description"

# Push and create PR
git push -u origin feature/<name>
# → Open PR: feature/<name> → dev

# Stay up to date
git fetch origin && git rebase origin/dev
git push --force-with-lease

# After PR merge — cleanup
git checkout dev && git pull origin dev
git branch -d feature/<name>
```

### Release Commands

```powershell
# Sprint release: dev → main
# → Open PR in GitHub: dev → main
# → Title: "Release v1.x.0 — Sprint N"

# Production deploy: main → production
# → Open PR in GitHub: main → production
# → After merge, tag:
git checkout production && git pull origin production
git tag -a v1.x.0 -m "Release v1.x.0"
git push origin v1.x.0
```

---

## 12. Anti-Patterns

These patterns are **explicitly prohibited** in DeelMarkt development:

| Anti-Pattern                                  | Why It's Wrong                                 | Correct Pattern                               |
| :-------------------------------------------- | :--------------------------------------------- | :-------------------------------------------- |
| Per-developer long-lived branches             | No isolation by feature, N-way merge conflicts | Short-lived feature branches                  |
| Direct commits to `main` or `production`      | Bypasses quality gates                         | Always use PRs                                |
| Feature branches living > 1 week              | Divergence risk, merge hell                    | Break into smaller tasks                      |
| Merging `dev` → `production` directly         | Skips the `main` stability gate                | Always go through `main`                      |
| Force-push to `dev`, `main`, or `production`  | Destroys shared history                        | Only `--force-with-lease` on feature branches |
| Committing `.env`, secrets, or `node_modules` | Security and repo hygiene violation            | Use `.gitignore` + environment variables      |
| Merge commits in feature branches             | Noisy history                                  | Use `rebase` to stay updated                  |
| Vague commit messages                         | Untraceable changes                            | Follow Conventional Commits                   |

---

## Appendix: Industry Validation

| Company     | Team Size | Strategy               | Key Insight                                                         |
| :---------- | :-------- | :--------------------- | :------------------------------------------------------------------ |
| **Google**  | 35,000+   | Trunk-Based (monorepo) | Single trunk, feature flags, direct commits                         |
| **Amazon**  | 10,000+   | Trunk-Based            | Small commits, multiple daily integrations                          |
| **Netflix** | 2,000+    | Feature Branch + Trunk | Short-lived feature branches, PR reviews, microservice independence |
| **Meta**    | 20,000+   | Trunk-Based (monorepo) | Ship from trunk, automated testing at scale                         |
| **Spotify** | 3,000+    | Squad-Based + Trunk    | Autonomous squads, shared trunk, feature flags                      |

DeelMarkt's 3-branch model (`dev` → `main` → `production`) with short-lived feature branches mirrors Netflix's approach — the optimal choice for a small team building a marketplace platform.

---

> **Document Classification**: Strategic Architecture Document
> **Review Cycle**: Quarterly or upon team scaling events
> **Owner**: Emre Dursun (Contributor)
