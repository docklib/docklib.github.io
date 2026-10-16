# docklib.github.io (serves sz-games.com)

Unblocked-games portal for school students: 250+ games, retro and emulators, tab cloaking, panic button. The repo is named `docklib` but it deploys **sz-games.com**. It is a separate site from `sz-games/sz-games.github.io` (only the games are shared). Facts below were checked on 2026-10-16. Full audit: `docs/AUDIT-2026-10.md`.

| | |
|---|---|
| Live URLs | https://sz-games.com (www redirects here). `docklib.github.io` redirects to it too (stale GitHub Pages config, see PROPOSALS) |
| Stack | Static HTML/CSS/vanilla JS, no build step. `nginx:alpine` in Docker |
| Runs on | Kamal service `sz-games`, container `sz-games-web-*` on host `themarzlibrary` (Netcup VPS), 64 MB limit. Cloudflare in front, then Caddy/kamal-proxy |
| Deploys | `.github/workflows/deploy.yml` on every push to `main` (and manual run): Tailscale, then `kamal deploy`, then a smoke test of `https://sz-games.com/` |
| Config | `config/deploy.yml`, `Dockerfile`, `nginx.conf`. Registry password comes from 1Password via `.kamal/secrets` (reference only, no value in git) |
| Game files | Not in this repo. 31 `sz-games/*` repos are cloned by `scripts/sync-games.sh` into `/srv/sz-games-assets` on the host and mounted read-only at `/var/www/games` |
| Analytics and ads | Plausible (`data-domain="sz-games.com"`), Google Analytics `G-C78TXR0XFK`, AdSense `ca-pub-3723218062742398`, ads.txt in repo. my-seo: no property id is recorded for this site yet |
| Backups | Repo holds the site (git). `/srv/sz-games-assets` is in the `sz-games` job of `senty-backup` on themarzlibrary (restic). No database. Restore not recorded as tested |
| Owner | rus (deploy and server). Original site by Bobby |

## Run locally

```
python3 -m http.server 8000      # pages and links only; games need /var/www/games from the server
docker build -t sz-games . && docker run -p 8080:80 sz-games
```

## More docs

- `docs/ARCHITECTURE.md` how it fits together
- `docs/CHANGELOG-TECH.md` technical changes with dates
- `docs/PROPOSALS.md` open upgrades and cleanups
- `docs/AUDIT-2026-10.md` the October 2026 audit report

---

<p align="center">
 
  <img src="https://sz-games.com/G-Google.png" width="150px" height="150px">

</p>

<h1 align="center">Sz Games</h1>
<p align="center">The Best Way To Play Game's In School</p>
<p align="Center">This Site Was Made By Me (Bobby)</p>
<a href="https://discord.gg/DzKRSntb87"><img height="30px"  src="https://img.shields.io/badge/Join%20The%20Discord!-brightgreen?style=for-the-badge&logo=discord&logoColor=white&labelColor=%233f4bd1&color=%235865F2"></a>




<h1 align="center">Features</h1>

- **250+ Games**
- **Retro Games**
- **Emulators**
- **10+ Roblox Servers**

- **Tab Cloaking**
- **Prevent Page Close**
- **About:Blank Embeder**
- **Panic Button**
- **Proxies (Testing)**

- **Doesnt Have A Thousand Ads On Every Page**

<h1 align="Center">Instructions To Host Your Own</h1>
<p align="center">You Can Fork This Repo and Host Your Own But You Need To Include The Following</p>

- **Link To The Original Site**
- **Credits**

<p align="center">Do Not Do The Following</p>

- **Rebrand The Site**


<h1 align="center">Other Stuff</h1>

<a href="https://chromewebstore.google.com/detail/sz-games-portable/hbclpfdbinpmdgcglhmkngpabafdeaim"><img height="30px" src="https://img.shields.io/badge/Download%20The%20Extension-white?style=for-the-badge&logo=chromewebstore&logoColor=white&logoSize=auto&labelColor=%232d2d2d&color=%232d2d2d"></a>

<a href="https://addons.mozilla.org/en-US/firefox/addon/sz-games-portable/"><img height="30px" src="https://img.shields.io/badge/Download%20The%20Addon-white?style=for-the-badge&logo=firefoxbrowser&logoColor=white&logoSize=auto&color=%23FF7139"></a>








