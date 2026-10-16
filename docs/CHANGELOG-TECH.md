# Technical changelog

From git history, checked 2026-10-16. Content and SEO changes are in my-seo annotations (no property id recorded for sz-games.com yet), not here.

| Date | Change |
|---|---|
| 2023-06-29 | Repo created as a static GitHub Pages site (commit 1f73d0d). |
| 2023-11-18 | `CNAME` added (sz-games.com on GitHub Pages). Changed 2024-08-02. |
| 2026-01 to 2026-03 | Ad script and blocklist loader changes; `ads.txt` updated. |
| 2026-09-06 | Synced with sz-games.github.io, new ad units and `ads.txt`. |
| 2026-09-08 | Moved to Kamal 2: `Dockerfile`, `nginx.conf`, `config/deploy.yml`, `.github/workflows/deploy.yml`. Site now runs on themarzlibrary, not GitHub Pages. |
| 2026-09-25 | Memory limit (64 MB) on the web container. |
| 2026-09-30 | SEO pass: canonicals, noindex on thin pages, new sitemap and robots, unique titles. Unused FontAwesome kit script removed. |
| 2026-10-01 | FL-88: local copies for cross-repo image hotloads. Server asset provenance written down (fleet repo). |
| 2026-10-02/03 | FL-93 Bad Ice Cream links fixed; FL-114 home links fixed. |
| 2026-10-08 | FL-666: smoke test added to the deploy workflow. |
| 2026-10-16 | FL-1142 audit: docs added. No dependency changes (no package manager). |
