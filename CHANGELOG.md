# Changelog

## Unreleased

- Added `scripts/fix_git_auth.ps1` to recover Windows non-interactive git push when helper/prompt chains fail.
- Documented `/dev/tty` / `failed to execute prompt script` recovery steps in `README.md`.

## 1.1.0 - 2026-03-24

- Unified relay startup rules to use `summary-first, then expand only when needed`.
- Updated mother-package templates:
  - `AGENTS.md.tmpl`
  - `.cursor/rules/00-core.mdc.tmpl`
  - `.cursor/rules/10-handoff.mdc.tmpl`
  - `.github/copilot-instructions.md.tmpl`
  - `.github/instructions/handoff.instructions.md.tmpl`
  - `relay_prompts.txt.tmpl`
- Updated relay skills:
  - `relay-start`
  - `relay-resync`
- Clarified that long handoff files should not be mechanically fully reread on every new session.
- Kept `Task-ID`, `Latest Handoff Snapshot`, and `Session Record` protocol unchanged.

## 1.0.0 - Initial

- Initial relay mother package release.
