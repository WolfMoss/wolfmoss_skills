---
name: 学习链接收集器
description: >-
  【必触发】仅一条 URL、或 [分享]/[学习] 与 URL 同现、或 mp.weixin.qq.com / http(s):// 链接分享 → 立即读本 SKILL 并执行入库，禁止只摘要不入库。
  目标表：飞书多维表格「网络知识收集目录」。优先用环境变量 FEISHU_LEARNING_BASE_TOKEN 跳过搜索；否则 docs +search。写入用 lark-cli base +record-upsert，先读 lark-base。
---

# 学习链接收集器

自动收集并整理学习相关的网址到飞书多维表格 **「网络知识收集目录」**。

## 何时使用 / 何时不用

**必须使用本 skill（满足任一即可）：**

- 用户消息 **只有** 一条或多条 `http(s)://` 链接；
- 消息含 **`[分享]`** 或 **`[学习]`** 且含 URL；
- 微信公众号 **`mp.weixin.qq.com`** 等文章链接。

**不要使用本 skill：**

- 用户明确说 **只要摘要 / 不要写入飞书 / 不要收集**。

## 最短路径（优先）

1. **读** `lark-base` skill（例如 `~/.claude/skills/lark-base/SKILL.md`）中与 `+record-upsert`、`+field-list` 相关的规则（若当前环境已安装 lark-cli）。
2. **定位 Base（二选一，按顺序尝试）：**
   - **A（推荐，零搜索）**：若存在环境变量 **`FEISHU_LEARNING_BASE_TOKEN`**（值为浏览器打开该多维表格时 URL 中 `base/` 后的 token），则 **不要** 执行 `docs +search`，直接：
     `lark-cli base +table-list --base-token <token>` → 得到默认数据表名或 `table_id`。
   - **B**：未设置环境变量时，再执行  
     `lark-cli docs +search --query "网络知识收集目录"`，从结果中取 `BITABLE` 的 `token` 作为 `--base-token`。
3. **`+field-list`**：对目标表执行一次，确认字段名与类型；**写入前禁止猜字段名**。
4. **拉取网页**：标题 + 摘要（工具优先级见下）。
5. **`lark-cli base +record-upsert`**：仅写字段表里的 **可写存储字段**；值形状以 lark-base 中的 `lark-base-shortcut-record-value.md` 为准（以本机 `lark-cli` 与 lark-base skill 实际路径为准）。

## 执行清单（按序打勾）

- [ ] 已确认用户未要求「只读摘要不入库」
- [ ] 已得到 `base_token`（环境变量优先于搜索）
- [ ] 已 `+field-list`，确认 **链接** 等列的实际类型
- [ ] 已获取页面标题与摘要
- [ ] 已构造 `--json` 并完成 `+record-upsert`

## 工作流程（详细）

当触发条件满足时：

0. **确定链接** — 多条链接时从后往前试，直到拿到可抓取的一条。
1. **确认表格** — 优先 `FEISHU_LEARNING_BASE_TOKEN`；否则搜索「网络知识收集目录」。
2. **验证结构** — `+field-list`。
3. **获取内容** — 见下「工具选择」。
4. **推断分类** — 见「分类类别」。
5. **插入记录** — `lark-cli base +record-upsert`（不要走未封装的 bitable HTTP，除非 lark-base 明确允许）。

## 工具选择（获取网页内容）

按优先级尝试：

1. stealthy_fetch — 高保护站点（微信公众号等），需 Playwright
2. get — 通用 HTTP
3. web_fetch — 备选

若 `stealthy_fetch` 报 `Executable doesn't exist`，安装 Playwright；仍失败则改用 `get` / `web_fetch`。

## 飞书多维表格

- **表（应用）名称**：网络知识收集目录（搜索关键词）
- **可选环境变量**：`FEISHU_LEARNING_BASE_TOKEN` = Base 的 `app_token`（浏览器地址 `.../base/<token>` 段）

## 字段结构与格式（lark-cli）

**必须先 `+field-list`。** 下列为常见字段；若与你租户表不一致，以 CLI 返回为准。

| 字段名 | 典型类型 | `+record-upsert` 建议 |
|--------|----------|------------------------|
| 标题 | text | 字符串 |
| 一级分类 / 二级分类 / 三级分类 | text | 字符串 |
| 链接 | url（多为 text + url 样式） | **完整 URL 字符串**，如 `https://example.com/path` |
| 内容摘要 | text | 字符串 |
| 时间 | text | 字符串，如 `YYYY-MM-DD` |

**正确示例（`--json` 对象，字段名需与表一致）：**

```json
{
  "标题": "文章标题",
  "一级分类": "工具效率",
  "二级分类": "AI 编程助手",
  "三级分类": "OpenClaw",
  "链接": "https://mp.weixin.qq.com/s/xxxxxxxx",
  "内容摘要": "文章摘要内容……",
  "时间": "2026-04-01"
}
```

**错误示例：**

- 文本字段写成 `[{"text":"…","type":"text"}]` 数组形式（除非字段类型要求）。
- 未读 `+field-list` 就照搬上表字段名（若表中无「时间」等，勿写）。

**Windows 写入 JSON 文件时注意：** 使用 UTF-8 **无 BOM**，避免 `lark-cli` 报 JSON 解析错误；或 inline 一行 JSON 传 `--json`。

## 分类类别

**一级分类：**

- 技术开发
- 产品设计
- 商业管理
- 个人成长
- 工具效率
- 金融投资
- 其他

**二级 / 三级分类：** 根据正文推断。

## 常见错误处理

| 现象 | 原因 | 处理 |
|------|------|------|
| `missing_scope` / `search:docs:read` | 应用未开通云文档搜索权限，或用户未授权该 scope | 飞书开发者后台为应用添加 **搜索云文档** 相关权限后执行 `lark-cli auth login --scope "search:docs:read"`；或改用 **`FEISHU_LEARNING_BASE_TOKEN`** 免搜索 |
| `docs +search` 无结果 | 表名变更或无权 | 用户侧打开表，从 URL 取 token 设环境变量或发链接 |
| `--json invalid` / 空字节 | JSON 文件带 BOM 或编码错误 | UTF-8 无 BOM 或用 Python 一次性 `json.dumps` 写文件 |
| URLFieldConvFail / 链接写不进去 | 与真实字段类型不符 | 再查 `+field-list`；多数情况下 **纯 URL 字符串**即可 |
| Executable doesn't exist | Playwright 未安装 | 安装 Playwright 或换 `get` / `web_fetch` |
