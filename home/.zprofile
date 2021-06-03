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
  $HOME/.rbenv/bin
  $path
)

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

  if [[ -z `git branch --no-merged main | grep $branch` ]]; then
    git branch -d $branch
  else
    echo "Hey, man, $branch isn't merged yet!"
    git checkout $branch
    return 1
  fi
}

# AWS CLI multi-factor authentication helper.
export AWS_MFA_ARN='arn:aws:iam::813448775391:mfa/ben.hamill'
aws-mfa() {
    eval $(aws --output=text sts get-session-token --serial-number ${AWS_MFA_ARN} --token-code ${1} | awk '{print "export AWS_ACCESS_KEY_ID="$2" AWS_SECRET_ACCESS_KEY="$4" AWS_SESSION_TOKEN="$5}')
}

eval "$(rbenv init -)"
