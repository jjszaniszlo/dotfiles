ZSH_CUSTOM=$HOME/.dotfiles/zsh/omz-custom

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gnzh"

plugins=(
    git
    git-commit
    git-auto-fetch
    you-should-use
    zsh-autosuggestions
    zsh-bat
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

alias gcl='git commit -m "$(git diff HEAD | claude -p "write a conventional commit message (feat/fix/docs/style/refactor) with scope.  Do not give me multiple options and just output the message directly.")" -e'
searchpro() {
    cmd=$(llm -s "generate the most efficient search command for: $1")
    echo "Generated command: $cmd"
    read -p "Execute? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        eval "$cmd"
    fi
}
