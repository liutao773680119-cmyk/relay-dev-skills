# Release v1.1.0

## Summary

首个可公开分发版本，提供：

- 面向 Codex / Cursor / Claude Code 的全局 relay skills
- 面向新项目的接力开发初始化模板
- 中文自然语言触发入口
- Windows / macOS / Linux 安装脚本

## Included

- `skills/relay-dev`
- `skills/relay-start`
- `skills/relay-resync`
- `skills/relay-handoff-stop`
- `skills/relay-scope-change`
- `skills/relay-verify`
- `scripts/install_skills.py`
- `scripts/install.ps1`
- `scripts/install.sh`
- `starter/relay-kit-v1`

## Highlights

1. 新增统一入口 skill `relay-dev`
   - 用户可以直接说中文，例如：
   - `接手这个项目，按接力开发规则来`
   - `重新同步当前任务`
   - `做一次标准交接`

2. 统一会话恢复口径
   - 默认采用“摘要优先、按需深读”
   - 避免新会话机械全文通读长交接文件

3. 支持开源分发
   - 顶层 `skills/` 可直接用于 GitHub 路径安装
   - `scripts/install.ps1` / `scripts/install.sh` 可用于本地一键安装

## Recommended Repo Names

- `relay-dev-skills`
- `multi-session-relay`
- `ai-relay-workflow`

## Suggested GitHub Description

中文：

`一套面向 Codex、Cursor、Claude Code 的接力开发 skills 与项目模板，支持中文自然语言触发、多会话上下文恢复和标准交接。`

English:

`Relay development skills and project templates for Codex, Cursor, and Claude Code, with Chinese natural-language triggers, session handoff, and context recovery.`

## Suggested First Release Title

`v1.1.0 - First public relay-dev release`

## Notes

- Windows 安装路径已实测通过。
- `install.sh` 建议在干净的 macOS / Linux 环境再做一次验证后发布。
