# Setup Guide

> Get the DeelMarkt development environment running in 5 minutes.

---

## Prerequisites

Install these before running the setup script:

| Tool | Version | Install |
|:-----|:--------|:--------|
| **Flutter** | 3.x | [flutter.dev/get-started](https://flutter.dev/docs/get-started/install) |
| **Dart** | 3.x | Included with Flutter |
| **Git** | 2.x+ | [git-scm.com](https://git-scm.com/) |
| **Python** | 3.8+ | [python.org](https://python.org/) (needed for pre-commit hooks) |

### macOS (recommended)

```bash
# Install Flutter via Homebrew
brew install --cask flutter

# Install Python (if not already present)
brew install python

# Verify
flutter doctor
python3 --version
```

### Windows

1. Download Flutter SDK from [flutter.dev](https://flutter.dev/docs/get-started/install/windows)
2. Add Flutter to PATH
3. Install Python from [python.org](https://python.org/) (check "Add to PATH" during install)
4. Open PowerShell and run `flutter doctor`

### Linux

```bash
# Install Flutter via snap
sudo snap install flutter --classic

# Install Python
sudo apt install python3 python3-pip

# Verify
flutter doctor
python3 --version
```

---

## Quick Setup (one command)

### macOS / Linux

```bash
git clone <repo-url> DeelMarkt
cd DeelMarkt
bash scripts/setup.sh
```

### Windows (PowerShell)

```powershell
git clone <repo-url> DeelMarkt
cd DeelMarkt
.\scripts\setup.ps1
```

---

## What the Setup Script Does

| Step | What | Why |
|:-----|:-----|:----|
| 1 | Checks Flutter, Dart, Git are installed | Can't develop without them |
| 2 | Installs `pre-commit` + `detect-secrets` (Python) | Quality gates on every commit |
| 3 | Registers pre-commit hooks (commit + push) | Enforces formatting, analysis, secrets, branch rules |
| 4 | Creates `.secrets.baseline` | Baseline for secret scanning |
| 5 | Creates `dev` branch if missing | GitFlow branch strategy |
| 6 | Runs `flutter pub get` (if pubspec.yaml exists) | Installs dependencies |
| 7 | Runs `build_runner` (if applicable) | Code generation (Riverpod, freezed, etc.) |
| 8 | Verifies hooks work | Confirms setup is correct |

---

## Manual Setup (if scripts don't work)

```bash
# 1. Install pre-commit
pip3 install pre-commit detect-secrets

# 2. Install hooks
pre-commit install
pre-commit install --hook-type pre-push

# 3. Create secrets baseline
detect-secrets scan > .secrets.baseline

# 4. Create dev branch
git checkout -b dev

# 5. Install Flutter deps (after flutter create)
flutter pub get
```

---

## What the Hooks Enforce

### On Every Commit (< 5 seconds)

| Hook | What it catches |
|:-----|:---------------|
| `trailing-whitespace` | Trailing spaces in files |
| `end-of-file-fixer` | Missing newline at end of file |
| `check-yaml` / `check-json` | Malformed config files |
| `no-commit-to-branch` | **Blocks commits to `main` and `dev`** |
| `detect-secrets` | Hardcoded API keys, passwords, tokens |
| `dart-format` | Dart formatting violations |
| `flutter-analyze` | Static analysis warnings |

### On Every Push (< 60 seconds)

| Hook | What it catches |
|:-----|:---------------|
| `flutter-test` | Failing tests, coverage regression |

### If a Hook Fails

```bash
# Formatting failed? Fix it:
dart format .

# Then re-commit:
git add .
git commit -m "feat(scope): description"
```

**Never use `--no-verify`.** Fix the issue instead.

---

## Git Workflow

```
main          ← production, protected, PRs only
  └── dev     ← integration, PRs from feature branches
       ├── feature/E01-listing-crud
       ├── fix/payment-double-charge
       └── chore/update-deps
```

```bash
# Start a new feature
git checkout dev
git pull origin dev
git checkout -b feature/E01-listing-crud

# Work, commit, push
git add <files>
git commit -m "feat(listings): add photo upload flow"
git push -u origin feature/E01-listing-crud

# Create PR → dev (not main)
```

---

## IDE Setup

### VS Code (recommended)

Install extensions:
- **Dart** (dart-code.dart-code)
- **Flutter** (dart-code.flutter)
- **Error Lens** (usernamehw.errorlens)

### Android Studio / IntelliJ

- Install Flutter and Dart plugins
- Set Flutter SDK path in settings

---

## Troubleshooting

| Problem | Fix |
|:--------|:----|
| `pre-commit: command not found` | `pip3 install pre-commit` or `brew install pre-commit` |
| `detect-secrets: command not found` | `pip3 install detect-secrets` |
| Hook fails on `dart format` | Run `dart format .` manually, then re-commit |
| Hook fails on `flutter analyze` | Fix the warnings shown in output |
| `no-commit-to-branch` blocks you | You're on `main` or `dev`. Create a feature branch: `git checkout -b feature/my-feature dev` |
| `flutter test` fails on push | Fix failing tests before pushing |
| `.secrets.baseline` flagging false positives | Add `# pragma: allowlist secret` inline |
| Hooks not running at all | Run `pre-commit install && pre-commit install --hook-type pre-push` |
