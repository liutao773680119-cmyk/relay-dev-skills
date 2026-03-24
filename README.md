# 接力开发资产说明（Antigravity + Cursor + VSCode/Codex）

![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)
![Skills](https://img.shields.io/badge/skills-6-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)

这是一个可开源分发的“接力开发 skill + 项目模板”母包。

建议公开仓库名：

- `relay-dev-skills`
- `multi-session-relay`
- `ai-relay-workflow`

建议 GitHub 仓库描述：

`一套面向 Codex、Cursor、Claude Code 的接力开发 skills 与项目模板，支持中文自然语言触发、多会话上下文恢复和标准交接。`

如果你是第一次从 GitHub 拿到这个仓库，最短路径是：

1. 安装全局 skills
2. 在新项目里执行初始化
3. 直接用中文话术触发接力流程

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Targets codex,claude,agents -Source skills -Force
```

macOS / Linux:

```bash
bash ./scripts/install.sh --force
```

安装完以后，在新会话里直接说：

- `接手这个项目，按接力开发规则来`
- `重新同步当前任务`
- `做一次标准交接`

许可证：`MIT`

## 1. 这套资产是做什么的
`E:\AI软件\接力开发` 是你的“跨模型接力开发母包”。

核心目标：
- 让不同软件/模型接手同一项目时，能快速恢复上下文。
- 把规则、流程、交接信息统一到文件，降低“幻觉”和重复沟通。
- 让新项目用一条命令完成初始化，3 分钟内进入业务开发。

这套资产不负责你的业务逻辑本身，负责的是“开发协作协议”和“上下文接力机制”。

---

## 2. 目录结构与作用
当前目录（`E:\AI软件\接力开发`）主要包含：

- `.relay/skills/`
  - `relay-start`：开场读取上下文。
  - `relay-handoff-stop`：收尾写交接快照。
  - `relay-resync`：上下文漂移时重同步。
  - `relay-scope-change`：需求变更先落盘再改代码。
  - `relay-verify`：完成前验证。

- `scripts/`
  - `relay_init.ps1`：新项目初始化入口（主命令）。
  - `relay_render.py`：模板渲染器（由 init 调用）。

- `starter/relay-kit-v1/`
  - `templates/`：要落地到项目内的模板文件（AGENTS、progress、task_plan、findings、提示词、规则桥接等）。
  - `global-skills/`：可同步到工具目录的 relay skills 模板。

- `relay.config.json`
  - 初始化配置（默认 profile/tools/naming 等）。

- `reports/`
  - 初始化执行报告归档。

---

## 3. 使用前提
请确保：

1. Windows PowerShell 可用。
2. Python 可用（建议 `python -V` 可正常输出）。
3. 目标项目目录已存在（空目录也可）。

可先执行：

```powershell
python -V
```

---

## 4. 新项目如何调用（标准流程）

### 步骤 1：准备项目目录
示例：

```powershell
mkdir D:\Projects\my_new_project
```

### 步骤 2：执行一键初始化

```powershell
powershell -ExecutionPolicy Bypass -File "E:\AI软件\接力开发\scripts\relay_init.ps1" `
  -ProjectRoot "D:\Projects\my_new_project" `
  -Profile stock-cn `
  -Tools antigravity,cursor,vscode,codex `
  -Naming bilingual `
  -Force
```

参数说明：
- `-ProjectRoot`：目标项目路径。
- `-Profile stock-cn`：当前默认配置档。
- `-Tools antigravity,cursor,vscode,codex`：要适配的工具集合。
- `-Naming bilingual`：中英双轨命名（推荐）。
- `-Force`：允许覆盖托管模板区域并生成备份。

### 步骤 3：在项目里做预检

```powershell
powershell -ExecutionPolicy Bypass -File "D:\Projects\my_new_project\scripts\preflight.ps1" -ProjectRoot "D:\Projects\my_new_project"
```

预检通过后即可开始业务开发。

---

## 5. 初始化后项目里会出现什么
初始化后，新项目通常会生成/更新以下关键文件：

- 规则与桥接：
  - `AGENTS.md`
  - `GEMINI.md`
  - `.cursorrules`
  - `.cursor/rules/00-core.mdc`
  - `.cursor/rules/10-handoff.mdc`
  - `.github/copilot-instructions.md`
  - `.github/instructions/handoff.instructions.md`

- 上下文与计划：
  - `progress.md`
  - `task_plan.md`
  - `findings.md`
  - `修改记录_会话备忘.md`
  - `session_record.md`（英文别名）

- 提示词与映射：
  - `模型接力开发_固定提示词与命令.txt`
  - `relay_prompts.txt`（英文别名）
  - `relay.map.json`

- 执行脚本：
  - `scripts/preflight.ps1`
  - `scripts/sync_skills.ps1`
  - `copy_skills.py`

---

## 6. 每次开发时怎么用（最短操作）

### 可直接说的中文话术
以后你不需要记 `relay-start` 这类英文名，直接说下面这些中文就可以：

- `接手这个项目，按接力开发规则来`
- `给这个项目初始化接力开发`
- `重新同步当前任务`
- `做一次标准交接`
- `按接力开发流程处理这个项目`

建议：
- 新会话接手时优先说：`接手这个项目，按接力开发规则来`
- 新项目铺模板时优先说：`给这个项目初始化接力开发`
- 上下文乱了时优先说：`重新同步当前任务`
- 准备结束时优先说：`做一次标准交接`

### 开场（无论哪个软件/模型）
在会话第一条消息发“开场固定提示词”，要求模型先读取：

`AGENTS.md -> progress.md -> task_plan.md -> findings.md -> 修改记录_会话备忘.md`

默认读取粒度建议：
- `AGENTS.md` 全文读取。
- `progress.md` 先读顶部 `Latest Handoff Snapshot`。
- `task_plan.md` 先读当前任务相关段、未完成项与风险。
- `findings.md` 先读当前 `Task-ID` 的最近事实。
- `修改记录_会话备忘.md` 先读最近 1-3 条相关记录。
- 只有在用户明确要求、上下文冲突或当前任务无法恢复时，才进行全文补读。

并返回：
- Active Goal
- Current Phase
- Next First Command
- Open TODO Top3

### 收尾（准备切换前）
在收尾固定提示词中要求模型必须：
- 更新 `progress.md` 顶部 `Latest Handoff Snapshot`。
- 追加 `修改记录_会话备忘.md` 的 `Session Record`。
- 输出一句交接摘要后停止执行。

这一步是接力稳定性的关键，不要省略。

---

## 7. 跨软件 / 跨模型切换建议

### 场景 A：Antigravity -> Cursor / VSCode / Codex
1. 在旧会话执行收尾固定提示词。
2. 在新会话执行开场固定提示词。
3. 让新模型先汇报 `Next First Command` 再继续。

### 场景 B：同一软件内切换模型（如 Gemini -> Codex）
流程同上，仍建议“收尾 + 开场”一进一出。

原因：模型上下文窗口和系统提示不同，不做交接容易重复或偏离。

---

## 8. 常用命令速查

### 项目内预检

```powershell
powershell -ExecutionPolicy Bypass -File scripts/preflight.ps1 -ProjectRoot .
```

### 项目内同步 skills

```powershell
powershell -ExecutionPolicy Bypass -File scripts/sync_skills.ps1 -ProjectRoot .
```

### 重新初始化（仅当你明确需要重铺模板）

```powershell
powershell -ExecutionPolicy Bypass -File "E:\AI软件\接力开发\scripts\relay_init.ps1" -ProjectRoot "<项目路径>" -Profile stock-cn -Tools antigravity,cursor,vscode,codex -Naming bilingual -Force
```

---

## 9. 常见问题（FAQ）

### Q1：为什么开场后模型还是“失忆”？
优先检查：
1. 是否真的先读取了 `AGENTS.md` 和 4 个上下文文件。
2. 上一轮是否写了 `Latest Handoff Snapshot` 与 `Session Record`。
3. `preflight.ps1` 是否通过。

### Q2：可以只用一个软件不切换吗？
可以。仍建议按同样规则维护 `progress/task_plan/findings`，这样后续切换才无缝。

### Q3：为什么要保留中文+英文别名？
中文适配你当前使用习惯；英文便于后续跨团队/跨工具兼容。`relay.map.json` 是双轨映射真相源。

### Q4：新项目初始化后要不要立刻改业务代码？
建议先跑 `preflight`，再开场读取上下文，确认 `Next First Command` 后再改业务代码。

---

## 10. 维护与升级建议

1. 把 `E:\AI软件\接力开发` 当作“母包”，项目里的是“实例”。
2. 母包有更新时，先在测试项目验证，再推广到正式项目。
3. 不要在业务项目里随意删 `progress/task_plan/findings`，它们是接力记忆核心。
4. 如果出现规则冲突，以项目内 `AGENTS.md` 为准。

### 当前模板版本

- 当前母包版本：`1.1.0`
- 本次升级重点：
  - 会话恢复默认改为“摘要优先、按需深读”。
  - 不再鼓励因“新会话接手”而机械全文通读长交接文件。
  - `Cursor / Copilot / Handoff instructions / relay-start / relay-resync` 已统一到同一口径。

### 如何判断旧项目是否需要重铺模板

优先检查以下任一项：

1. 项目里的 `relay.map.json` 版本仍是 `1.0.0`。
2. 项目里的 `AGENTS.md` 只有“按顺序读取”要求，但没有“默认读取粒度 / 全文读取触发条件”。
3. 项目里的 `.cursor/rules/00-core.mdc` 或 `.cursor/rules/10-handoff.mdc` 还没有“摘要优先、按需深读”表述。
4. 新会话接手时，模型仍倾向机械全文读取 `progress.md / findings.md / 修改记录_会话备忘.md` 等长文件。

出现以上任一情况，就建议重铺模板或手工同步规则文件。

### 升级建议

推荐顺序：

1. 先在测试项目执行一次 `relay_init.ps1 -Force`。
2. 跑 `scripts/preflight.ps1` 确认模板、规则文件和 skills 都能正常落地。
3. 再把同一版本推广到正式项目。

### 兼容性说明

- `1.1.0` 不改变交接文件结构，不改变 `Task-ID / Snapshot / Session Record` 基本协议。
- `1.1.0` 主要收敛的是“读取粒度”，属于低风险升级。
- 已初始化的旧项目不会自动升级，必须重新初始化或手工同步。

---

## 11. 一句话工作流

初始化新项目 -> 预检 -> 开场读取上下文 -> 执行业务任务 -> 收尾写交接 -> 切换模型/软件继续。

这就是这套资产的最小稳定闭环。

---

## 12. 公开到 GitHub 的建议结构

如果你准备把这套能力开源，推荐把它当作“可安装的 skill 仓库 + 可初始化的新项目模板仓库”来发布。

推荐保留以下结构：

- `skills/`
  - 面向外部安装的公开 skills 目录。
  - 适合被 Codex 的 skill-installer 直接按 GitHub 路径安装。
- `.relay/skills/`
  - 当前母包内部工作目录，可继续作为本地维护入口。
- `starter/relay-kit-v1/`
  - 新项目初始化模板。
- `scripts/install_skills.py`
  - 跨平台核心安装脚本。
- `scripts/install.ps1`
  - Windows 一键安装入口。
- `scripts/install.sh`
  - macOS / Linux 一键安装入口。

这样发布后，别人既可以“安装全局 skills”，也可以“拿模板初始化新项目”。

---

## 13. 一键安装（适合仓库使用者）

### 方式 A：克隆仓库后本地安装

Windows:

```powershell
git clone <你的仓库地址>
cd <仓库目录>
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Force
```

macOS / Linux:

```bash
git clone <你的仓库地址>
cd <仓库目录>
bash ./scripts/install.sh --force
```

默认会安装到：

- Codex：`~/.codex/skills`
- Claude Code：`~/.claude/skills`
- Cursor / 共享 agents：`~/.agents/skills`

### 方式 B：用 Codex 自带 skill-installer 从 GitHub 路径安装

如果仓库发布后包含顶层 `skills/` 目录，Codex 用户可以直接安装某个 skill，例如：

```bash
python "<CODEX_HOME>/skills/.system/skill-installer/scripts/install-skill-from-github.py" \
  --repo <owner>/<repo> \
  --path skills/relay-dev \
  --path skills/relay-start \
  --path skills/relay-resync \
  --path skills/relay-handoff-stop
```

建议至少公开这 4 个：

- `relay-dev`
- `relay-start`
- `relay-resync`
- `relay-handoff-stop`

如果要装完整套，再补：

- `relay-scope-change`
- `relay-verify`

---

## 14. 安装后怎么触发

安装到全局 skill 目录后，用户在新会话里直接说中文即可，不需要记英文 skill 名：

- `接手这个项目，按接力开发规则来`
- `给这个项目初始化接力开发`
- `重新同步当前任务`
- `做一次标准交接`
- `按接力开发流程处理这个项目`

推荐把 `relay-dev` 作为统一入口 skill，让它自动分流到：

- `relay-start`
- `relay-resync`
- `relay-handoff-stop`

---

## 15. 开源前的最小检查清单

在真正公开前，建议再检查这几项：

1. 把仓库中的个人绝对路径逐步替换成相对路径或变量说明。
2. 确认不包含任何项目私有交接记录、私有 token、账号信息或业务数据。
3. 选择并补充开源许可证。
4. 在一台干净环境上实际运行一次：
   - `scripts/install.ps1`
   - `scripts/install.sh`
5. 在 Codex / Cursor / Claude Code 中各开一个新会话，验证中文话术能正确触发。
