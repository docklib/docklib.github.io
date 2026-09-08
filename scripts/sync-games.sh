#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-/srv/sz-games-assets}"
mkdir -p "$TARGET_DIR"

REPOS=(
  "home"
  "slope"
  "storage"
  "storage3"
  "fs"
  "cr"
  "MoreGames"
  "gfile"
  "games3"
  "gdata"
  "Games"
  "FlashGames"
  "Games2"
  "Games4"
  "Games5"
  "Games6"
  "Games7"
  "Tools"
  "notmine"
  "Games8"
  "mule-clone"
  "Games9"
  "Games10"
  "Games-2"
  "FNFSTUFF"
  "RetroGames"
  "Run3"
  "Games11"
  "pacman"
  "uv"
  "anuraOS"
)

TOTAL=${#REPOS[@]}
COUNT=0

echo "=== Syncing sz-games repositories into: $TARGET_DIR ==="
for repo in "${REPOS[@]}"; do
  COUNT=$((COUNT + 1))
  DEST="$TARGET_DIR/$repo"
  echo "[$COUNT/$TOTAL] Syncing $repo..."
  if [ -d "$DEST/.git" ]; then
    echo "  Directory exists, pulling latest changes..."
    git -C "$DEST" pull --depth=1 --quiet || echo "  Warning: pull failed for $repo, skipping."
  else
    echo "  Cloning shallow copy..."
    git clone --depth=1 --quiet "https://github.com/sz-games/$repo.git" "$DEST" || echo "  Warning: clone failed for $repo, skipping."
  fi
done

echo "=== All $TOTAL repositories synced into $TARGET_DIR ==="
