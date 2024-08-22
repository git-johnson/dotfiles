# This zshrc is heavily inspired by mischavandenburg, I kept what made sense to me then built on it
# Check him out at https://github.com/mischavandenburg

# Path configuration
setopt EXTENDED_GLOB NULL_GLOB

path=(
  $path # Keep existing paths
  $HOME/bin
  $HOME/.local/bin
  $SCRIPTS
  )

# Remove duplicate or non-existent directories
typeset -U path
path=($^path(N-/))

export PATH

# SSH
# TODO: Explore using GPG for SSH

# Environment Variables
set -o vi

export VISUAL=nvim
export EDITOR=nvim
export TERM="tmux-256color"

export BROWSER="firefox"

# Directories
export REPOS="$HOME/repos"
export GITUSER="git-johnson"
export DOTFILES="$REPOS/dotfiles"
export LAB="$REPOS/lab"
export SCRIPTS="$DOTFILES/scripts"

# TODO: Configure me after learning more about Zettelkasten
# export ZETTLEKASTEN="$HOME/zettelkasten"

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE # Ignore leading whitespace
setopt HIST_IGNORE_DUPS  # Don't save duplicate lines
setopt SHARE_HISTORY     # Share history between sessions

# Prompt

PURE_GIT_PULL=0

if [[ "$OSTYPE" == darwin* ]]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
else
  fpath+=($HOME/.zsh/pure)
fi


autoload -U promptinit; promptinit
prompt pure

###### Aliases ######
alias v=nvim
alias scripts='cd $SCRIPTS'
alias c="clear"

# Repos
alias lab='cd $LAB'
alias dot='cd $DOTFILES'
alias repos='cd $REPOS'
alias ptrepos='cd $REPOS/paytrace'

# Homelab
# TODO: Add some sensible aliases

# ls
alias ls='ls --color=auto'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias t='tmux'
alias e='exit'

# AWS
# Get current IAM role
alias whoiam="aws sts get-caller-identity"

# Git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
#TODO: Add some better aliases

#alias kc='kubectx'

# TODO: Add some helpful aliases for the BitWarden CLI

# Autocompletion
fpath+=~/.zfunc

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/completions:$FPATH
fi

autoload -Uz compinit
compinit -u

zstyle ':completions:*' menu select

