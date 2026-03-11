# Claude Code Instructions

## Project Overview

Personal blog built with Jekyll + GitHub Pages.
Live at: https://greystoke1337.github.io/blog/

## Repository Layout

```
_config.yml          # Jekyll config (minima theme, site metadata)
Gemfile              # github-pages gem + plugins
index.md             # Home page (uses Jekyll home layout)
about.md             # About page
_posts/              # Blog posts (YYYY-MM-DD-slug.md)
_includes/           # Jekyll includes (custom-head.html for favicon)
editor.html          # WYSIWYG post editor (local tool, excluded from Jekyll build)
assets/images/       # Uploaded images (committed via editor)
favicon.ico          # Favicon files (ico, png, apple-touch-icon)
```

## Branch Policy

Push directly to **`main`**. No feature branches.
Pushes to `main` auto-deploy to GitHub Pages.

## Key Details

- **Theme:** minima (Jekyll default)
- **No build step:** GitHub Pages builds Jekyll automatically
- **editor.html** is a standalone WYSIWYG tool — opens via `file://`, uses GitHub API to commit posts and images. Excluded from Jekyll build via `_config.yml`.
- **Favicon** is served via `_includes/custom-head.html` (minima auto-includes this). Favicon files live in the repo root.
- **GitHub CLI** is installed at `/c/Program Files/GitHub CLI/gh.exe` (not on bash PATH)

## Code Style

- No frameworks — vanilla HTML/JS only
- Single-file tools preferred (editor.html is self-contained)
- Minimal design, clean typography
