#!/bin/bash
# PostToolUse hook: warns about large images after writing to assets/images/
# Reads tool input JSON from stdin

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Only check files in assets/images/
if [[ ! "$FILE_PATH" =~ assets/images/ ]]; then
  exit 0
fi

# Check if file exists and get size
if [[ -f "$FILE_PATH" ]]; then
  SIZE=$(stat -f%z "$FILE_PATH" 2>/dev/null || stat -c%s "$FILE_PATH" 2>/dev/null)
  if [[ -n "$SIZE" ]] && [[ "$SIZE" -gt 512000 ]]; then
    SIZE_KB=$((SIZE / 1024))
    echo "Warning: Image is ${SIZE_KB}KB. Consider compressing to under 500KB for faster page loads."
    echo "Tools: TinyPNG (tinypng.com), ImageOptim, or 'sips --resampleWidth 1200 \"$FILE_PATH\"' on macOS."
  fi
fi

exit 0
