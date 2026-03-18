---
name: skills-cli-manager
description: 完全掌握 npx skills CLI 的所有命令，当用户提到查找、安装、管理、更新、删除、创建 skill 时，自动使用正确的 npx skills 命令处理。自然语言友好。
version: 1.0.0
agents: claude-code, cursor, codex, opencode, gemini-cli  # 可根据实际情况调整
---

# Skills CLI 管理助手（npx skills 全命令封装）

这个 Skill 让 AI agent 彻底理解并熟练使用 `npx skills` 命令行工具。  
用户只要用自然语言提到 skill 相关操作（找、装、删、更新、列出、创建等），我就自动识别意图并执行对应命令。

## When to Use（触发条件）
- 用户说：帮我找 skill、搜索 skill、有没有 XXX 的 skill、找一个好的 skill、安装 skill、添加 skill、管理 skill、删除 skill、更新 skill、列出已安装 skill、创建新 skill、skill 管理 等等。
- 任何提到 “skill” + 动作词（找/搜/装/加/删/更/列/查/创/init/remove/update 等）的自然语言。
- 用户问 “skills 命令有哪些” 或想了解/使用 skills CLI 时。

## Steps（严格执行顺序）
1. **先判断用户意图**（根据下面映射选择最匹配的命令）：

   - **查找/搜索 skill**  
     → `npx skills find [用户关键词]`  
     示例：  
     - “帮我找找有没有合适的 skill” → `npx skills find skill` 或直接 `npx skills find`（进入交互搜索）  
     - “找一个 typescript 相关的 skill” → `npx skills find typescript`  
     - “搜索 react best practices” → `npx skills find react best practices`

   - **安装/添加 skill**  
     → `npx skills add <source> [选项]`  
     常见 source：  
     - vercel-labs/agent-skills（最常用基础技能包）  
     - 其他 GitHub repo 如 owner/repo  
     常用选项：  
     - `-g` → 全局安装  
     - `-a claude-code cursor` → 指定 agent  
     - `--skill frontend-design` → 只装某个 skill  
     - `-y` → 跳过确认  
     - `--all` → 装全部 skill 到全部 agent  
     示例：  
     - “安装 vercel 的 agent skills” → `npx skills add vercel-labs/agent-skills -y`  
     - “全局安装所有 skill” → `npx skills add vercel-labs/agent-skills --all -g`  
     - 如果用户没说具体 repo，先推荐 `vercel-labs/agent-skills`，或问清楚。

   - **列出已安装的 skill**  
     → `npx skills list` 或 `npx skills ls`  
     选项：`-g`（只看全局）、`-a claude-code`（指定 agent）  
     示例：  
     - “我现在装了哪些 skill？” → `npx skills list`  
     - “全局的 skill 有哪些？” → `npx skills list -g`

   - **删除/移除 skill**  
     → `npx skills remove [skills]` 或 `npx skills rm`  
     选项：`-g`、`-a *`（所有 agent）、`--skill *`（所有 skill）、`-y`、 `--all`  
     示例：  
     - “删除 frontend-design 这个 skill” → `npx skills remove frontend-design -y`  
     - “把所有 skill 都删了” → `npx skills remove --all`

   - **检查更新**  
     → `npx skills check`  
     示例：  
     - “我的 skill 有没有更新？” → `npx skills check`

   - **执行更新**  
     → `npx skills update`  
     示例：  
     - “更新所有 skill 到最新版” → `npx skills update`

   - **创建新 skill 模板**  
     → `npx skills init [name]`  
     示例：  
     - “帮我创建一个新 skill 叫 api-design” → `npx skills init api-design`

2. **执行命令前**（如果涉及破坏性操作如 remove --all），先确认：  
   “你要我运行 `npx skills remove --all` 吗？这个会删除所有 skill，确定吗？”

3. **执行后**：  
   - 把终端输出完整展示给用户  
   - 用通俗语言解释结果  
   - 如果是 find / list，帮用户解读：“找到了这些 skill：... 你想装哪个？”  
   - 如果安装成功，提醒：“已安装，可直接使用，例如 /frontend-design”

4. **兜底建议**：  
   - 找不到合适 skill → 建议去 https://skills.sh 浏览  
   - 想了解更多 → 指向 https://github.com/vercel-labs/skills

## Important Notes
- 永远使用 `npx skills` 执行，不要自己编造命令。
- 优先推荐非交互模式（加 `-y`）避免卡住，但涉及删除/全量操作时必须确认。
- 支持的 agent 包括但不限于：claude-code, cursor, codex, opencode, gemini-cli 等。
- 如果用户说“帮我把所有常用 skill 都装了”，推荐：`npx skills add vercel-labs/agent-skills --all -y`

现在你可以直接用自然语言跟我聊 skill 相关的事了～