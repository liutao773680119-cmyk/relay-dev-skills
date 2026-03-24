# Contributing

欢迎改进这套接力开发仓库。

这不是一个普通的代码仓库，它更像一套“可被模型消费的协作协议”。  
所以贡献时，最重要的不是把文件变多，而是让流程更稳定、更清楚、更容易被不同模型正确触发。

## 最适合贡献的方向

你可以优先从这些方向贡献：

1. 改进 skills
   - 提高触发准确率
   - 减少歧义
   - 压缩不必要的上下文负担

2. 改进模板
   - 让新项目初始化后更容易进入接力开发
   - 让交接文件更清晰
   - 让不同工具之间的规则更一致

3. 改进安装体验
   - 修复 `install.ps1`
   - 修复 `install.sh`
   - 改进跨平台兼容性

4. 改进文档
   - 增加真实使用案例
   - 改善 README 的表达
   - 补充多语言说明

## 提交前建议

如果你要改动 skills 或模板，建议先验证这几件事：

1. 新会话是否更容易恢复上下文
2. 中文触发话术是否仍然自然
3. 是否引入了更高的 token 消耗
4. 是否会让不同工具的行为出现分叉

## 仓库结构说明

- `skills/`
  - 面向外部分发的公开 skills

- `.relay/skills/`
  - 母包内部维护源

- `starter/relay-kit-v1/`
  - 新项目模板

- `scripts/`
  - 安装脚本与初始化脚本

## Pull Request 建议

一个 PR 最好只做一类事情，例如：

- 只改 skill 触发逻辑
- 只改模板文案
- 只改安装脚本
- 只补文档

这样更容易评审，也更容易定位回归。

## Commit 风格建议

推荐使用这种简洁风格：

- `feat: add new relay skill`
- `fix: repair install.sh path handling`
- `docs: improve readme quick start`
- `refactor: simplify handoff instructions`

## 如果你不确定该改哪里

最好的起点通常是：

1. 先看 `README.md`
2. 再看 `USAGE_DEMO.md`
3. 再看 `skills/relay-dev/SKILL.md`

如果这三处都能被你顺畅理解，说明仓库入口是清晰的；  
如果你在这里就卡住了，往往说明仓库还有可以改进的地方。
