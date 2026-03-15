/**
 * sync-version.mjs — Centralized Version Sync Script
 *
 * SSOT Sources:
 *   - Kit version:     .agent/manifest.json → kitVersion
 *   - Project version: package.json → version
 *   - Node.js version: .nvmrc
 *
 * Usage:
 *   node scripts/sync-version.mjs              # Sync all versions
 *   node scripts/sync-version.mjs --dry-run    # Preview changes
 *   node scripts/sync-version.mjs --check      # CI mode: exit 1 on drift
 */

import { readFileSync, writeFileSync, existsSync } from 'node:fs';
import { resolve, relative } from 'node:path';

// ─── Constants ───────────────────────────────────────────────────────────────

const ROOT = resolve(import.meta.dirname, '..');
const SEMVER_REGEX = /^\d+\.\d+\.\d+$/;

const COLOR = {
  green: (text) => `\x1b[32m${text}\x1b[0m`,
  yellow: (text) => `\x1b[33m${text}\x1b[0m`,
  red: (text) => `\x1b[31m${text}\x1b[0m`,
  cyan: (text) => `\x1b[36m${text}\x1b[0m`,
  dim: (text) => `\x1b[2m${text}\x1b[0m`,
  bold: (text) => `\x1b[1m${text}\x1b[0m`,
};

// ─── CLI Flags ───────────────────────────────────────────────────────────────

const args = process.argv.slice(2);
const isDryRun = args.includes('--dry-run');
const isCheckMode = args.includes('--check');
const isVerbose = args.includes('--verbose');

// ─── SSOT Readers ────────────────────────────────────────────────────────────

/**
 * Read the kit version from .agent/manifest.json
 * @returns {string} The kit version (e.g., "3.1.1")
 */
function readKitVersion() {
  const manifestPath = resolve(ROOT, '.agent', 'manifest.json');
  if (!existsSync(manifestPath)) {
    throw new Error('.agent/manifest.json not found — is this an Antigravity AI Kit project?');
  }
  const manifest = JSON.parse(readFileSync(manifestPath, 'utf-8'));
  const version = manifest.kitVersion;
  if (!version || !SEMVER_REGEX.test(version)) {
    throw new Error(`Invalid kitVersion in manifest.json: "${version}" — expected semver (e.g., 3.1.1)`);
  }
  return version;
}

/**
 * Read the project version from package.json
 * @returns {string} The project version (e.g., "0.3.0")
 */
function readProjectVersion() {
  const packagePath = resolve(ROOT, 'package.json');
  if (!existsSync(packagePath)) {
    throw new Error('package.json not found');
  }
  const pkg = JSON.parse(readFileSync(packagePath, 'utf-8'));
  const version = pkg.version;
  if (!version || !SEMVER_REGEX.test(version)) {
    throw new Error(`Invalid version in package.json: "${version}" — expected semver (e.g., 0.3.0)`);
  }
  return version;
}

/**
 * Read the Node.js version from .nvmrc
 * @returns {string} The Node.js version (e.g., "22.20.0")
 */
function readNodeVersion() {
  const nvmrcPath = resolve(ROOT, '.nvmrc');
  if (!existsSync(nvmrcPath)) {
    throw new Error('.nvmrc not found — create it with the target Node.js version');
  }
  const version = readFileSync(nvmrcPath, 'utf-8').trim().replace(/^v/, '');
  if (!SEMVER_REGEX.test(version)) {
    throw new Error(`Invalid Node.js version in .nvmrc: "${version}" — expected semver (e.g., 22.20.0)`);
  }
  return version;
}

// ─── Sync Engine ─────────────────────────────────────────────────────────────

/**
 * @typedef {Object} SyncTarget
 * @property {string} file - Relative path from project root
 * @property {RegExp} pattern - Regex to match the current version string
 * @property {(version: string) => string} replacement - Replacement builder
 * @property {string} domain - Version domain (kit | node | project)
 */

/**
 * Build sync targets for kit version
 * @param {string} kitVersion - Current kit version
 * @returns {SyncTarget[]}
 */
