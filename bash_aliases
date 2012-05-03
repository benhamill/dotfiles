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

function gcb() {
  git branch | grep '^\*' | cut -c3-
}

function gco() {
  grep url .git/config | grep github | cut -d: -f2 | sed -e 's/\.git//'
}

function gfb() {
  branch=`gcb`

  if [[ -z `git branch --no-merged master | grep $branch` ]]; then
    git checkout master && git branch -d $branch && git push origin :$branch
  else
    echo "Hey, man, $branch isn't merged yet!"
  fi
}

alias gpn='git push -u origin `gcb`'
alias gpr='xdg-open "https://github.com/`gco`/pull/new/`gcb`"'

alias in_app='oibsh app1.insights.prod.ec2.oib.com'
alias oib_jenkins='ssh -L8080:localhost:8080 -i ~/.ssh/oi-production-keypair.key ubuntu@ec2-50-17-93-145.compute-1.amazonaws.com'
