#!/usr/bin/env bash
cd "$(dirname "$0")"

require_program() {
    local prog="$1"

    if ! command -v "$prog" >/dev/null 2>&1; then
        echo "❌ Required program '$prog' is not installed. Exiting." >&2
        exit 1
    fi
}

require_program stow;

echo "Stowing Emacs...";

stow emacs;

echo "Stowing Zsh...";
require_program bat;
require_program eza;
stow zsh;

echo "Stowing Vim...";
stow vim;

echo "Stowing Git...";
stow git;

echo "Run source $HOME/.zshrc to reload.";
