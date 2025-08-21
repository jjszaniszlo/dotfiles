#!/usr/bin/env bash
cd "$(dirname "$0")"

require_program() {
    local prog="$1"

    if ! command -v "$prog" >/dev/null 2>&1; then
        echo "❌ Required program '$prog' is not installed. Exiting." >&2
        exit 1
    fi
}

require_program stow

echo "Copying zsh/omz-plugins to $HOME/.oh-my-zsh/custom..."

cp -a zsh/omz-plugins/. zsh/.oh-my-zsh/custom/plugins/

echo "Stowing Dotfiles...";

stow emacs
stow zsh

echo "Run source $HOME/.zshrc to reload."