function buildKitSyncTargets(kitVersion) {
  return [
    {
      file: 'README.md',
      pattern: /(\[Antigravity AI Kit\]\([^)]+\))\s*v\d+\.\d+\.\d+/,
      replacement: (v) => `$1 v${v}`,
      domain: 'kit',
    },
    {
      file: '.agent/CheatSheet.md',
      pattern: /(\*\*Version\*\*:\s*)v\d+\.\d+\.\d+/,
      replacement: (v) => `$1v${v}`,
      domain: 'kit',
    },
    {
      file: '.agent/session-context.md',
      pattern: /(\*\*Framework\*\*:\s*Antigravity AI Kit\s*)v\d+\.\d+\.\d+/,
      replacement: (v) => `$1v${v}`,
      domain: 'kit',
    },
    {
      file: '.agent/session-context.md',
      pattern: /(NPM package:\s*`antigravity-ai-kit`\s*\()v?\d+\.\d+\.\d+(\))/,
      replacement: (v) => `$1v${v}$2`,
      domain: 'kit',
    },
    {
      file: 'docs/ROADMAP.md',
      pattern: /(\*\*Framework\*\*:\s*Antigravity AI Kit\s*)v\d+\.\d+\.\d+/,
      replacement: (v) => `$1v${v}`,
      domain: 'kit',
    },
  ];
}

/**
 * Build sync targets for Node.js version
 * @param {string} nodeVersion - Current Node.js version
 * @returns {SyncTarget[]}
 */
function buildNodeSyncTargets(nodeVersion) {
  return [
    {
      file: 'package.json',
      pattern: /("node":\s*">=)\d+\.\d+\.\d+(")/,
      replacement: (v) => `$1${v}$2`,
      domain: 'node',
    },
    {
      file: '.agent/session-context.md',
      pattern: /(Node\.js\s*)v\d+\.\d+\.\d+/,
      replacement: (v) => `$1v${v}`,
      domain: 'node',
    },
  ];
}

/**
 * Apply a single sync target
 * @param {SyncTarget} target - The sync target definition
 * @param {string} version - The version to sync to
 * @returns {{ status: 'synced' | 'updated' | 'error', detail: string }}
 */
function applySyncTarget(target, version) {
  const filePath = resolve(ROOT, target.file);
  const relativePath = relative(ROOT, filePath);

  if (!existsSync(filePath)) {
    return { status: 'error', detail: `File not found: ${relativePath}` };
  }

  const content = readFileSync(filePath, 'utf-8');
  const match = target.pattern.exec(content);

  if (!match) {
    return { status: 'error', detail: `Pattern not matched in ${relativePath}` };
  }

  const replacementString = target.replacement(version);
  const newContent = content.replace(target.pattern, replacementString);

  if (content === newContent) {
    return { status: 'synced', detail: `${relativePath} — already in sync` };
  }

  if (!isDryRun && !isCheckMode) {
    writeFileSync(filePath, newContent, 'utf-8');
  }

  return { status: 'updated', detail: `${relativePath} — ${isDryRun ? 'would update' : 'updated'}` };
}

// ─── Project Version Validator ───────────────────────────────────────────────

/**
 * Validate that the latest CHANGELOG entry matches package.json version
 * @param {string} projectVersion - The project version from package.json
 * @returns {{ status: 'synced' | 'warning', detail: string }}
 */
