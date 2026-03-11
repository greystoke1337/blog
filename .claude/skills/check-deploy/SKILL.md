---
name: check-deploy
description: Check GitHub Pages build and deployment status for the blog
allowed-tools:
  - Bash
---

# Check GitHub Pages Deployment

Verify the blog's deployment status on GitHub Pages.

## Steps

1. **Check git status** — confirm working tree is clean and up to date with remote:
   ```bash
   git status
   git log --oneline -1
   git rev-parse HEAD
   git ls-remote origin HEAD
   ```
   Compare local HEAD with remote HEAD to confirm latest changes are pushed.

2. **Check GitHub Pages build status** using gh CLI:
   ```bash
   gh api repos/greystoke1337/blog/pages/builds --jq '.[0] | {status, created_at, error: .error.message}'
   ```
   Report whether the latest build succeeded or failed, and when it ran.

3. **Check deployment URL** — confirm the site is reachable:
   ```bash
   curl -s -o /dev/null -w "%{http_code}" https://greystoke1337.github.io/blog/
   ```

## Output

Report:
- Local vs remote sync status
- Latest build status and timestamp
- Site HTTP status code
- Any errors or warnings
