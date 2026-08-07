#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${PROJECT_ROOT}/how"
TARGET="${HOME}/.local/bin/how"

if [[ ! -e "${TARGET}" && ! -L "${TARGET}" ]]; then
    echo "Already uninstalled: ${TARGET} does not exist."
    exit 0
fi

if [[ ! -L "${TARGET}" ]]; then
    echo "ERROR: ${TARGET} exists but is not a symlink."
    echo "Leaving it untouched."
    exit 1
fi

CURRENT="$(readlink -f -- "${TARGET}")"

if [[ "${CURRENT}" != "${SOURCE}" ]]; then
    echo "ERROR: ${TARGET} points somewhere else:"
    echo "  ${CURRENT}"
    echo "Leaving it untouched."
    exit 1
fi

rm -- "${TARGET}"

echo "Uninstalled:"
echo "  ${TARGET}"
