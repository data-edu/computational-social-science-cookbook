# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

This is a Quarto book: *Computational Analysis of Educational Data: A Field Guide Using R* (authors: Wei Wang, Mete Akcaoglu, Joshua Rosenberg, Shaun Kellogg). It covers text, network, numeric, and LLM-based analysis using R, aimed at computational social scientists.

## Build commands

```bash
# Render the full book to docs/
quarto render

# Preview with live reload
quarto preview

# Render a single chapter (preferred for quick checks)
quarto render chapter-1-3.qmd

# Render without executing code (fast layout check)
quarto render --no-execute

# Render to PDF (requires XeLaTeX / TinyTeX)
quarto render --to pdf
```

There are no linters or unit tests. Rendering a single `.qmd` is the equivalent of running a single test.

## Repository structure

- `_quarto.yml` — book configuration and output settings; defines chapter order
- `*.qmd` — chapters and section intros (the primary content files)
- `data/` — source datasets used in code examples; never write generated artifacts back here
- `styles/` — custom SCSS/CSS for the HTML theme
- `docs/` — rendered HTML/PDF output (committed); avoid editing directly

## R and Quarto conventions

- Use the native pipe `|>` for new code; `<-` for assignment
- Load packages with `library()` at the top of a chunk; use `pkg::fun()` for non-obvious or conflicting functions
- Prefer `readr::read_csv()` over base `read.csv()`
- Use relative paths from the project root (e.g., `data/file.csv`); never use `setwd()`
- Chunk options go on `#|` lines above the chunk body
- Label important chunks with `#| label:`; use `#| eval: false` for illustrative code
- Use `snake_case` for objects, columns, and file names; `p_` prefix for stored ggplot objects
- Set `set.seed()` in any chunk with randomness

## Editing guidelines

- Edit only the relevant `.qmd` file; avoid cross-file changes unless explicitly requested
- Do not delete or rewrite existing content without explicit instruction
- Do not touch files in `docs/` unless a render is explicitly requested
- Keep narrative text above the code chunk it explains
- New datasets belong in `data/`; large generated outputs go to `docs/` or a new `outputs/` directory
