---
name: new-post
description: Create a new Jekyll blog post with correct frontmatter and file naming
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - AskUserQuestion
---

# Create New Blog Post

Create a new blog post for the Jekyll blog.

## Steps

1. **Ask the user** for:
   - Post title
   - Tags (suggest existing tags from other posts if relevant)

2. **Generate the file:**
   - Date: today's date in YYYY-MM-DD format
   - Slug: derive from title — lowercase, replace spaces with hyphens, remove special characters, no trailing hyphens
   - Filename: `_posts/YYYY-MM-DD-slug.md`

3. **Check the file doesn't already exist** using Glob on `_posts/`

4. **Write the file** with this exact frontmatter format:
   ```yaml
   ---
   layout: post
   title: "The Post Title"
   date: YYYY-MM-DD
   tags: [Tag1, Tag2]
   ---
   ```

5. **Add a starter heading** — one `## ` section heading to get the user started

## Reference

Use `_posts/2026-03-10-overhead-tracker.md` as the canonical example of correct post format.

## Rules

- Title must be in double quotes in frontmatter
- Tags use bracket array syntax: `[Tag1, Tag2]`
- Date in filename must match frontmatter date
- No h1 in post body (layout adds it from title)
- Image paths use baseurl: `/blog/assets/images/filename.jpg`
