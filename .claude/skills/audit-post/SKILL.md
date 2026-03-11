---
name: audit-post
description: Run SEO, accessibility, and content quality checks on a blog post
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Blog Post Audit

Run quality checks on a blog post. If no file is specified, audit the most recently modified post in `_posts/`.

## Checks

### SEO
- **Title length**: Should be under 60 characters (for search result display)
- **Description/excerpt**: First paragraph should work as a compelling excerpt (auto-truncated to 200 chars on home page)
- **Internal links**: Post should link to other posts or site pages where relevant
- **Frontmatter completeness**: `layout`, `title`, `date`, `tags` all present

### Accessibility
- **Image alt text**: Every `![...]()` must have descriptive alt text (not empty `![]()`)
- **Heading hierarchy**: Must use h2 for sections, h3 for subsections, never skip levels, no h1 in body
- **Link text**: No generic "click here" or "link" — link text should describe the destination

### Content Quality
- **Broken image paths**: Verify every referenced image in `assets/images/` actually exists
- **Broken relative links**: Check internal links point to valid paths
- **Long paragraphs**: Flag paragraphs over 150 words (suggest breaking up)
- **Missing sections**: A good post typically has an intro, at least one h2 section, and a conclusion or summary

### Frontmatter Validation
- `layout` is `post`
- `title` is in double quotes
- `date` is valid YYYY-MM-DD
- `tags` is bracket array syntax `[Tag1, Tag2]`
- Date in filename matches frontmatter date

## Output

Report findings grouped by category (SEO / Accessibility / Content / Frontmatter) with specific line numbers and suggestions.
