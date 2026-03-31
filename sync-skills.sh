#!/usr/bin/env bash
set -euo pipefail

# Syncs skills from the upstream googleworkspace/cli repo at a given release tag.
# Usage: ./sync-skills.sh [VERSION]
#   VERSION defaults to latest release tag from GitHub.

REPO="googleworkspace/cli"
SKILLS_DIR="skills"
TMP_TAR="/tmp/gws-skills-$$.tar.gz"
TMP_EXTRACT="/tmp/gws-skills-extract-$$"

# Resolve version
if [ -n "${1:-}" ]; then
  VERSION="$1"
else
  VERSION=$(gh release view --repo "$REPO" --json tagName -q '.tagName')
  echo "Resolved latest version: $VERSION"
fi

echo "Syncing skills from $REPO @ $VERSION..."

# Download tarball for the release tag
gh api "repos/$REPO/tarball/$VERSION" > "$TMP_TAR"

# Find the top-level directory name inside the tarball (github prefixes it)
TOP_DIR=$(tar -tzf "$TMP_TAR" | head -1 | cut -d/ -f1)

# Extract only the skills/ directory
mkdir -p "$TMP_EXTRACT"
tar -xzf "$TMP_TAR" -C "$TMP_EXTRACT" "$TOP_DIR/skills/"

# Replace local skills directory
rm -rf "$SKILLS_DIR"
mv "$TMP_EXTRACT/$TOP_DIR/skills" "$SKILLS_DIR"

# Clean up
rm -f "$TMP_TAR"
rm -rf "$TMP_EXTRACT"

# Inject triggers from triggers.json into skill frontmatter
TRIGGERS_FILE="triggers.json"
if [ -f "$TRIGGERS_FILE" ]; then
  echo "Injecting triggers..."
  injected=0
  for skill_dir in "$SKILLS_DIR"/*/; do
    skill_name=$(basename "$skill_dir")
    skill_file="$skill_dir/SKILL.md"
    [ -f "$skill_file" ] || continue

    # Get triggers array for this skill; skip if none defined
    triggers=$(jq -r --arg name "$skill_name" '
      .[$name] // empty | .[] | "  - " + .
    ' "$TRIGGERS_FILE" 2>/dev/null) || true
    [ -z "$triggers" ] && continue

    # Write triggers block to a temp file (avoids awk newline issues)
    block_file=$(mktemp)
    printf "triggers:\n%s\n" "$triggers" > "$block_file"

    # Insert triggers block before the closing --- of the frontmatter
    awk -v bfile="$block_file" '
      BEGIN { first_marker=0 }
      /^---[[:space:]]*$/ {
        if (first_marker == 0) {
          first_marker = 1
          print
          next
        }
        while ((getline line < bfile) > 0) print line
        close(bfile)
        print
        first_marker = 2
        next
      }
      { print }
    ' "$skill_file" > "${skill_file}.tmp" && mv "${skill_file}.tmp" "$skill_file"
    rm -f "$block_file"
    injected=$((injected + 1))
  done
  echo "Injected triggers into $injected skills."
else
  echo "No triggers.json found — skipping trigger injection."
fi

SKILL_COUNT=$(find "$SKILLS_DIR" -name "SKILL.md" | wc -l | tr -d ' ')
echo "Done. Synced $SKILL_COUNT skills into ./$SKILLS_DIR/"
