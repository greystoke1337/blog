#!/bin/bash
# PreToolUse hook: validates frontmatter before writing to _posts/
# Reads tool input JSON from stdin

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Only validate files in _posts/
if [[ ! "$FILE_PATH" =~ _posts/.*\.md$ ]]; then
  exit 0
fi

CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty')
if [[ -z "$CONTENT" ]]; then
  exit 0
fi

ERRORS=""

# Check filename format: YYYY-MM-DD-slug.md
BASENAME=$(basename "$FILE_PATH")
if [[ ! "$BASENAME" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-[a-z0-9]([a-z0-9-]*[a-z0-9])?\.md$ ]]; then
  ERRORS="${ERRORS}Filename must match YYYY-MM-DD-slug.md (lowercase, hyphens only): $BASENAME\n"
fi

# Extract frontmatter (between --- markers)
FRONTMATTER=$(echo "$CONTENT" | sed -n '/^---$/,/^---$/p')

if [[ -z "$FRONTMATTER" ]]; then
  echo "ERROR: No YAML frontmatter found (must be between --- markers)" >&2
  exit 2
fi

# Check required fields
if ! echo "$FRONTMATTER" | grep -q '^layout:'; then
  ERRORS="${ERRORS}Missing 'layout' in frontmatter\n"
elif ! echo "$FRONTMATTER" | grep -q '^layout: post'; then
  ERRORS="${ERRORS}layout must be 'post'\n"
fi

if ! echo "$FRONTMATTER" | grep -q '^title:'; then
  ERRORS="${ERRORS}Missing 'title' in frontmatter\n"
elif ! echo "$FRONTMATTER" | grep -q '^title: ".*"'; then
  ERRORS="${ERRORS}title must be wrapped in double quotes\n"
fi

if ! echo "$FRONTMATTER" | grep -q '^date:'; then
  ERRORS="${ERRORS}Missing 'date' in frontmatter\n"
elif ! echo "$FRONTMATTER" | grep -qE '^date: [0-9]{4}-[0-9]{2}-[0-9]{2}$'; then
  ERRORS="${ERRORS}date must be YYYY-MM-DD format\n"
fi

if ! echo "$FRONTMATTER" | grep -q '^tags:'; then
  ERRORS="${ERRORS}Missing 'tags' in frontmatter\n"
elif ! echo "$FRONTMATTER" | grep -qE '^tags: \['; then
  ERRORS="${ERRORS}tags must use bracket array syntax: [Tag1, Tag2]\n"
fi

if [[ -n "$ERRORS" ]]; then
  echo "Post frontmatter validation failed:" >&2
  echo -e "$ERRORS" >&2
  exit 2
fi

exit 0
