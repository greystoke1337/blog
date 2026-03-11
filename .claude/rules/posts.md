---
globs:
  - "_posts/**"
---

# Blog Post Conventions

## Frontmatter Format (exact format required)

```yaml
---
layout: post
title: "Post Title Here"
date: YYYY-MM-DD
tags: [Tag1, Tag2, Tag3]
---
```

- `layout` must be `post`
- `title` must be in double quotes
- `date` must be YYYY-MM-DD (no time component)
- `tags` must be a YAML array with bracket syntax `[Tag1, Tag2]`

## File Naming

- Pattern: `_posts/YYYY-MM-DD-slug.md`
- Slug: lowercase, hyphens only, no trailing hyphens, no special characters
- Date in filename must match frontmatter `date`

## Image Paths

Use the baseurl prefix: `/blog/assets/images/filename.jpg`

```markdown
![Alt text describing the image](/blog/assets/images/my-image.jpg)
```

## Heading Hierarchy

- **No h1 in post body** — the layout adds h1 from the `title` frontmatter
- Use h2 (`##`) for major sections
- Use h3 (`###`) for subsections
- Never skip levels (no h2 → h4)

## Content Style

- Technical, concise, project-focused tone
- Read time is calculated as `(word_count / 200) + 1` minutes
- Excerpts auto-truncated to 200 chars on the home page
- Links use standard Markdown: `[text](url)`

## Reference Example

See `_posts/2026-03-10-overhead-tracker.md` as the canonical post format.
