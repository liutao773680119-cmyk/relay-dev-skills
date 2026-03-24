#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGETS="${TARGETS:-codex,claude,agents}"
SOURCE_KIND="${SOURCE_KIND:-skills}"

ARGS=(
  "${SCRIPT_DIR}/install_skills.py"
  "--repo-root" "${REPO_ROOT}"
  "--targets" "${TARGETS}"
  "--source" "${SOURCE_KIND}"
)

if [[ "${1:-}" == "--force" ]]; then
  ARGS+=("--force")
fi

python "${ARGS[@]}"
