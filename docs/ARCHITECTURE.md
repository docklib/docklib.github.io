# Architecture

Checked 2026-10-16.

## Components

- **This repo** — about 40 static HTML pages at the root (`index.html`, `Menu.html`, `Blog.html`, ...), `games/` (41 small launcher pages, 276 MB incl. some local swf/Unity files), `cover/` thumbnails, `images/`, `icons/`, shared JS and CSS (`scripts.js`, `styles.css`, `Global.js`, `GlobalSettings.js`, `cloak.json`), `sitemap.xml`, `robots.txt`, `ads.txt`. No build step. `service-worker.js` and `manifest.json` make it installable.
- **Docker image** — `nginx:alpine` with `nginx.conf` and the repo copied to `/var/www/html` (`.git`, `.kamal`, `config` removed). Health check: `/v1/health`.
- **Game assets (server only)** — `/srv/sz-games-assets` on themarzlibrary, filled by `scripts/sync-games.sh` (shallow clones of 31 public `github.com/sz-games/*` repos). Mounted read-only at `/var/www/games`. `/srv/themarzlibrary-assets` is also mounted at `/var/www/legacy_games` for old links. Pages in this repo link to paths like `/Games7/...`, `/home/...`, `/slope/...`, which nginx serves from these mounts.
- **Kamal** — `config/deploy.yml`, service `sz-games`, image `ghcr.io/senty-au/sz-games`, host `themarzlibrary`, proxy hosts `sz-games.com, www.sz-games.com`, `ssl: false` (Cloudflare terminates TLS).
- **Old GitHub Pages** — Pages is still on for `main` with CNAME `sz-games.com`, and `CNAME` and `_config.yml` are still in the repo. The live site is the Kamal one.

## Data flow

Browser → Cloudflare → Caddy / kamal-proxy on themarzlibrary → `sz-games-web` container (nginx) → page from the image, or game file from the mounted assets. Pages load Plausible, Google Analytics and AdSense scripts from third parties in the browser. There is no server code, database or login.

## Deploy flow

Push to `main` → GitHub Actions (`deploy.yml`) joins Tailscale as `tag:ci`, loads the SSH key, installs 1Password CLI and Kamal 2, runs `kamal deploy` (builds the image, pushes to GHCR, rolls the container), then curls `https://sz-games.com/` up to 5 times for a 200.

## External services

Cloudflare (DNS, proxy), GHCR, Tailscale, 1Password (vault TheMarzLibrary, item Production), GitHub (`sz-games/*` asset repos), Plausible, Google Analytics, AdSense, Firebase (web key in `Chat.html`).

## Environment and secrets (names only)

GitHub Actions secrets: `TAILSCALE_OAUTH_CLIENT_ID`, `TAILSCALE_OAUTH_SECRET`, `SSH_PRIVATE_KEY`, `OP_SERVICE_ACCOUNT_TOKEN`. Kamal: `KAMAL_REGISTRY_PASSWORD` (read from 1Password by `.kamal/secrets`). The site itself has no environment variables.
