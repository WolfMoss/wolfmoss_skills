---
name: project-readme-docs
description: Creates or updates the project root README.md so strangers or AI can understand the project quickly. Use when the user asks to write/update README, document or explain the project, create onboarding docs, or when code structure has materially changed and README should be kept in sync.
---

# Project README Docs

Create or update the project root `README.md` so a new reader can understand the project at a glance.

## When to use

Use this skill when any of the following is true:

1. The user explicitly asks to write or update `README.md`.
2. The user asks to document, explain, onboard, or summarize the project for other people or AI.
3. A task creates a new project or establishes its initial structure.
4. A task materially changes the codebase structure and the README should stay in sync.

Important:

- This skill is not an automatic event hook.
- It triggers when the current user request clearly implies README or project documentation work, or when the skill is explicitly named.
- If the user is only asking for a code change and does not ask for docs, you may skip this skill unless README drift would obviously be harmful.

## Goal

The README should let a stranger quickly understand:

- what the project does
- the main architecture and data flow
- what each important directory or file is responsible for
- how to run the project

## Workflow

### 1. Inspect the project

- Identify the project root.
- List the main directories and important files.
- Read the entry points, configuration, and core modules.
- Ignore generated or vendor directories such as `node_modules`, `.git`, `.next`, `dist`, `build`, `coverage`, `__pycache__`, and virtual environments unless they are directly relevant.

Focus on:

- where execution starts
- how modules depend on each other
- where configuration comes from
- what inputs and outputs exist

### 2. Summarize the architecture

Capture, in short and concrete language:

- project purpose
- major layers or modules
- request or data flow
- key technologies and dependencies

### 3. Document important files

For each meaningful code file or module, write a short description with:

- relative path
- responsibility
- main logic, classes, functions, or flow

Prioritize:

- entry points
- core business logic
- configuration
- data loading and persistence
- API routes or handlers
- UI composition roots
- background jobs, scripts, or reporting pipelines

Do not waste space on trivial wrapper files unless they are important for navigation.

### 4. Write or update `README.md`

Create or refresh the root `README.md` with clean Markdown and concise sections.

Use this structure when it fits:

```markdown
# Project Name

## Overview

One or two paragraphs explaining what the project does and who it is for.

## Tech Stack

- Language / framework
- Key dependencies

## Architecture

Short explanation of the main modules and how they fit together.

### Data Flow

Short path from input to output.

## Directory Structure

```text
project-root/
|-- src/
|-- ...
`-- README.md
```

## File Guide

### path/to/file

- Responsibility: ...
- Main logic: ...

## Run Locally

Commands needed to install, start, test, or build the project.
```

## Writing principles

- Write for a new engineer, not for someone who already knows the repo.
- Prefer concrete responsibilities over vague descriptions.
- Keep each file description short.
- Keep the README synchronized with code changes that affect structure or behavior.
- Explain internal terminology briefly if needed.

## Avoid

Do not include:

- long API reference material copied from source
- changelog-style noise unless the user asked for it
- low-level implementation details that do not help navigation
- generated files unless they matter operationally

## Output standard

The finished README should make it easy for a human or another agent to answer:

1. What is this project?
2. Where does the main logic live?
3. How does data move through it?
4. How do I run it?
