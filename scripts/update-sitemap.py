#!/usr/bin/env python3
# /// script
# requires-python = ">=3.10"
# dependencies = []
# ///
"""Add missing scottj.info links from GitHub repo homepages to sitemap.json."""

import json
import pathlib
import time
import urllib.error
import urllib.parse
import urllib.request

GITHUB_API = "https://api.github.com"
GITHUB_USERNAME = "scottj"
ALLOWED_DOMAIN = "scottj.info"
SITEMAP_PATH = pathlib.Path(__file__).parent.parent / "sitemap.json"


def github_get(url: str):
    req = urllib.request.Request(
        url,
        headers={
            "Accept": "application/vnd.github+json",
            "User-Agent": "github-repo-homepage-url-checker",
            "X-GitHub-Api-Version": "2022-11-28",
        },
    )

    try:
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode("utf-8"))
            headers = dict(resp.headers)
            return data, headers

    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")

        if e.code == 404:
            raise SystemExit("User not found, or no public data is available.")

        if e.code == 403:
            reset = e.headers.get("X-RateLimit-Reset")
            if reset:
                reset_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(int(reset)))
                raise SystemExit(f"GitHub API rate limit hit. Resets at: {reset_time}")
            raise SystemExit(f"GitHub API forbidden: {body}")

        raise SystemExit(f"GitHub API error {e.code}: {body}")


def parse_next_link(link_header: str | None) -> str | None:
    if not link_header:
        return None

    for part in link_header.split(","):
        section = part.strip().split(";")
        if len(section) < 2:
            continue
        url = section[0].strip()
        rel = section[1].strip()
        if rel == 'rel="next"':
            return url.strip("<>")

    return None


def get_public_repos(username: str):
    encoded_user = urllib.parse.quote(username, safe="")
    url = f"{GITHUB_API}/users/{encoded_user}/repos?type=public&per_page=100&sort=full_name"

    repos = []
    while url:
        data, headers = github_get(url)
        if not isinstance(data, list):
            raise SystemExit(f"Unexpected GitHub response: {data}")
        repos.extend(data)
        url = parse_next_link(headers.get("Link"))

    return repos


def is_allowed_url(url: str) -> bool:
    try:
        parsed = urllib.parse.urlparse(url)
        host = parsed.netloc.lstrip("www.")
        return host == ALLOWED_DOMAIN or host.endswith("." + ALLOWED_DOMAIN)
    except Exception:
        return False


def repo_name_to_title(repo: dict) -> str:
    name = repo.get("name", "")
    return name.replace("-", " ").replace("_", " ").title()


def main():
    sitemap: dict[str, str] = json.loads(SITEMAP_PATH.read_text(encoding="utf-8"))
    existing_urls = set(sitemap.values())

    repos = get_public_repos(GITHUB_USERNAME)

    added = []
    for repo in repos:
        homepage = (repo.get("homepage") or "").strip()
        if not homepage or not is_allowed_url(homepage):
            continue

        # Normalize trailing slash for dedup
        normalized = homepage.rstrip("/") + "/"
        if any(u.rstrip("/") + "/" == normalized for u in existing_urls):
            continue

        title = repo_name_to_title(repo)
        # Avoid duplicate titles
        if title in sitemap:
            title = f"{title} ({repo.get('name')})"

        sitemap[title] = homepage
        existing_urls.add(homepage)
        added.append((title, homepage))

    if not added:
        print("No new links to add.")
        return

    SITEMAP_PATH.write_text(json.dumps(sitemap, indent=2) + "\n", encoding="utf-8")
    for title, url in added:
        print(f"Added: {title!r} -> {url}")


if __name__ == "__main__":
    main()
