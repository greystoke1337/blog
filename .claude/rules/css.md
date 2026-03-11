---
globs:
  - "assets/css/**"
  - "_layouts/**"
---

# Design System Rules

Based on the NASA Graphics Standards Manual (NHB 1430.2, Jan 1976). When editing CSS or layouts, follow these conventions exactly.

## Color Tokens (use CSS custom properties only — never hardcode hex values)

```
--paper: #f8f6f2        --paper-dark: #f0ede7
--ink: #4a4a44           --ink-mid: #6e6e66
--ink-light: #a8a89e     --ink-faint: #dedad2
--nasa-red: #E84528      --nasa-red-dim: #C73A22   --nasa-red-pale: #FDF0ED
--nasa-blue: #105EA0     --nasa-blue-pale: #EAF0F8
--nasa-gray: #8B8B83     --rule: #4a4a44
--gap: 1px
```

NASA Red must only appear on white or light value backgrounds (per NHB 1430.2 p.8).

## Fonts (only these three families)

| Role | Font | Usage |
|------|------|-------|
| Body text (weight 300) | `'Barlow', sans-serif` | Default body, paragraphs, `.post-excerpt` |
| Headings/labels/nav (weight 500) | `'Barlow Condensed', sans-serif` | `.logo-name`, `.post-title`, `.main-title`, nav links, `.data-value` |
| Monospace/technical | `'IBM Plex Mono', monospace` | Labels, dates, tags, `.data-label`, code blocks |

## Layout Grid

- `page-layout`: `grid-template-columns: 200px 1fr 200px` (sidebar | main | sidebar-right)
- `article-wrapper`: `grid-template-columns: 2rem 1fr 2rem` (margin | body | margin)
- `header-inner`: `grid-template-columns: auto 1fr auto` (logo | data | nav)
- `footer`: `grid-template-columns: 200px 1fr 200px`

## Responsive Breakpoints

**Tablet (max-width: 900px):**
- Grid collapses to single column
- Sidebars hidden
- Header data hidden, hamburger menu shown
- Nav becomes vertical dropdown
- Article margins removed

**Phone (max-width: 600px):**
- Smaller logo (1.5rem), article title (1.8rem)
- Post gutters/numbers hidden
- Reduced padding throughout
- 44px minimum touch targets on interactive elements
- `overflow-wrap: break-word` on article body

## Naming Conventions

- Lowercase, dash-separated class names (e.g., `.post-card-top`, `.article-margin-left`)
- No IDs for styling
- Utility classes: `.mono`, `.condensed`, `.nasa-red`, `.nasa-blue`, `.small`

## Border Convention

- Structural dividers: `1px solid var(--ink-faint)`
- Dotted separators: `1px dotted var(--ink-faint)` (readout rows)
- Active/hover states on tags: `border-color: var(--nasa-red)`

## Visual Style

- NASA-inspired clean aesthetic with paper grain background
- Blue identity stripe (4px) at top and bottom of page (per vehicle markings, NHB 1430.2 p.47-56)
- No artificial embellishment: no corner marks, no decorative borders, no registration marks (per signage rules, NHB 1430.2 p.45)
- Logo stands free with no enclosing shapes (per logotype rules, NHB 1430.2 p.10)
- Small-caps labels with wide letter-spacing (0.15em-0.3em)
- Flush left, ragged right text alignment throughout
- Transitions: 0.1s for hovers, 0.2s for menu animations
