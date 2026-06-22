---
name: structured-code-projects
description: Specialized skill for generating well-structured code projects. Use when user asks for AI-generated code projects, refactoring messy code, creating new apps/services, or any multi-file programming task. Emphasizes clean architecture, modular organization, and type-based categorization (business, data, research, temp, results etc.).
---

# Structured Code Projects

## Overview

This skill enforces **clean, scalable project structures** when generating or refactoring code. It prevents the common AI pitfall of dumping everything into one or few files/directories.

**Core Principle:** Always organize code by **type and responsibility**, not just by technology.

## When to Apply This Skill

- User requests any new code project (backend, frontend, fullstack, CLI, library, etc.)
- "Help structure my messy code"
- "Generate a project with proper folders"
- Any request involving multiple files or long-term maintainability

## Key Guidelines for Project Structure

### 1. Emphasize Categorization by Type (最重要原则)

**Always group by business/logical type first**, then by technical layers.

Recommended top-level categories (adapt based on project):

- **business/** or **src/business/** — Core business logic, modules by domain (users, orders, payments, etc.)
- **data/** — Data models, schemas, migrations, repositories, ETL scripts
- **research/** — Experimental code, prototypes, analysis notebooks, R&D
- **temp/** or **scripts/temp/** — Temporary test scripts, one-off experiments (clearly marked for deletion)
- **results/** or **outputs/** or **成果/** — Generated outputs, reports, final deliverables, artifacts
- **tests/** — Unit/integration tests
- **docs/** — Documentation
- **config/** — Configuration files
- **utils/** or **common/** — Shared utilities
- **api/** or **controllers/** — API endpoints (if applicable)
- **infrastructure/** or **deploy/** — Deployment, Docker, CI/CD

**Why this matters:**
- Different types have different lifecycles, review processes, and maintenance needs.
- Prevents pollution of main codebase.
- Makes it easy to archive research/temp without affecting production code.
- Improves team collaboration and onboarding.

### 2. Standard Layout Templates

#### Python Projects (Recommended)
```
project-name/
├── src/
│   ├── business/          # 业务逻辑
│   ├── data/              # 数据层
│   ├── api/               # 接口
│   └── utils/
├── tests/
├── research/              # 研究实验
├── temp/                  # 临时脚本
├── results/               # 成果输出
├── docs/
├── config/
├── pyproject.toml
├── README.md
├── .gitignore
└── requirements.txt
```

#### Node.js / TypeScript
Similar structure under `src/`, with `app/`, `modules/`, etc.

#### General Rules
- Use `src/` for source code in most languages.
- Separate concerns: presentation, business, data, infrastructure.
- Include always: README.md (with architecture diagram in text), .gitignore, setup instructions.
- Name directories in English primarily, with Chinese comments where helpful.

## Generation Workflow

1. **First Response**: Output project tree (`tree` format) + brief explanation of categories.
2. Ask for confirmation/adjustments on structure.
3. **Then generate files** one directory at a time or with clear separation.
4. Always create `README.md` explaining the structure.
5. For large projects, prioritize core modules first.

## Best Practices

- **Modularity**: Each business domain in its own subdirectory.
- **Clear Naming**: `business/user_management/` instead of flat files.
- **Documentation**: Every major directory gets a README.md.
- **Tests**: Mirror the structure of src/.
- **Avoid Monoliths**: No "all code in main.py/app.js".

When user provides messy code, first propose a refactored structure, then migrate files accordingly.

This skill ensures all generated projects are production-ready and maintainable.