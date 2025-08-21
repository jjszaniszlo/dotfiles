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

echo "Stowing Git...";
stow git;

echo "Stowing Ghostty..."
mkdir -p $HOME/.config/ghostty
stow ghostty -t $HOME/.config/ghostty

echo "Stowing Vim...";
stow vim;

echo "Stowing Zsh...";
require_program bat;
require_program eza;
stow zsh;

echo "Run source $HOME/.zshrc to reload.";
