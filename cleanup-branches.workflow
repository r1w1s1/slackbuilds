#!/usr/bin/env bash

set -euo pipefail

protected_branches=(master current-overlay)
remote=origin
mode=dry-run

case "${1:-}" in
  "")
    ;;
  --apply)
    mode=apply
    ;;
  --dry-run)
    ;;
  *)
    printf 'Usage: %s [--dry-run|--apply]\n' "$0" >&2
    exit 2
    ;;
esac

repo_root=$(git rev-parse --show-toplevel)
cd "$repo_root"

if [ "$(git branch --show-current)" != "master" ]; then
  printf 'Refusing to run: check out master first.\n' >&2
  exit 1
fi

git show-ref --verify --quiet refs/heads/master || {
  printf 'Refusing to run: local master does not exist.\n' >&2
  exit 1
}
git remote get-url "$remote" >/dev/null || {
  printf 'Refusing to run: remote %s does not exist.\n' "$remote" >&2
  exit 1
}

if [ "$mode" = apply ]; then
  delete_local() { git branch -D -- "$1"; }
  delete_remote() { git push "$remote" --delete "$1"; }
else
  delete_local() { printf '[dry-run] would delete local %s\n' "$1"; }
  delete_remote() { printf '[dry-run] would delete %s/%s\n' "$remote" "$1"; }
fi

is_protected() {
  local branch=$1
  local protected
  for protected in "${protected_branches[@]}"; do
    [ "$branch" = "$protected" ] && return 0
  done
  return 1
}

while IFS= read -r branch; do
  is_protected "$branch" || delete_local "$branch"
done < <(git for-each-ref --format='%(refname:short)' refs/heads/)

while IFS=$'\t' read -r _ ref; do
  branch=${ref#refs/heads/}
  is_protected "$branch" || delete_remote "$branch"
done < <(git ls-remote --heads "$remote")
