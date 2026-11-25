#!/usr/bin/env bash
set -u
bad=$(grep -rnoiE --include='*.html' '<script[^>]*unpkg\.com/@ruffle-rs/ruffle[^>]*>' . | grep -viE '<script[^>]*[[:space:]]defer[[:space:]>]' || true)
if [ -n "$bad" ]; then
  echo "ruffle script tag without defer:"
  echo "$bad"
  exit 1
fi
echo "all ruffle script tags have defer"
