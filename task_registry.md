# Task Registry

| Task-ID | Task-Name | Status | Owner | Last Update | Next First Command | Notes |
|---------|-----------|--------|-------|-------------|--------------------|-------|
| T001 | 初始化接力开发模板 | blocked | Codex | 2026-03-25 20:56 | `if (Test-Path .git) { git status --short; git remote -v } else { 'NO_GIT_REPO' }` | 模板已定版并通过演练验证；当前阻塞为目录不是 git 仓库，无法直接推送 GitHub。 |
