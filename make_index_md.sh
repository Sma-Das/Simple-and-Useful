#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo "[*] File not specified; defaulting to README.md" >&2
  FILE="README.md"
else
  FILE="$1"
fi

if [[ ! -f "${FILE}" ]]; then
  echo "[-] File: '${FILE}' does not exist" >&2
  echo "[-] Exitting..." >&2
  exit 1
fi

# I typically use 3 '#' to indicate that I want it to be indexed

if [[ -z "$SUBHEADING" ]]; then
  echo "[*] Subheading type not exported; defaulting to '### '" >&2
  SUBHEADING="### "
else
  echo "[*] In general: a space after your subheading is recommended" >&2
fi

sleep 1

echo "## Index"

while read -r LINE; do
  STRIPPED="${LINE#${SUBHEADING}}"
  LOWER=${STRIPPED,,}
  echo "- [${STRIPPED}](#${LOWER/' '/'-'})"
done < <(grep "${SUBHEADING}" "${FILE}")

exit 0
