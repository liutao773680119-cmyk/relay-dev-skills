# v1.1.0 - First public relay-dev release

## 为什么做这个仓库

在真实开发里，最耗人的往往不是写代码本身，而是“重新让下一个模型进入状态”。

尤其当你会：

- 在 Codex、Cursor、Claude Code 之间切换
- 在不同模型之间切换
- 在不同账号之间切换
- 用多个会话推进同一个项目

常见痛点会非常稳定地重复出现：

- 新会话不知道上一轮做到哪了
- 同一个项目被不同模型用不同规则接手
- 每次切换都要重新讲背景
- 收尾不标准，下一轮只能猜
- 历史上下文散落在聊天里，不在项目里

这个版本的目标，就是把这些痛点变成一个可复用、可安装、可开源的解决方案。

## 这个版本提供了什么

### 1. 全局 relay skills

首发公开了 6 个核心 skills：

- `relay-dev`
- `relay-start`
- `relay-resync`
- `relay-handoff-stop`
- `relay-scope-change`
- `relay-verify`

其中 `relay-dev` 是统一入口，支持中文自然语言触发。

### 2. 中文自然语言触发

安装后，用户不需要记 skill 名，可以直接说：

- `接手这个项目，按接力开发规则来`
- `给这个项目初始化接力开发`
- `重新同步当前任务`
- `做一次标准交接`
- `按接力开发流程处理这个项目`

### 3. 项目模板

仓库同时提供 `starter/relay-kit-v1`，用于给新项目快速铺接力开发模板，包括：

- `AGENTS.md`
- `progress.md`
- `task_plan.md`
- `findings.md`
- `task_registry.md`
- `修改记录_会话备忘.md`

### 4. 一键安装

仓库提供：

- `scripts/install_skills.py`
- `scripts/install.ps1`
- `scripts/install.sh`

可以把 skills 安装到 Codex、Claude Code、Cursor / agents 的全局 skill 目录。

## 这个版本的核心设计原则

### 摘要优先、按需深读

新会话恢复上下文时，不鼓励机械全文通读长交接文件，而是优先读取摘要、当前任务段和最近记录。

### 单会话锁定单 Task-ID

避免多个任务在同一轮会话里互相污染。

### 收尾必须写回交接

如果没有标准交接，就没有稳定接力。

## 开源发布准备

本版本已补齐：

- `MIT` 许可证
- 仓库级 `.gitignore`
- GitHub 首页 README
- Release 文案模板
- 公开分发目录 `skills/`

## 已验证

- Windows 下的安装流程已实测通过
- GitHub 仓库与首个 release 已发布

## 待补验证

- `install.sh` 在干净 macOS / Linux 环境的实测

## 推荐使用方式

如果你是第一次接触这个仓库，建议按这个顺序上手：

1. 先安装全局 skills
2. 再用模板初始化一个测试项目
3. 在新会话里直接用中文话术触发
4. 故意切一次模型，再体验交接和恢复效果
