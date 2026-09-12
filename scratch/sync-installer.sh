#!/bin/sh
# Refresh the hosted installer from the platform repo.
#
# public/install.sh is served at https://getvesta.sh/install.sh, which is the command the
# marketing pages tell people to run. A stale copy there installs a stale Vesta, and the
# only symptom is someone else's install behaving oddly -- so re-run this whenever
# install-vesta.sh changes.
set -eu
SRC="${1:-../vesta-kubernetes/install-vesta.sh}"
[ -f "$SRC" ] || { echo "not found: $SRC" >&2; exit 1; }

sed 's|curl -fsSL https://raw.githubusercontent.com/vesta-infra/vesta-kubernetes/develop/install-vesta.sh | sh|curl -fsSL https://getvesta.sh/install.sh | sh|' "$SRC" > public/install.sh
chmod +x public/install.sh
sh -n public/install.sh
echo "public/install.sh updated from $SRC"
