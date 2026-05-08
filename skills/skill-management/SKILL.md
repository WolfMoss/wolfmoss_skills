---
name: skill-management
description: 安全使用 npx skills（查找、安装、列出、更新、删除、创建）。强制区分 add 与 remove 中 --all 的语义；删除只用「具名列表 + -y ± -g」，禁止在 remove 时滥用 --all。用户提到 skill 管理时优先读本 skill。
version: 1.1.0
agents: claude-code, cursor, codex, opencode, gemini-cli
---

# Skill 管理（npx skills）— 安全 CLI 助手

本 skill 要求 agent **熟练且安全地**使用 `npx skills`，并在删除场景下遵守下文 **硬性规则**，避免误删整套已安装 skill。

## When to Use（触发条件）

- 用户提到：找/装/删/更新/列出 skill、`npx skills`、skills CLI、全局 skill、清理 skill 等。
- 即将执行任何 `skills remove` / `skills rm` 命令前，必须先核对本节 **删除规则**。

---

## 血泪规则：`remove` 与 `--all`（必读）

### 事故摘要（真实发生）

执行类似：

`npx skills remove skill-a skill-b skill-c ... -y --all`

时，CLI 可能对「当前环境里注册的 skill」做**大范围卸载**，报告 **Removed N skill(s)**，其中 **N 远大于你写在命令行里的名称个数**。结果：`~/.agents/skills` 下skill可能被**近乎清空**，且 **`.skill-lock.json` 里的元数据未必自动帮你找回未记录在 lock 里的本机副本**。

### 硬性规定（agent 必须遵守）

1. **删除指定 skill 时，禁止使用 `npx skills remove ... --all`。**
   - 例外：**只有**用户在对话里**逐字确认**「我要清空本机/全局全部 skill」时，才允许讨论 `remove --all`；仍应先 `npx skills list -g` 展示清单再执行。

2. **删除多个 skill 的安全写法（全局示例）：**

   ```bash
   npx skills remove <name1> <name2> ... -y -g
   ```

   - **不要**在末尾加 `--all`。
   - 需要指定 agent 时用文档支持的 `-a`，**不要**用 `--all` 代替「多 agent」意图。

3. **`add` 与 `remove` 中的 `--all` 语义不同，禁止混为一谈：**
   - `npx skills add <repo> --all`：通常表示从该 **repo 安装全部 skill**（仍属破坏性较低的「装」）。
   - `npx skills remove ... --all`：**极高风险**，极易 interpreted 为「卸载范围极大」，等同于踩雷区。

4. **大批量删除前的检查清单：**
   - 先运行：`npx skills list` / `npx skills list -g`，把输出保存或展示给用户。
   - 确认只删除用户点名的 **slug**（与 list 中名称一致）。
   - 若用户从 GitHub 安装过 skill，删除后可通过 `~/.agents/.skill-lock.json`（若仍存在）里的 `sourceUrl` / `skillPath` 用 `npx skills add` **重装**；从未进入 lock 的本机-only skill **无法靠 CLI 自动找回**，需备份目录或重新 clone。

---

## Steps（严格执行顺序）

### 1. 判断意图并选用命令

| 意图 | 命令 |
|------|------|
| 查找 | `npx skills find [关键词]` |
| 安装 | `npx skills add <owner/repo> [--skill <name> ...] -y [-g]` |
| 列出 | `npx skills list` / `npx skills list -g` |
| 删除 | **`npx skills remove <name> [<name> ...] -y [-g]` — 禁止附带 `--all`** |
| 检查更新 | `npx skills check` |
| 更新 | `npx skills update` |
| 初始化模板 | `npx skills init <name>` |

### 2. 安装示例（节选）

- 装整个仓库全部 skill（仅 **add** 场景）：`npx skills add vercel-labs/agent-skills --all -y -g`
- 只装若干：`npx skills add vercel-labs/agent-skills --skill deploy-to-vercel --skill web-design-guidelines -y -g`

### 3. 删除示例（正确）

- `npx skills remove frontend-design core-web-vitals -y -g`

### 4. 删除示例（错误 — 禁止照抄）

- `npx skills remove frontend-design other-skill -y --all` ❌

### 5. 执行后

- 展示完整终端输出；若删除 skill，说明是否只剩 lock 可恢复、哪些需手动重装。

---

## Important Notes

- 始终使用真实的 `npx skills`，不编造子命令。
- **永远不要**在「帮用户删掉某几个 skill」时用 `remove ... --all`。
- 支持的 agent 包括但不限于：claude-code, cursor, codex, opencode, gemini-cli 等。
- 兜底：检索与浏览可参考 https://skills.sh 与 https://github.com/vercel-labs/skills
