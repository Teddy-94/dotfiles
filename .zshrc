# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:/Users/teodoradolfsson/.local/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(fnm env --use-on-cd --shell zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load nvm from Homebrew's location
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"

# Load nvm bash_completion from Homebrew's location
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# Add Bob's Neovim proxy binary to PATH
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

export PATH="$PATH:/Users/teodoradolfsson/Library/Python/3.12/bin"

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# alias
alias dc="docker-compose"

alias lsa="ls -goaG"

alias gco="git checkout"
alias gst="git status -sb"
alias gdf="git diff --color-words"
alias gdt="git difftool"
alias gl="git log -10 --pretty=oneline"

alias tm="~/.local/bin/tm-open"

# Git info in prompt
setopt prompt_subst
precmd() {
    if [[  -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)"  ]];
    then
        branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')

        untracked=$(git status --porcelain 2>/dev/null | grep '^??' | wc -l|tr -d '[:space:]')
        tracked=$(git status --porcelain | grep -v '^??' | grep -E '^[MADRC]' | wc -l|tr -d '[:space:]')
        modified_files=$(git ls-files --modified | wc -l | tr -d '[:space:]')
        total_changed_files=$((untracked + tracked + modified_files))

        staged=$(git diff --cached --name-only | wc -l | tr -d '[:space:]')

        behind_count=$(git rev-list --right-only --count HEAD...@{u} 2>/dev/null | tr -d '[:space:]')
        ahead_count=$(git rev-list --left-only --count HEAD...@{u} 2>/dev/null | tr -d '[:space:]')
        PS1='%2/ %{%F{red}(${branch})%} %{%F{yellow}%}[U:${total_changed_files} S:${staged} -:${behind_count} +:${ahead_count}]%{%f%} $ '
    else
        PS1='%2/ $ '
    fi
}

# pnpm
export PNPM_HOME="/Users/teodoradolfsson/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# The next line updates PATH for the Google Cloud SDK.
export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"


# bun completions
[ -s "/Users/teodoradolfsson/.bun/_bun" ] && source "/Users/teodoradolfsson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