function validateChangelogVersion(projectVersion) {
  const changelogPath = resolve(ROOT, 'docs', 'CHANGELOG.md');
  if (!existsSync(changelogPath)) {
    return { status: 'warning', detail: 'docs/CHANGELOG.md not found — skipping validation' };
  }

  const content = readFileSync(changelogPath, 'utf-8');
  const headerMatch = content.match(/^## \[(\d+\.\d+\.\d+)\]/m);

  if (!headerMatch) {
    return { status: 'warning', detail: 'No version header found in CHANGELOG.md' };
  }

  const changelogVersion = headerMatch[1];
  if (changelogVersion === projectVersion) {
    return { status: 'synced', detail: `CHANGELOG.md latest [${changelogVersion}] matches package.json` };
  }

  return {
    status: 'warning',
    detail: `CHANGELOG.md latest [${changelogVersion}] ≠ package.json [${projectVersion}]`,
  };
}

// ─── Main ────────────────────────────────────────────────────────────────────

function main() {
  console.log();
  console.log(COLOR.bold('🔄 Antigravity Version Sync'));

  if (isDryRun) {
    console.log(COLOR.dim('   Mode: dry-run (no files will be modified)'));
  } else if (isCheckMode) {
    console.log(COLOR.dim('   Mode: check (CI — exit 1 on drift)'));
  }

  console.log();

  // ─── Read SSOTs ──────────────────────────────────────────────────────────

  /** @type {string} */
  let kitVersion;
  /** @type {string} */
  let projectVersion;
  /** @type {string} */
  let nodeVersion;

  try {
    kitVersion = readKitVersion();
    projectVersion = readProjectVersion();
    nodeVersion = readNodeVersion();
  } catch (error) {
    console.error(COLOR.red(`✗ ${error.message}`));
    process.exit(2);
  }

  console.log(COLOR.cyan('   Sources (SSOT):'));
  console.log(`   ├─ Kit version:     ${COLOR.bold(kitVersion)}  ← .agent/manifest.json`);
  console.log(`   ├─ Project version: ${COLOR.bold(projectVersion)}  ← package.json`);
  console.log(`   └─ Node.js version: ${COLOR.bold(nodeVersion)}  ← .nvmrc`);
  console.log();

  // ─── Build Targets ───────────────────────────────────────────────────────

  const kitTargets = buildKitSyncTargets(kitVersion);
  const nodeTargets = buildNodeSyncTargets(nodeVersion);

  let hasUpdates = false;
  let hasErrors = false;

  // ─── Sync Kit Version ────────────────────────────────────────────────────

  console.log(COLOR.bold(`   Kit Version (v${kitVersion}):`));

  for (const target of kitTargets) {
    const result = applySyncTarget(target, kitVersion);
    logResult(result);
    if (result.status === 'updated') hasUpdates = true;
    if (result.status === 'error') hasErrors = true;
  }

  console.log();

  // ─── Sync Node.js Version ────────────────────────────────────────────────

  console.log(COLOR.bold(`   Node.js Version (v${nodeVersion}):`));

  for (const target of nodeTargets) {
    const result = applySyncTarget(target, nodeVersion);
    logResult(result);
    if (result.status === 'updated') hasUpdates = true;
    if (result.status === 'error') hasErrors = true;
  }

  console.log();

  // ─── Validate Project Version ────────────────────────────────────────────

  console.log(COLOR.bold(`   Project Version (v${projectVersion}):`));

  const changelogResult = validateChangelogVersion(projectVersion);
  logResult(changelogResult);

  console.log();

  // ─── Summary ─────────────────────────────────────────────────────────────

  if (hasErrors) {
    console.log(COLOR.red('   ✗ Errors detected — check target file patterns'));
    process.exit(2);
  }

  if (isCheckMode && hasUpdates) {
    console.log(COLOR.yellow('   ⚠ Version drift detected — run `npm run sync-version` to fix'));
    process.exit(1);
  }

  if (hasUpdates) {
    console.log(COLOR.green('   ✓ All versions synced successfully'));
  } else {
    console.log(COLOR.green('   ✓ Everything is already in sync'));
  }

  console.log();
}

/**
 * Log a sync result with color-coded output
 * @param {{ status: string, detail: string }} result
 */
function logResult(result) {
  switch (result.status) {
    case 'synced':
      console.log(`   ${COLOR.green('✓')} ${COLOR.dim(result.detail)}`);
      break;
    case 'updated':
      console.log(`   ${COLOR.yellow('●')} ${result.detail}`);
      break;
    case 'warning':
      console.log(`   ${COLOR.yellow('⚠')} ${result.detail}`);
      break;
    case 'error':
      console.log(`   ${COLOR.red('✗')} ${result.detail}`);
      break;
  }
}

main();
