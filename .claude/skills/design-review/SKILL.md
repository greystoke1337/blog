---
name: design-review
description: Audit CSS changes against the blog's design system tokens, fonts, and responsive breakpoints
allowed-tools:
  - Read
  - Grep
  - Glob
---

# Design System Review

Audit CSS/layout changes against the established design system in `assets/css/style.scss`.

## Checks to Perform

### 1. Color Tokens
Search for hardcoded hex color values. All colors must use CSS custom properties:
- `--paper`, `--paper-dark`
- `--ink`, `--ink-mid`, `--ink-light`, `--ink-faint`
- `--orange`, `--orange-dim`, `--orange-pale`
- `--blue`, `--blue-pale`
- `--red`, `--rule`

Flag any raw hex values (e.g., `#fff`, `#333`) that should be replaced with a token.

### 2. Font Families
Only three font families are allowed:
- `'Barlow', sans-serif` — body text, paragraphs
- `'Barlow Condensed', sans-serif` — headings, labels, nav, titles
- `'IBM Plex Mono', monospace` — technical labels, dates, tags, code

Flag any other font-family declarations.

### 3. Responsive Behavior
Every new visual component must work at both breakpoints:
- **900px** (tablet): sidebars hidden, single-column layout, hamburger menu
- **600px** (phone): reduced padding/fonts, hidden gutters, 44px min touch targets

Check that new components have appropriate `@media` rules.

### 4. Naming Conventions
- Class names: lowercase, dash-separated (e.g., `.post-card-top`)
- No ID selectors for styling
- Utility classes follow existing pattern: `.mono`, `.condensed`, `.orange`, `.blue`

### 5. Spacing & Borders
- Structural dividers: `1px solid var(--ink-faint)`
- Standard padding patterns: `1rem 1.5rem` for content areas, `0.8rem 1rem` for compact areas
- Transitions: 0.1s–0.3s range

## Output

For each issue found, report:
- File and line number
- What's wrong
- Suggested fix using the correct token/convention
