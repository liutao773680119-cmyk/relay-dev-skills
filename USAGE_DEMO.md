# 使用演示

下面是一个最小但真实的使用路径，适合第一次体验这套仓库的人。

## 演示目标

模拟这样一个场景：

- 你在一个新项目里开始开发
- 中途切换模型
- 再切换工具
- 最后还能无痛接上

## 第一步：安装全局 skills

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Targets codex,claude,agents -Source skills -Force
```

## 第二步：初始化一个测试项目

```powershell
mkdir D:\Projects\relay_demo
powershell -ExecutionPolicy Bypass -File ".\scripts\relay_init.ps1" `
  -ProjectRoot "D:\Projects\relay_demo" `
  -Profile stock-cn `
  -Tools antigravity,cursor,vscode,codex `
  -Naming bilingual `
  -Force
```

## 第三步：在第一个会话里接手

在 Codex、Cursor 或 Claude Code 的新会话里说：

```text
接手这个项目，按接力开发规则来
```

模型应该先恢复上下文，而不是立刻开始瞎改代码。

## 第四步：做一点真实工作

例如你让它：

```text
帮我梳理当前项目的任务状态，并准备下一步修改计划
```

## 第五步：结束前标准交接

在会话结束时说：

```text
做一次标准交接
```

这一步应该促使模型更新：

- `progress.md`
- `task_registry.md`
- `修改记录_会话备忘.md`

## 第六步：切换到另一个模型或另一个工具

比如你从 Codex 切到 Cursor，再开一个新会话，说：

```text
接手这个项目，按接力开发规则来
```

如果这套仓库工作正常，新会话应该能快速给出：

- Active Goal
- Current Phase
- Next First Command
- Open TODO Top3

而不是要求你把整个背景重讲一遍。

## 第七步：如果上下文乱了

你可以直接说：

```text
重新同步当前任务
```

## 你应该看到的效果

理想情况下，这套流程会带来这些变化：

- 换模型后不再从零开始解释
- 换工具后仍然能按同一规则接手
- 项目状态更多地保存在文件里，而不是聊天记录里
- 交接质量更稳定

## 建议第一次体验时重点观察

1. 新会话是否先恢复上下文再执行
2. 收尾时是否真的写回交接文件
3. 第二个会话是否能读出正确的 `Next First Command`
