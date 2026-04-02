---
name: scrapling-page-reader
description: Use Scrapling CLI to fetch a specific web page and read or extract its contents into `.md`, `.txt`, or `.html` output files. Trigger when the user asks to read a webpage, scrape page content, extract article/body text, save a page to markdown/text/html, or pull a specific page section with a CSS selector. Prefer this skill over MCP-based scraping when the task is a direct page-read or targeted single-page extraction workflow.
---

# Scrapling Page Reader

Use Scrapling's local CLI through the bundled wrapper script instead of starting the MCP server.

## Scope

Handle direct page-reading requests such as:

- Read the content from a URL
- Save a page as Markdown, text, or HTML
- Extract one page section with a CSS selector
- Escalate from static fetch to browser fetch when the page is dynamic

Do not use this skill for:

- Multi-page crawling
- Long interactive scraping sessions
- Running `scrapling mcp`
- Login-heavy flows that need persistent authenticated browser state

## Default workflow

1. Choose the narrowest extraction mode that fits:
   - Use `get` for normal static pages
   - Use `fetch` for JavaScript-rendered pages
   - Use `stealthy-fetch` only when anti-bot protection or stronger stealth is clearly needed
2. Choose the output format by the file extension:
   - `.md` for readable article/body content
   - `.txt` for plain text extraction
   - `.html` for preserved markup
3. Use `--css-selector` when the user asks for a specific element or content region.
4. Save to a concrete file path so the result can be inspected or reused.
5. After extraction, read the saved file if the user asked for the content itself rather than only creating an artifact.

## Preferred command path

Prefer the bundled wrapper:

```powershell
powershell -ExecutionPolicy Bypass -File .\skills\scrapling-page-reader\scripts\run_scrapling_extract.ps1 `
  -Url "https://example.com" `
  -OutputFile ".\tmp\example.md"
```

Use raw `scrapling extract ...` only when the wrapper does not expose a needed option.

## Wrapper behavior

The wrapper script:

- validates the output extension: `.md`, `.txt`, or `.html`
- maps `-Mode get|fetch|stealthy-fetch` to the correct Scrapling subcommand
- passes `-CssSelector`, `-WaitSelector`, `-Timeout`, `-WaitMs`, `-NoHeadless`, `-SolveCloudflare`, and repeated headers
- passes `-CssSelector`, `-WaitSelector`, `-Timeout`, `-WaitMs`, `-NoHeadless`, `-SolveCloudflare`, `-NoVerify`, and repeated headers
- creates the output directory if missing

## Decision rules

- Default to Markdown output for "read this page" style requests unless the user asked for another format.
- If the user says "just give me the text", prefer `.txt`.
- If the user asks for the raw page or DOM-preserving output, prefer `.html`.
- If a static `get` attempt is clearly insufficient because the content is JS-rendered, retry with `fetch`.
- If the user explicitly mentions Cloudflare, heavy bot protection, or previous browser-fetch failure on a protected page, use `stealthy-fetch` and consider `-SolveCloudflare`.

## Common examples

Read a normal article into Markdown:

```powershell
powershell -ExecutionPolicy Bypass -File .\skills\scrapling-page-reader\scripts\run_scrapling_extract.ps1 `
  -Url "https://example.com/blog/post" `
  -OutputFile ".\tmp\post.md"
```

Extract one section as plain text:

```powershell
powershell -ExecutionPolicy Bypass -File .\skills\scrapling-page-reader\scripts\run_scrapling_extract.ps1 `
  -Url "https://example.com" `
  -OutputFile ".\tmp\content.txt" `
  -CssSelector "#main-content"
```

Fetch a JS-rendered page and wait for the target element:

```powershell
powershell -ExecutionPolicy Bypass -File .\skills\scrapling-page-reader\scripts\run_scrapling_extract.ps1 `
  -Mode fetch `
  -Url "https://example.com/app" `
  -OutputFile ".\tmp\app.md" `
  -WaitSelector ".loaded" `
  -WaitMs 1500
```

Use stealthier browser fetching:

```powershell
powershell -ExecutionPolicy Bypass -File .\skills\scrapling-page-reader\scripts\run_scrapling_extract.ps1 `
  -Mode stealthy-fetch `
  -Url "https://protected.example.com" `
  -OutputFile ".\tmp\page.html" `
  -SolveCloudflare
```

Bypass SSL verification for a static fetch when the local certificate store is broken:

```powershell
powershell -ExecutionPolicy Bypass -File .\skills\scrapling-page-reader\scripts\run_scrapling_extract.ps1 `
  -Url "https://example.com" `
  -OutputFile ".\tmp\example.md" `
  -NoVerify
```

## Notes

- `scrapling shell` is available locally, but this skill is optimized for direct extraction rather than interactive exploration.
- The wrapper does not manage secrets. If a site needs cookies, headers, or a proxy, pass them explicitly and avoid exposing credentials unnecessarily.
- `-NoVerify` only applies to static `get` requests because that is what Scrapling's CLI exposes for SSL verification control.
