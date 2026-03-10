# Greystoke's Blog

Personal project blog built with Jekyll and GitHub Pages.

**Live at:** https://greystoke1337.github.io/blog/

## Structure

```
_config.yml          # Jekyll configuration (minima theme)
Gemfile              # Ruby dependencies (github-pages gem)
index.md             # Home page (post listing)
about.md             # About page
_posts/              # Blog posts (markdown)
editor.html          # WYSIWYG post editor (local tool, excluded from build)
```

## Writing posts

Open `editor.html` in a browser. It provides a WYSIWYG editor that publishes posts directly to this repo via the GitHub API.

**Setup (one-time):** Click Settings and paste a GitHub Personal Access Token with `repo` scope.

**Features:**
- Rich text editing with formatting toolbar (headings, bold, italic, lists, links, code blocks)
- Image upload via drag & drop, file picker, or clipboard paste (committed to `assets/images/`)
- Auto-generates Jekyll front matter and filename from title + date
- Keyboard shortcuts: Ctrl+B (bold), Ctrl+I (italic), Ctrl+K (link)
- Publishes as clean markdown to `_posts/`

## Manual posts

Create a file in `_posts/` named `YYYY-MM-DD-slug.md`:

```markdown
---
layout: post
title: "Post Title"
date: YYYY-MM-DD
---

Post content in markdown.
```

Push to `main` — GitHub Pages builds and deploys automatically (~60s).
