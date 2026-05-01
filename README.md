# Computational Analysis of Educational Data: A Field Guide Using R

This repository contains the source for a Quarto book on computational methods for educational research.

## What this project is

- A multi-chapter Quarto book (`.qmd`) built with R
- Rendered website and PDF outputs committed under `docs/`
- Reproducible chapter workflows for text, network, numeric, and LLM-supported methods

## Repository layout

- `_quarto.yml` - book configuration, chapter order, output settings
- `chapter-*.qmd` - chapter source files
- `section-*-Intro.qmd` - part introduction pages
- `index.qmd` - preface/front page
- `conclusion.qmd`, `colophon.qmd`, `references.qmd` - back matter
- `references.bib`, `apa.csl` - bibliography and citation style
- `data/` - source datasets and static images used in chapters
- `styles/` - custom theme/style overrides
- `docs/` - rendered site and PDF for GitHub Pages
- `Artwork/` - figure/table inventory and naming-tracking CSV files

## Build and preview

Build full book:

```bash
quarto render
```

Preview with live reload:

```bash
quarto preview
```

Render without executing code chunks (fast layout check):

```bash
quarto render --no-execute
```

Render one chapter:

```bash
quarto render chapter-1.qmd
```

Render PDF output:

```bash
quarto render --to pdf
```

## Authoring conventions

- Use relative paths (e.g., `data/...`) and do not use `setwd()`
- Prefer tidyverse-style R code and native pipe `|>`
- Use Quarto chunk options with `#|` syntax
- Keep narrative context above code chunks
- Keep rendered outputs in `docs/` for publication

## Publishing

The book is published from this repository via GitHub Pages using files in `docs/`.

Typical publish flow:

1. Edit `.qmd` source files
2. Run `quarto render`
3. Commit source + updated `docs/`
4. Push to `main`

## Notes for collaborators

- No dedicated unit test suite is configured; render checks are the main validation.
- Internal/private review notes should stay local and not be committed.
