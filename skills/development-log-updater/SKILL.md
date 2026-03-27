---
name: development-log-updater
description: Update the project root development log after coding, debugging, refactor, feature, fix, or other code-changing tasks. Use for nearly all software development requests where files may be created or modified, and finish by creating or updating a root development log that records complete change items, reasons, affected files, and verification results.
---

# Development Log Updater

Treat development logging as a required closing step for the task, not an optional doc pass.

This skill is workflow guidance, not a platform-level hook. Apply it aggressively on implementation tasks so the project root development log is kept current after each completed development request.

## Workflow

### 1. Determine the project root log file

Inspect the project root and reuse an existing development log if one already exists.

Preferred file selection order:

1. `DEVELOPMENT_LOG.md`
2. `development-log.md`
3. `DEVLOG.md`
4. `project-dev-log.md`
5. If none exist, create `DEVELOPMENT_LOG.md`

Do not scatter logs across multiple files. Keep updating the same root log file once one has been established.

### 2. Complete the development work first

Implement the user's requested code changes, run the appropriate checks, and gather the exact files and behaviors that changed.

Before writing the log entry, confirm:

- what files were added, modified, renamed, or deleted
- what behavior changed
- why each change was necessary
- what validation was run
- what remains unverified or risky

### 3. Append one complete log entry at the end

Append a new entry to the root development log after the task is complete.

Always include:

- date and time
- user request summary
- status
- complete file list
- complete modification items
- modification rationale
- verification performed
- known limitations or follow-up items

If the task ended with no repository file changes, still append an entry and state clearly that the result was analysis only.

## Entry Standard

Use Markdown. Keep entries scannable, but do not collapse the work into vague one-line summaries.

Use this structure:

```markdown
## 2026-03-27 15:30

- Request: <what the user asked for>
- Status: completed | partial | analysis only
- Files changed:
  - `path/to/file-a`
  - `path/to/file-b`
- Changes made:
  - <concrete modification 1>
  - <concrete modification 2>
- Why:
  - <reason for modification 1>
  - <reason for modification 2>
- Verification:
  - <tests/checks/commands reviewed>
- Remaining notes:
  - <risks, limitations, or next steps>
```

Adapt the headings if the repository already uses a different house style, but preserve the same information density.

## Logging Rules

- Record concrete edits, not generic summaries such as "updated logic" or "fixed bug".
- Mention file paths explicitly.
- Explain intent and effect together: what changed and why it matters.
- Include config, script, test, schema, UI, and documentation changes when they were part of the task.
- Mention deleted code or removed behavior explicitly.
- Mention tests not run when validation was skipped or unavailable.
- Keep the entry truthful. Do not claim verification that did not happen.

## Behavior For Existing Logs

If the root log already has a format, continue that format instead of rewriting the whole file.

Only normalize structure when the existing log is empty or clearly unusable.

Do not rewrite older entries unless the user explicitly asks for cleanup.

## Definition of Done

For development tasks using this skill, the task is not complete until the project root development log has been created or updated with the current task entry.
