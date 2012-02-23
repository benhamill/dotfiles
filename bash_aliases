alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'

alias be='bundle exec'
alias rebundle='bundle install --binstubs'
alias rehash='rbenv rehash'
alias bundlehash='rebundle && rehash'

alias irb=pry
alias rpry='pry -r ./config/environment'

alias oib_jenkins='ssh -i ~/.ssh/oi-production-keypair.key -l ubuntu -L8080:localhost:8080 ubuntu@ec2-50-17-93-145.compute-1.amazonaws.com'
alias oib_alpha='oibsh app1.alpha.ec2.oib.com'
alias oib_trainer='oibsh ec2-184-73-75-183.compute-1.amazonaws.com'
alias oib_graphite='oibsh ec2-184-72-138-168.compute-1.amazonaws.com'

function gcb() {
  git branch | grep '^\*' | cut -c3-
}

function gco() {
  grep url .git/config | cut -d: -f2 | sed -e 's/\.git//'
}

alias gpn='git push -u origin `gcb`'
alias gpr='xdg-open "https://github.com/`gco`/pull/new/`gcb`"'

alias in_app='oibsh app1.insights.prod.ec2.oib.com'

alias sl_app='oibsh app1.sl.prod.ec2.oib.com'
alias sl_alpha='oibsh app1.sl.alpha.ec2.oib.com'
alias sl_alpha_deploy='HOSTS=app1.sl.alpha.ec2.oib.com cap production deploy'

alias oibsh='ssh -i ~/.ssh/oi-production-keypair.key -l ubuntu'
alias oibsftp='sftp -i ~/.ssh/oi-production-keypair.key'
