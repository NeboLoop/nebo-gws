#!/usr/bin/env bash
set -euo pipefail

# Downloads gws release binaries and updates plugin.json with SHA256 hashes and sizes.
# Usage: ./build.sh [VERSION]
#   VERSION defaults to latest release tag from GitHub.

REPO="googleworkspace/cli"
DIST="dist"

# Platform mapping: nebo-platform → github-asset-suffix
declare -A PLATFORM_MAP=(
  ["darwin-arm64"]="aarch64-apple-darwin.tar.gz"
  ["darwin-amd64"]="x86_64-apple-darwin.tar.gz"
  ["linux-arm64"]="aarch64-unknown-linux-gnu.tar.gz"
  ["linux-amd64"]="x86_64-unknown-linux-gnu.tar.gz"
  ["windows-amd64"]="x86_64-pc-windows-msvc.zip"
)

# Resolve version
if [ -n "${1:-}" ]; then
  VERSION="$1"
else
  VERSION=$(gh release view --repo "$REPO" --json tagName -q '.tagName')
  echo "Resolved latest version: $VERSION"
fi

# Strip leading 'v' for plugin.json version
SEMVER="${VERSION#v}"

mkdir -p "$DIST"

echo "Downloading gws $VERSION for all platforms..."

for PLATFORM in "${!PLATFORM_MAP[@]}"; do
  SUFFIX="${PLATFORM_MAP[$PLATFORM]}"
  ASSET="google-workspace-cli-${SUFFIX}"
  OUT_DIR="$DIST/$PLATFORM"
  mkdir -p "$OUT_DIR"

  echo -n "  $PLATFORM... "

  # Download the archive
  gh release download "$VERSION" --repo "$REPO" --pattern "$ASSET" --dir "$DIST" --clobber

  # Extract binary
  if [[ "$ASSET" == *.zip ]]; then
    unzip -o -q "$DIST/$ASSET" -d "$DIST/tmp-$PLATFORM"
    mv "$DIST/tmp-$PLATFORM"/*/gws.exe "$OUT_DIR/gws.exe" 2>/dev/null || mv "$DIST/tmp-$PLATFORM"/gws.exe "$OUT_DIR/gws.exe"
    rm -rf "$DIST/tmp-$PLATFORM"
    BINARY="$OUT_DIR/gws.exe"
  else
    tar -xzf "$DIST/$ASSET" -C "$DIST/tmp-$$" --strip-components=1 2>/dev/null || {
      mkdir -p "$DIST/tmp-$$"
      tar -xzf "$DIST/$ASSET" -C "$DIST/tmp-$$"
      # Move from nested directory
      find "$DIST/tmp-$$" -name "gws" -type f -exec mv {} "$OUT_DIR/gws" \;
    }
    if [ -f "$DIST/tmp-$$/gws" ]; then
      mv "$DIST/tmp-$$/gws" "$OUT_DIR/gws"
    fi
    rm -rf "$DIST/tmp-$$"
    BINARY="$OUT_DIR/gws"
    chmod 755 "$BINARY"
  fi

  # Clean up archive
  rm -f "$DIST/$ASSET"

  # Compute SHA256
  SHA256=$(shasum -a 256 "$BINARY" | awk '{print $1}')
  SIZE=$(stat -f%z "$BINARY" 2>/dev/null || stat -c%s "$BINARY")

  echo "sha256=$SHA256 size=$SIZE"

  # Update plugin.json using jq
  BINARY_NAME=$(basename "$BINARY")
  jq --arg p "$PLATFORM" \
     --arg sha "$SHA256" \
     --arg size "$SIZE" \
     --arg bn "$BINARY_NAME" \
     --arg ver "$SEMVER" \
     '.version = $ver | .platforms[$p].sha256 = $sha | .platforms[$p].size = ($size | tonumber) | .platforms[$p].binaryName = $bn' \
     plugin.json > plugin.json.tmp && mv plugin.json.tmp plugin.json
done

echo ""
echo "Done. plugin.json updated with version $SEMVER."
echo "Binaries in $DIST/:"
ls -lR "$DIST"/
