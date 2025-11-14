<!-- .github/copilot-instructions.md - guidance for AI coding agents -->
# Repo snapshot

This repository is a student final report written in Typst. The primary artifact is a compiled PDF produced from `cee492_report.typ`. The repo contains the source (`.typ` files), bibliography (`refs.bib`), figures in `figures/`, and a GitHub Actions workflow that renders the PDF (`.github/workflows/build.yml`).

## What you're expected to know and do

- The project is NOT a typical codebase (no build system like npm/poetry). Your tasks will be about editing the Typst source, fixing formatting, updating references, or improving CI rendering.
- Primary files to inspect when making changes:
  - `cee492_report.typ` — the main Typst document (structure, sections, imports).
  - `Format.typ` — shared style or macros used by the document.
  - `refs.bib` — BibTeX-style bibliography the document references.
  - `figures/` — images included by the report.
  - `.github/workflows/build.yml` — shows how CI compiles the PDF using Typst.

## Build / test / debug commands (what actually works)

- Local preview (recommended): follow `README.md` steps — install the "Tinymist Typst" VS Code extension and open `cee492_report.typ`. Use the Typst preview command to live-preview edits.
- Local command-line compile (used in CI): `typst compile cee492_report.typ cee492_report.pdf` (CI runs this on Ubuntu via `typst-community/setup-typst@v4`).
- CI artifact: the generated PDF is uploaded as `cee 492 report pdf` (see `build.yml`). If asked to fix rendering issues, run the same `typst compile` locally or reproduce the CI image with an Ubuntu container that has Typst installed.

## Project-specific conventions and patterns

- Typography and layout are controlled through `Format.typ` and the `@preview/charged-ieee` package import seen at the top of `cee492_report.typ`.
- Authors, abstract, and index terms are set via the `ieee.with(...)` pattern — when adding metadata, follow this exact structure and types (arrays, tuples) to keep rendering consistent.
- Bibliography: entries live in `refs.bib` and are linked via `bibliography("refs.bib")` in the document header.
- Figures: images are stored in `figures/`; use relative paths when adding or updating images.

## Examples to reference in edits

- To change the title or authors, edit the `ieee.with(title: [...], authors: (...))` block in `cee492_report.typ`.
- To add a new bibliography entry, update `refs.bib` and then reference it in the Typst source where needed.
- To change rendering options or CI, update `.github/workflows/build.yml` (be cautious: the workflow expects `typst` on PATH via the setup action).

## What to avoid / assumptions

- Don't add heavy runtime code (no services, servers, or language runtimes are expected here).
- Avoid changing the repo layout unless explicitly asked — CI references specific filenames.

## Quick checklist for common tasks

1. Edit `cee492_report.typ` or `Format.typ`.
2. Preview locally in VS Code with the Tinymist Typst extension (see `README.md`).
3. Run `typst compile cee492_report.typ cee492_report.pdf` locally to reproduce CI.
4. Commit changes and push; CI will render the PDF and upload it as an artifact.

## If you need to escalate

- If a rendering error references a Typst package or missing asset, confirm `import` paths in `cee492_report.typ` and ensure images referenced from `figures/` exist.
- If CI fails due to Typst version differences, update the workflow action version or pin a compatible `typst` version in the workflow.

---
If anything here is unclear or you want me to include sample edits (title change, add a figure, add a bib entry), tell me which change to make and I'll apply it and run a local compile check.
