---
globs:
  - "assets/css/**"
  - "_layouts/**"
---

# Design System Rules

When editing CSS or layouts, follow these conventions exactly.

## Color Tokens (use CSS custom properties only — never hardcode hex values)

```
--paper: #f8f6f2        --paper-dark: #f0ede7
--ink: #4a4a44           --ink-mid: #6e6e66
--ink-light: #a8a89e     --ink-faint: #dedad2
--orange: #c8622a        --orange-dim: #a84e20    --orange-pale: #faf0ea
--blue: #4a6a9e          --blue-pale: #edf1f8
--red: #b85050           --rule: #4a4a44
--gap: 1px
```

## Fonts (only these three families)

| Role | Font | Usage |
|------|------|-------|
| Body text | `'Barlow', sans-serif` | Default body, paragraphs, `.post-excerpt` |
| Headings/labels/nav | `'Barlow Condensed', sans-serif` | `.logo-name`, `.post-title`, `.main-title`, nav links, `.data-value` |
| Monospace/technical | `'IBM Plex Mono', monospace` | Labels, dates, tags, `.classbar`, `.data-label`, code blocks |

## Layout Grid

- `page-layout`: `grid-template-columns: 200px 1fr 200px` (sidebar | main | sidebar-right)
- `article-wrapper`: `grid-template-columns: 2rem 1fr 2rem` (margin | body | margin)
- `header-inner`: `grid-template-columns: auto 1fr auto` (logo | data | nav)
- `footer`: `grid-template-columns: 200px 1fr 200px`

## Responsive Breakpoints

**Tablet (max-width: 900px):**
- Grid collapses to single column
- Sidebars hidden, corner marks hidden
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
- Utility classes: `.mono`, `.condensed`, `.orange`, `.blue`, `.small`

## Border Convention

- Structural dividers: `1px solid var(--ink-faint)`
- Dotted separators: `1px dotted var(--ink-faint)` (readout rows)
- Active/hover states on tags: `border-color: var(--orange)`

## Visual Style

- Technical/blueprint aesthetic with paper grain background
- Registration marks and corner marks (decorative, orange at 40% opacity)
- Small-caps labels with wide letter-spacing (0.15em–0.3em)
- Transitions: 0.1s for hovers, 0.2s for menu animations, 0.3s for slideUp
