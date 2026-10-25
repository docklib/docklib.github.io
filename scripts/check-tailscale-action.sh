#!/usr/bin/env bash
# Fail when the deploy workflow would use a Tailscale client older than 1.46.
#
# Tailscale 1.42 (the default of tailscale/github-action@v2) refuses an OAuth
# client key unless TS_EXPERIMENT_OAUTH_AUTHKEY is set. The action runs
# `sudo -E tailscale up`, and the sudo on GitHub-hosted ubuntu-latest drops the
# variable, so the step fails with "oauth authkeys are in experimental status".
# Tailscale 1.46 removed that guard.
set -euo pipefail

workflow="${1:-.github/workflows/deploy.yml}"
minimum="1.46.0"

if [[ ! -f "$workflow" ]]; then
  echo "fail: workflow not found: $workflow" >&2
  exit 1
fi

uses_line=$(grep -n -m1 -E '^[[:space:]]*uses:[[:space:]]*tailscale/github-action@' "$workflow" || true)
if [[ -z "$uses_line" ]]; then
  echo "fail: no tailscale/github-action step in $workflow" >&2
  exit 1
fi

line_no=${uses_line%%:*}
ref=${uses_line#*@}
ref=${ref%%[[:space:]]*}
ref=${ref//[\"\']/}
action_major=""
if [[ "$ref" =~ ^v?([0-9]+)(\.|$) ]]; then
  action_major="${BASH_REMATCH[1]}"
fi

# Read the step's version input, stopping at the next step.
version=$(awk -v start="$line_no" '
  NR <= start { next }
  /^[[:space:]]*-[[:space:]]+name:/ { exit }
  /^[[:space:]]*version:[[:space:]]*/ {
    sub(/^[[:space:]]*version:[[:space:]]*/, "")
    gsub(/["'\'' ]/, "")
    print
    exit
  }
' "$workflow")

is_at_least() {
  [[ "$(printf '%s\n%s\n' "$minimum" "$1" | sort -V | head -n1)" == "$minimum" ]]
}

if [[ "$version" == "latest" || "$version" == "unstable" ]]; then
  echo "ok: action $ref uses Tailscale $version"
  exit 0
fi

if [[ -n "$version" ]]; then
  version="${version#v}"
  if is_at_least "$version"; then
    echo "ok: action $ref pins Tailscale $version"
    exit 0
  fi
  echo "fail: action $ref pins Tailscale $version; need $minimum or newer so OAuth keys work without TS_EXPERIMENT_OAUTH_AUTHKEY" >&2
  exit 1
fi

if [[ -n "$action_major" && "$action_major" -ge 3 ]]; then
  echo "ok: action $ref defaults to Tailscale 1.82.0 or newer"
  exit 0
fi

echo "fail: action $ref defaults to a Tailscale client older than $minimum; set version: $minimum or newer, or move to tailscale/github-action@v4" >&2
exit 1
