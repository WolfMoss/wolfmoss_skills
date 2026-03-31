---
name: auto-commit-after-task
description: Use when an agent has completed the user's task and is preparing to wrap up, and needs to decide whether to create a git commit for the task's file changes. Trigger at task completion when the workspace may contain modifications that should be committed automatically if they belong to the finished task.
---

# Auto Commit After Task

Commit only at the end of the task, and only when the current workspace has file changes that belong to the completed work.

## Workflow

1. Confirm the task is actually complete. Do not commit mid-task.
2. Confirm the current directory is inside a git repository.
3. Inspect the workspace with `git status --short`.
4. If there are no modified, deleted, renamed, copied, or untracked files, state that there is nothing to commit and skip git commit.
5. If there are changes, review them before staging. Do not blindly include obviously unrelated work.
6. Stage the task's changes with a non-interactive command.
7. Create one concise commit message describing the completed task.
8. Report the commit hash in the final response.

## Guardrails

- Never run `git commit` when `git status --short` is empty.
- Never use interactive git flows.
- Never push unless the user explicitly asks for `git push`.
- Never rewrite history as part of this skill.
- If the worktree contains unrelated changes that should not be committed together, stop and tell the user what you found instead of guessing.
- If there is no git repository, state that clearly and skip commit.

## Commit Message Rules

- Prefer short imperative summaries such as `add auto-commit-after-task skill`.
- Keep the message scoped to the finished task.
- Avoid generic messages such as `update files` or `misc changes`.

## Suggested Commands

```powershell
git rev-parse --is-inside-work-tree
git status --short
git add -A
git commit -m "add auto-commit-after-task skill"
git rev-parse --short HEAD
```

Adapt the commit message to the actual task. If unrelated changes are present, inspect with `git diff --stat` or file-specific diffs before staging.
