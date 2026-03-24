# Relay Kit v1

用于在 Antigravity、Cursor、VS Code/Copilot、Codex 之间做稳定的项目接力开发初始化。

## Version

- Kit version: `1.1.0`
- Upgrade highlight: default context recovery is now `summary-first`, not full-file reread by default.

## Quick Start

在目标项目根目录执行：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/relay_init.ps1 -Profile stock-cn -Tools antigravity,cursor,vscode,codex -Naming bilingual -Force
```

## Structure

- `templates/`: 项目级模板文件
- `global-skills/`: relay 技能模板，可同步到项目内技能目录

## Design Principles

1. `AGENTS.md` 是项目级单一规则源。
2. 上下文通过 `progress/task_plan/findings/session record` 文件化保存。
3. 开场和收尾使用固定接力协议。
4. 默认采用“摘要优先、按需深读”，减少无效 token 消耗。
5. 双语命名通过 `relay.map.json` 对齐。
