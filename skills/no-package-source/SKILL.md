---
name: no-package-source
description: Guide agents to avoid reading npm/pip package sources and to prefer public documentation or summaries when details are needed.
version: 1.0.0
agents: codex, claude-code, cursor, gemini-cli, opencode
---

# npm/pip Source Avoidance Guide

This skill captures the explicit rule the user set: *never open or paste the raw source of an npm or pip package when reasoning through a request.* Instead, defer to the package's published API, online documentation, changelog, or tutorial for details.

## Application Guide
- **Trigger:** When a request touches an npm/pip dependency and it looks like you would normally open files under 
ode_modules or inside Lib/site-packages.
- **Rule:** Do not read or paste the dependency's source tree. Search the web for the package's docs, API reference, official samples, or third-party guides. Use descriptions, code examples, or canonical comments from those sources instead of raw source dumps.
- **Fallback:** If no documentation is available, explain why accessing the package source without copying is still not allowed, and ask the user if you should interpret the API surface from the package metadata (e.g., published docs, type hints) instead.

## Recommended Process
1. Use a web search or existing documentation to learn the API or configuration you need.
2. When you must describe behavior, cite the documentation instead of quoting source files directly, and include links or references to the official docs when possible.
3. If the user explicitly insists on viewing package source, reiterate the policy, describe what you can find via docs, and offer to summarize that instead.

## Notes for Agents
- Keep the conversation focused on the publicly documented interface. Mention that this rule is global and persists across reasonings.
- Mention that failure to comply may trigger the skill again, so it should be the default stance when npm/pip packages are involved.
