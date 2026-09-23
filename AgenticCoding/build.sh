#!/usr/bin/env bash
#
# Rebuild index.html + assets/ from slides.md.
#
#   bash build.sh
#
# index.html is a BUILT file: editing slides.md does nothing until you run this.
# While writing the deck, `bun run dev` is nicer - it reloads as you type.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

if [ ! -d node_modules ]; then
  echo "First run: installing dependencies (~1 min)..."
  bun install
  # Best effort: stop Dropbox syncing ~600 MB of node_modules
  powershell.exe -NoProfile -Command \
    "Set-Content -Path node_modules -Stream com.dropbox.ignored -Value 1" >/dev/null 2>&1 \
    || echo "(could not mark node_modules as Dropbox-ignored - harmless)"
fi

echo "Building slides.md..."
# Build outside Dropbox: it locks freshly written folders, which breaks cleanup.
OUT="/tmp/slidev-build-agentic-coding"
rm -rf "$OUT"

# Slidev treats a root index.html as its own Vite template, so move the
# previous build out of the way first (it is rewritten below).
rm -f index.html
bunx slidev build slides.md --out "$OUT" --base ./

rm -rf assets
cp "$OUT/index.html" .
cp -r "$OUT/assets" .
rm -rf "$OUT" || true

echo
echo "Done - index.html and assets/ rebuilt ($(grep -c '^# ' slides.md) headings in source)."
echo "If the page looks unchanged in the browser, hard-refresh: Ctrl+Shift+R."
