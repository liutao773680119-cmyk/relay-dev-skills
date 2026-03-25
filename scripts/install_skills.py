from __future__ import annotations

import argparse
import shutil
import sys
from pathlib import Path


TARGET_DIRS = {
    "codex": Path.home() / ".codex" / "skills",
    "claude": Path.home() / ".claude" / "skills",
    "agents": Path.home() / ".agents" / "skills",
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Install relay skills into global skill directories."
    )
    parser.add_argument(
        "--repo-root",
        type=Path,
        default=Path(__file__).resolve().parent.parent,
        help="Repository root. Defaults to the parent of scripts/.",
    )
    parser.add_argument(
        "--targets",
        default="codex,claude,agents",
        help="Comma-separated targets: codex, claude, agents.",
    )
    parser.add_argument(
        "--source",
        choices=("skills", "relay"),
        default="skills",
        help="Install from repo_root/skills or repo_root/.relay/skills.",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite existing skill directories.",
    )
    return parser.parse_args()


def resolve_source_root(repo_root: Path, source_kind: str) -> Path:
    if source_kind == "skills":
        source_root = repo_root / "skills"
    else:
        source_root = repo_root / ".relay" / "skills"
    if not source_root.exists():
        raise FileNotFoundError(f"Skill source directory not found: {source_root}")
    return source_root


def find_skills(source_root: Path) -> list[Path]:
    skills = []
    for path in sorted(source_root.iterdir()):
        if path.is_dir() and (path / "SKILL.md").exists():
            skills.append(path)
    if not skills:
        raise FileNotFoundError(f"No skills found under: {source_root}")
    return skills


def parse_targets(raw_targets: str) -> list[str]:
    result = []
    for item in raw_targets.split(","):
        target = item.strip().lower()
        if not target:
            continue
        if target not in TARGET_DIRS:
            raise ValueError(
                f"Unsupported target: {target}. Allowed: {', '.join(TARGET_DIRS)}"
            )
        result.append(target)
    if not result:
        raise ValueError("No valid targets were provided.")
    return result


def copy_skill(skill_dir: Path, dest_root: Path, force: bool) -> None:
    dest_root.mkdir(parents=True, exist_ok=True)
    dest_dir = dest_root / skill_dir.name
    if dest_dir.exists():
        if not force:
            raise FileExistsError(
                f"Destination already exists: {dest_dir}. Re-run with --force."
            )
        shutil.rmtree(dest_dir)
    shutil.copytree(skill_dir, dest_dir)


def main() -> int:
    args = parse_args()
    repo_root = args.repo_root.resolve()
    source_root = resolve_source_root(repo_root, args.source)
    skills = find_skills(source_root)
    targets = parse_targets(args.targets)

    print(f"[relay-install] repo_root={repo_root}")
    print(f"[relay-install] source_root={source_root}")
    print(f"[relay-install] targets={', '.join(targets)}")

    for target in targets:
        dest_root = TARGET_DIRS[target]
        print(f"[relay-install] installing to {target}: {dest_root}")
        for skill_dir in skills:
            copy_skill(skill_dir, dest_root, args.force)
            print(f"  - {skill_dir.name}")

    print("[relay-install] done")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:  # pragma: no cover
        print(f"[relay-install][FAIL] {exc}", file=sys.stderr)
        raise SystemExit(1)
