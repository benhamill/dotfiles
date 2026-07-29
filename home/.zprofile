#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#


#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
else
  export BROWSER='win-firefox'
fi

#
# Editors
#

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $HOME/.local/bin
  $path
)

# Completions
fpath=(
  $fpath
)

autoload -Uz compinit && compinit

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Git finish branch.
gfb () {
  branch=`git symbolic-ref HEAD | cut -d'/' -f3-`

  git checkout main && git pull --prune

  if [[ $1 == '--force' || -z `git branch --no-merged main | grep $branch` ]]; then
    git branch -D $branch
  else
    echo "Hey, man, $branch isn't merged yet! Here's the log:"
    git log -n10 --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%an%C(reset) %C(green)(%cr)%C(reset) -%C(bold blue)%d%C(reset) %s'
    git checkout $branch
    return 1
  fi
}

# Token for gh CLI
export GH_TOKEN="REPLACEME"

# Convert ISO 8601 dates to Linux Timestamp
discord-timestamp () {
    date -d "${1}" +%s
}

eval "$($HOME/.local/bin/mise activate zsh)"
