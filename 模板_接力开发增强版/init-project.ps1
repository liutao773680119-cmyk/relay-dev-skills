param(
    [string]$TargetDir = '.',
    [string]$TaskId = 'T001',
    [string]$TaskName = '初始化接力开发模板'
)

$ErrorActionPreference = 'Stop'

$templateDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$targetPath = (Resolve-Path $TargetDir).Path

$files = @(
    'AGENTS.md',
    'progress.md',
    'task_plan.md',
    'findings.md',
    'task_registry.md',
    '修改记录_会话备忘.md',
    '提示词_接手项目.md',
    '桥接规则.md',
    '避坑记录.md'
)

foreach ($file in $files) {
    Copy-Item -Path (Join-Path $templateDir $file) -Destination (Join-Path $targetPath $file) -Force
}

$now = Get-Date -Format 'yyyy-MM-dd HH:mm'

$registry = @(
    '# Task Registry',
    '',
    '| Task-ID | Task-Name | Status | Owner | Last Update | Next First Command | Notes |',
    '|---------|-----------|--------|-------|-------------|--------------------|-------|',
    "| $TaskId | $TaskName | active | Codex | $now | Get-ChildItem -Force | 模板已初始化，等待真实任务。 |"
) -join "`r`n"
Set-Content -Path (Join-Path $targetPath 'task_registry.md') -Value $registry -Encoding UTF8

$progress = @(
    '# Progress',
    '',
    '## Latest Handoff Snapshot',
    "- Task-ID: $TaskId",
    "- Task-Name: $TaskName",
    '- Files Changed:',
    '  - 初始化交接模板',
    '- Completed This Session:',
    '  - 已复制接力开发增强版模板',
    '- Open TODO:',
    '  - 锁定当前真实任务',
    '  - 补充 task_plan.md',
    '  - 开始首条真实命令',
    '- Risks/Blockers:',
    '  - 待确认当前目录是否已有真实项目内容',
    '- Next First Command: Get-ChildItem -Force',
    '- Known Avoidances:',
    '  - 没有确认目录和 git 状态前，不要直接假设已有可用项目上下文。',
    '',
    '## Session Log',
    '',
    "### $now",
    '- Status: complete',
    '- Summary:',
    '  - 复制增强版交接模板',
    '  - 初始化默认 Task-ID 和交接快照',
    '- Files created/modified:',
    '  - AGENTS.md',
    '  - progress.md',
    '  - task_plan.md',
    '  - findings.md',
    '  - task_registry.md',
    '  - 修改记录_会话备忘.md',
    '  - 提示词_接手项目.md',
    '  - 桥接规则.md',
    '  - 避坑记录.md'
) -join "`r`n"
Set-Content -Path (Join-Path $targetPath 'progress.md') -Value $progress -Encoding UTF8

$plan = @(
    '# Task Plan',
    '',
    '## Task',
    "- Task-ID: $TaskId",
    "- Task-Name: $TaskName",
    '- Goal: 为当前目录建立可执行的接力开发上下文，并进入真实任务。',
    '',
    '## Phases',
    '| Phase | Status | Description |',
    '|-------|--------|-------------|',
    '| 1. 启动检查 | pending | 检查目录、git、语言环境和项目文件。 |',
    '| 2. 上下文恢复 | pending | 读取关键文件并锁定真实任务。 |',
    '| 3. 开始执行 | pending | 运行 Next First Command 并进入真实工作。 |',
    '',
    '## Next Actions',
    '1. 运行 Get-ChildItem -Force',
    '2. 明确当前真实任务',
    '3. 每次确认失败路径后，更新 避坑记录.md',
    '',
    '## Notes',
    '- 这是初始化后的默认计划，进入真实任务后应立即覆盖。'
) -join "`r`n"
Set-Content -Path (Join-Path $targetPath 'task_plan.md') -Value $plan -Encoding UTF8

$memo = @(
    '# 修改记录_会话备忘',
    '',
    '## Session Record',
    "- Task-ID: $TaskId",
    "- Task-Name: $TaskName",
    "- 时间: $now",
    '- 本轮目标:',
    '  - 初始化接力开发增强版模板',
    '- 已完成:',
    '  - 模板文件复制完成',
    '  - 默认交接快照已生成',
    '- 未完成:',
    '  - 尚未锁定真实任务',
    '- 关键命令/结果:',
    '  - init-project.ps1 -> 初始化完成',
    '- 下一步:',
    '  - 执行 Get-ChildItem -Force',
    '- 新增/更新的避坑记录:',
    '  - 没有确认目录状态前，不要假设存在真实项目上下文'
) -join "`r`n"
Set-Content -Path (Join-Path $targetPath '修改记录_会话备忘.md') -Value $memo -Encoding UTF8

Write-Output "Initialized relay template in $targetPath"
