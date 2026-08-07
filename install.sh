#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${PROJECT_ROOT}/how"
BIN_DIR="${HOME}/.local/bin"
TARGET="${BIN_DIR}/how"

mkdir -p "${BIN_DIR}"

if [[ -L "${TARGET}" ]]; then
    CURRENT="$(readlink -f -- "${TARGET}")"

    if [[ "${CURRENT}" == "${SOURCE}" ]]; then
        echo "Already installed: ${TARGET} -> ${SOURCE}"
        exit 0
    fi

    echo "ERROR: ${TARGET} is already a symlink to:"
    echo "  ${CURRENT}"
    exit 1
fi

if [[ -e "${TARGET}" ]]; then
    echo "ERROR: ${TARGET} already exists and is not a symlink."
    exit 1
fi

ln -s "${SOURCE}" "${TARGET}"

echo "Installed:"
echo "  ${TARGET} -> ${SOURCE}"
