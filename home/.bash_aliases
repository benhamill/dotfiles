alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'

alias be='bundle exec'
alias rebundle='bundle install --binstubs'
alias rehash='rbenv rehash'
alias bundlehash='rebundle && rehash'

alias packer='packer --auronly'

alias irb=pry
alias rpry='pry -r ./config/environment'

alias git=hub

function gcb() {
  git branch | grep '^\*' | cut -c3-
}

function gfb() {
  branch=`gcb`

  git checkout master && git pull --prune

  if [[ $1 == '--force' || -z `git branch --no-merged master | grep $branch` ]]; then
    git branch -d $branch && git push origin :$branch
  else
    echo "Hey, man, $branch isn't merged yet!"
    git checkout $branch
  fi
}

alias gpn='echo "git push -u" && git push -u'
alias gpr='echo "git pull-request" && git pull-request'

alias in_app='oibsh app1.insights.prod.ec2.oib.com'

function rails_personal() {
  rails new $* --skip-bundle --database=postgresql --skip-test-unit --template=https://raw.github.com/benhamill/omakase/master/hamill_time.rb
}
