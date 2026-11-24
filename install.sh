#!/usr/bin/env sh
set -eu

REPO="${HELLO_AGENTS_REPO:-Yoganataa/hello-agents}"
BRANCH="${HELLO_AGENTS_BRANCH:-main}"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}"
FORCE=0

for arg in "$@"; do
  case "$arg" in
    --force|-f) FORCE=1 ;;
    --help|-h)
      echo "Usage: curl -fsSL https://raw.githubusercontent.com/${REPO}/${BRANCH}/install.sh | sh [-s -- --force]"
      exit 0
      ;;
  esac
done

download() {
  url="$1"
  dest="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$dest"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$dest" "$url"
  else
    echo "Error: curl or wget is required." >&2
    exit 1
  fi
}

install_file() {
  rel="$1"
  if [ -f "$rel" ] && [ "$FORCE" -ne 1 ]; then
    echo "skip: $rel (already exists; pass --force to overwrite)"
    return 0
  fi
  mkdir -p "$(dirname "$rel")"
  download "${BASE_URL}/${rel}" "$rel"
  echo "installed: $rel"
}

install_file "AGENTS.md"
install_file "docs/product.md"
install_file "docs/ideas.md"
install_file "docs/decisions.md"
install_file "docs/architecture.md"
install_file "docs/naming-and-copy.md"
install_file "docs/skills.md"
install_file "docs/stack-notes.md"
install_file "docs/quality.md"
install_file "docs/evals.md"
install_file "docs/reports/TEMPLATE.md"

echo ""
echo "Done. Next: fill in AGENTS.md, docs/product.md, and docs/architecture.md, set up CI from docs/quality.md, and install any kits you want from docs/skills.md."
