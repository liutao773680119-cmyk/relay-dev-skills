# Task Registry

| Task-ID | Task-Name | Status | Owner | Last Update | Next First Command | Known Avoidances | Notes |
|---------|-----------|--------|-------|-------------|--------------------|------------------|-------|
| T001 | 初始化接力开发模板 | completed | Codex | 2026-03-26 09:00 | `E:\AI软件\Git\cmd\git.exe push -u origin main` | 先确认 `.git` 与远端；不要在 No-Git 目录承诺可推送 | 模板已定版、已推送到 GitHub，普通 push 已恢复到稳定可用状态。 |
| T002 | 梳理 Claude Code 记忆文件供 Codex 同步参考 | completed | Codex | 2026-03-27 12:32 | `Get-Content -Raw -Encoding utf8 'C:\Users\Administrator\Desktop\codex share\codex-common\memories\shared_core_memory.md'` | 先缩小搜索范围；不要全盘宽泛搜 memory | 已确认 Claude 记忆位于 `.claude\projects\C--Users-Administrator\memory`，并已生成适合共享到 Codex 的单文件精简版记忆。 |
| T003 | 设计 codex share 到 Mac mini 的共享与接入方案 | completed | Codex | 2026-03-27 13:55 | `codex` | 只共享公共内容；不要直接同步整个 `~/.codex` 运行态 | 已完成 shared rules/skills 修复、Windows 本机 rules 清理，并在 Mac mini 上配置开机自动挂载 `codex share`。|
| T004 | 同步 Mac mini 全局共享 skills/rules/memories | completed | Codex | 2026-03-29 23:11 | `codex` | 保留 `.system`；共享路径先确认真实路径；不要用兜底补丁 | 已将共享 `AGENTS.md`、`rules`、`memories` 接入 `~/.codex`，并保留本机 `.system` 技能后额外挂载 34 个共享技能。 |

