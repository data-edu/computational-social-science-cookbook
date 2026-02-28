# Agent Guide: Computational Social Science Cookbook

This repository is a Quarto book written in R/Quarto (.qmd). These notes are for
agentic coding tools working in this repo.

## Project layout
- `_quarto.yml` defines the book and output settings.
- `*.qmd` are chapters and section intros.
- `data/` contains source datasets used in examples.
- `styles/` holds custom SCSS/CSS for the book theme.
- `docs/` is the rendered HTML/PDF output directory.

## Build / lint / test commands

### Build the full book
- `quarto render`
  - Renders all chapters listed in `_quarto.yml` to `docs/`.

### Preview with live reload
- `quarto preview`
  - Starts a local preview server and re-renders on changes.

### Render a single chapter (acts like a single test)
- `quarto render chapter-1-3.qmd`
  - Renders only that file to `docs/`.
- `quarto render section-2-Intro.qmd`
  - Same pattern for any `.qmd`.

### Render without executing code
- `quarto render --no-execute`
  - Useful for quick layout checks if code execution is slow.

### PDF output
- `quarto render --to pdf`
  - Uses XeLaTeX as configured in `_quarto.yml`.
  - Requires a LaTeX install (TinyTeX is fine).

### Lint / tests
- No linter or test runner is configured in this repo.
- There are no unit tests; “single test” = render a single `.qmd`.

## Cursor / Copilot rules
- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md` were found.

## Code style guidelines

### Quarto structure
- Each chapter/section has YAML front matter with at least `title` and `format`.
- Use Quarto chunk options with `#|` lines above the chunk body.
- Keep narrative text above the code it explains.
- Use relative paths (e.g., `data/...`) and never `setwd()`.

### R style (general)
- Prefer tidyverse-friendly code and readable pipelines.
- Use the native pipe `|>` for new code unless a package requires `%>%`.
- Use `<-` for assignment, not `=`.
- Use `snake_case` for objects, columns, and file names.
- Keep functions and pipelines short; break long pipes across lines.

### Imports / packages
- Load packages explicitly at the top of a script or chunk with `library()`.
- Avoid `require()` and `attach()`.
- Prefer `readr::read_csv()` or `readr::read_tsv()` over base `read.csv()`.
- If a function is non-obvious or conflicts are likely, use `pkg::fun()`.

### Formatting
- Use 2 spaces of indentation in R and YAML.
- Keep line lengths reasonable (~80-100 chars) in prose and code.
- Use blank lines to separate logical blocks (data load, transform, plot).

### Naming conventions
- Data frames: nouns, `snake_case` (e.g., `student_scores`).
- Logical flags: `is_` or `has_` prefixes (e.g., `is_passed`).
- Temporary objects: keep scoped and re-use meaningful names.
- Plot objects: `p_` prefix if stored (e.g., `p_outcomes`).

### Data handling
- Store datasets under `data/` and use relative paths in code chunks.
- Do not write generated artifacts back into `data/`.
- Large outputs should go to `docs/` or a new `outputs/` directory.

### Plotting (ggplot2)
- Build plots with clear labels (`labs(title=, x=, y=)`), and add captions
  when a plot appears in the narrative.
- Prefer `theme_minimal()` or existing styles unless the chapter already
  specifies a different look.

### Error handling and reproducibility
- Use `stop()` with a clear message for invalid inputs in scripts.
- Use `na.rm = TRUE` for summaries where missing data is expected.
- Set seeds (`set.seed(...)`) in chunks that include randomness.
- Avoid side effects in chunks unless the chapter explicitly explains them.

### Chunk options and execution
- Use `#| message: false` and `#| warning: false` where output is noisy.
- Label important chunks with `#| label:` to make errors traceable.
- Use `#| eval: false` for illustrative code that should not run.

## Output and docs
- Rendered HTML/PDF is committed under `docs/`.
- Keep assets referenced by chapters alongside the chapter or in `data/`.

## Git hygiene
- Do not delete or rewrite existing content without explicit instruction.
- Avoid touching files in `docs/` unless a render is requested.

## Quick sanity checklist for edits
- Update the relevant `.qmd` chapter only; avoid cross-file changes.
- Run `quarto render <chapter>.qmd` if you need to validate output.
- Confirm all new file paths are relative and within the repo.
