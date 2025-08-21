ZSH_CUSTOM=$HOME/.dotfiles/zsh/omz-custom

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gnzh"

plugins=(
    aliases
    git
    git-commit
    git-auto-fetch
    you-should-use
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.local/bin"

# Example using a case statement for different hostnames
case "$(hostname)" in
    "poseidon")
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
