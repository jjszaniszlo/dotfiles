#!/usr/bin/env bash
cd "$(dirname "$0")"

OS=$(uname -s)

require_program() {
    local prog="$1"

    if ! command -v "$prog" >/dev/null 2>&1; then
        echo "❌ Required program '$prog' is not installed. Exiting." >&2
        exit 1
    fi
}

require_program stow;

if [ "$OS" == "Darwin" ]; then
    echo "Stowing Aerospace...";
    mkdir -p $HOME/.config/aerospace
    stow aerospace -t $HOME/.config/aerospace
fi

if [ "$OS" == "Linux" ]; then
    echo "Stowing Kanagawa themes..";
    mkdir -p $HOME/.themes
    mkdir -p "$HOME/.config/gtk-4.0"
    stow themes -t $HOME/.themes
    cp -a "$(pwd)/themes/Kanagawa-Dark/gtk-4.0"/* "$HOME/.config/gtk-4.0/"
fi

echo "Stowing Emacs...";
mkdir -p $HOME/.emacs.d
stow emacs -t $HOME/.emacs.d/;
if [ "$OS" == "Linux" ]; then
    stow applications -t "$HOME/.local/share/applications"
    stow local_scripts -t "$HOME/.local/bin"
fi

echo "Stowing Git...";
stow git;

echo "Stowing Ghostty...";
mkdir -p $HOME/.config/ghostty;
stow ghostty -t $HOME/.config/ghostty;

echo "Stowing tmux...";
stow tmux;

echo "Stowing Vim...";
stow vim;

echo "Stowing Zsh...";
require_program bat;
require_program eza;
stow zsh;

echo "Run source $HOME/.zshrc to reload.";
