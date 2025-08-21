ZSH_CUSTOM=$HOME/.dotfiles/zsh/omz-custom

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gnzh"

plugins=(
    aliases
    git
    git-commit
    git-auto-fetch
    you-should-use
    zsh-autosuggestions
    zsh-bat
    zsh-eza
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.local/bin"

# required for vterm in emacs
vterm_printf() {
    if [ -n "$TMUX" ] \
        && { [ "${TERM%%-*}" = "tmux" ] \
            || [ "${TERM%%-*}" = "screen" ]; }; then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# Example using a case statement for different hostnames
case "$(hostname)" in
    "poseidon.local")
        # Poseidon settings
        source $HOME/.zshrc-poseidon
        ;;
    "athena")
        # Specific settings for the home desktop
        source $HOME/.zshrc-athena
        ;;
    *)
        # Default settings for all other machines
        ;;
esac
