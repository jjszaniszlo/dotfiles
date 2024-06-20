if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias nvcfg="cd ~/.config/nvim && nvim ."
alias ls="eza"

function homebrew_use_x86_64
    eval "$(/usr/local/bin/brew shellenv)"
end

function homebrew_use_arm
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

funcsave homebrew_use_x86_64
funcsave homebrew_use_arm
