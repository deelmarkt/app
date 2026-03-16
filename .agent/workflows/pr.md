---
description: Production-grade PR creation with CI pre-flight checks and conflict resolution.
version: 1.0.0
sdlc-phase: ship
skills: [git-workflow, verification-loop]
commit-types: [feat, fix, chore, refactor, docs, perf]
---

# /pr — Production-Grade Pull Request Workflow

> **Trigger**: `/pr [target-branch]` (default: `main`)
> **Lifecycle**: Ship phase — after code is verified and ready for merge

> [!IMPORTANT]
> **Every PR must pass CI before merge.** Never merge a PR with failing or missing CI checks.

---

## Critical Rules

1. **ALWAYS** sync with target branch before creating PR — prevents merge conflicts
2. **ALWAYS** run pre-flight checks locally before pushing — catches issues before CI
3. **NEVER** create a PR with known conflicts — resolve first
4. **NEVER** merge without all 4 CI checks passing
5. **ATOMIC** PRs — one logical unit of work per PR, not multi-sprint kitchen sinks

---

## Pre-Flight Checklist

Before creating any PR, execute ALL checks locally:

// turbo-all

```powershell
# 1. Format check
dart format --set-exit-if-changed .

# 2. Static analysis
flutter analyze --no-pub

# 3. Tests with coverage
flutter test --coverage --no-pub

# 4. Ensure no secrets or PII
git diff --cached --name-only | Select-String -Pattern "(\.env|secret|password|token|key)" -CaseSensitive
```

> [!CAUTION]
> If ANY of the above fail, fix them BEFORE proceeding. Do NOT rely on CI to catch issues — that wastes pipeline credits and delays the team.

---

## Steps

### 1. Sync with Target Branch

```powershell
# Fetch latest target
git fetch origin main

# Merge target into your branch (prefer merge over rebase for shared branches)
git merge origin/main --no-edit

# If conflicts exist: resolve, test again, then continue
```

> [!WARNING]
> If `dev` branch has diverged significantly from `main`, expect conflicts in shared files like `.gitignore`, `pubspec.yaml`, or `SPRINT-PLAN.md`. Always check `git diff --name-only origin/main..HEAD` before creating the PR.

### 2. Run Pre-Flight Checks

Execute the full pre-flight checklist (above). All must pass.

### 3. Push to Remote

```powershell
git push origin HEAD
```

### 4. Create PR with Structured Body

Use this template for the PR body:

```markdown
## Summary
[One-line description of what this PR does]

## Changes

### [Category 1]
- Change description
- Change description

### [Category 2]
- Change description

## Test Plan
- [x] `flutter analyze` — 0 warnings
- [x] `flutter test` — N tests passing
- [x] `dart format` — no formatting issues
- [x] No secrets or PII in diff

## Breaking Changes
[None / List any breaking changes]
```

### 5. Verify CI Pipeline

After PR is created, verify all 4 CI checks trigger:

| Job | What It Checks | Expected Time |
|:----|:---------------|:-------------|
| **Format & Analyze** | `dart format` + `flutter analyze` | ~1m |
| **Test & Coverage** | `flutter test --coverage` + 70% minimum | ~1m |
| **Security Scan** | `flutter pub outdated` + TruffleHog secret scan | ~1m |
| **Build Check** | `flutter build apk --release` + 50MB size budget | ~7m |

> [!NOTE]
> If CI checks do NOT appear, check:
> 1. **Merge conflicts** — `mergeable_state: dirty` blocks CI entirely
> 2. **Workflow file** — `.github/workflows/ci.yml` must exist on the target branch
> 3. **Branch targeting** — CI triggers on PRs targeting `dev` or `main` only

### 6. Handle CI Failures

If any CI check fails:

1. Read the failure log (click "Details" on the check)
2. Fix locally
3. Push the fix — CI re-triggers automatically
4. Do NOT merge until all 4 checks are green ✅

### 7. Request Review (if applicable)

- Assign reviewers if required by team policy
- Use `@` mentions for specific attention areas
- Link related issues with `Closes #N` or `Fixes #N`

---

## Conflict Resolution Protocol

When merge conflicts are detected:

```powershell
# 1. Fetch latest target
git fetch origin main

# 2. Merge into your branch
git merge origin/main

# 3. Check conflicted files
git diff --name-only --diff-filter=U

# 4. Resolve each conflict manually
# - For .gitignore: combine both versions, prefer more restrictive
# - For pubspec.yaml: merge dependencies carefully
# - For source files: understand both changes, merge logically

# 5. Mark resolved and commit
git add <resolved-files>
git commit -m "merge: resolve conflicts with main"

# 6. Re-run pre-flight checks
flutter analyze --no-pub
flutter test --no-pub

# 7. Push
git push origin HEAD
```

---

## Governance

**PROHIBITED:**
- Creating PRs with known merge conflicts
- Merging without CI checks passing
- Including generated files (`.flutter-plugins-dependencies`, `build/`, `.dart_tool/`)
- Committing PII, secrets, or absolute paths
- Multi-sprint mega-PRs — keep PRs focused and reviewable

**REQUIRED:**
- Local pre-flight checks before every PR
- Structured PR body with test plan
- Conflict resolution before requesting review
- All 4 CI checks green before merge

---

## Completion Criteria

- [ ] Target branch synced (no conflicts)
- [ ] Pre-flight checks pass locally (format, analyze, test, security)
- [ ] PR created with structured body
- [ ] All 4 CI checks pass (Format, Test, Security, Build)
- [ ] No generated files or PII in diff
- [ ] Review requested (if applicable)

---

## Related Resources

- **CI Config**: `.github/workflows/ci.yml`
- **Pre-task**: `/review` (code review before PR)
- **Post-merge**: `/deploy` (production deployment)
- **Quality**: `/verify` (full quality gate pipeline)
