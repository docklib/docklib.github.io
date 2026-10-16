# Proposals

Checked 2026-10-16. Nothing here is done. Effort is for one person.

| # | Item | Gain | Effort | Risk |
|---|---|---|---|---|
| 1 | **Restrict or retire the Firebase web key in `Chat.html`** (GitHub secret-scanning alert 1, open, `google_api_key`). It is a browser key, but anyone can use it. | Closes the alert; stops quota abuse | Low (restrict by referrer in Google console; rus) | Chat breaks if restricted wrongly |
| 2 | **Turn off the old GitHub Pages build**, then delete `CNAME` and `_config.yml`. Pages still holds `sz-games.com` and `docklib.github.io` redirects there. | One deploy path; no stale CNAME | Low (rus: Pages setting) | Check DNS first |
| 3 | **Update Actions**: checkout v4→v7, tailscale v2→v4, install-cli v1→v4, setup-buildx v3→v4, ssh-agent 0.9→0.10. | Node 20 warnings gone | Low | A deploy run is the only test. Not done here because it cannot be tested without deploying |
| 4 | **Pin `nginx:alpine`** to a version (for example `nginx:1.30-alpine`). | Repeatable builds | Low | Low |
| 5 | **Cache headers**: `Cache-Control: no-cache, no-store` is sent on pages; static games and images could be cached. | Faster repeat visits, less origin load | Low | Stale files after a deploy |
| 6 | **Record the my-seo property** (Search Console and GA4 ids) for this site and add annotations for the Kamal move on 2026-09-08. | Traffic changes can be traced | Low | None |
| 7 | **Run a restore test** of `/srv/sz-games-assets` (or just run `sync-games.sh`, which rebuilds it from public repos). | Proves the backup | Low | None |
| 8 | **Weight**: repo is ~294 MB with 276 MB in `games/`. Move big swf/Unity files to the assets volume. | Faster builds and deploys | Medium | Links must be updated |
| 9 | **Add `scripts/sync-games.sh` to a timer** or document that it is run by hand. | Predictable asset updates | Low | Upstream repos could change |

## Stack

No change needed. A static nginx container at 64 MB serving a CDN-fronted site is already the cheapest shape. The cost is the games, not the stack.
