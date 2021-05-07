#!/bin/bash
# alias ls='ls --color'
alias ll='ls -lAF'

alias be='bundle exec'

alias packer='packer-color --auronly'

alias git=hub

function gcb() {
  git branch | grep '^\*' | cut -c3-
}

function gfb() {
  branch=`gcb`

  git checkout master && git pull --prune

  if [[ $1 == '--force' || -z `git branch --no-merged master | grep $branch` ]]; then
    git branch -D $branch # && git push origin :$branch
  else
    echo "Hey, man, $branch isn't merged yet!"
    git checkout $branch
  fi
}

function rails_personal() {
  rails new $* --skip-bundle --database=postgresql --skip-test-unit --template=https://raw.github.com/benhamill/omakase/master/hamill_time.rb
}

function new_gem() {
  ~/.bash/new_gem $*
}

function gem_projection() {
  ~/.bash/gem_projection $*
}

function elixir_projection() {
  ~/.bash/elixir_projection $*
}

function pair_term() {
  echo "XTerm*FaceSize: 13" | xrdb -merge -
}

function solo_term() {
  echo "XTerm*FaceSize: 11" | xrdb -merge -
}

function raw_imap() {
  openssl s_client -connect $1 -crlf
}
