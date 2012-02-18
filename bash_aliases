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

alias oib_alpha_deploy='HOSTS=app1.alpha.ec2.oib.com cap production deploy:frontend'
alias oib_alpha2_deploy='HOSTS=app2.alpha.ec2.oib.com cap alpha deploy'

alias oib_ben='oibsh app.ben.ec2.oib.com'
alias oib_ben_deploy='HOSTS=app.ben.ec2.oib.com cap production deploy:frontend'

alias is_app='oibsh app1.is.prod.ec2.oib.com'
alias is_worker='oibsh worker1.is.prod.ec2.oib.com'
alias is_staging='oibsh ec2-184-72-82-148.compute-1.amazonaws.com'
alias is_app_deploy='be cap HOSTS=app1.is.prod.ec2.oib.com ROLE=app production deploy'
alias is_worker_deploy='be cap HOSTS=worker1.is.prod.ec2.oib.com ROLE=worker production deploy'
alias is_deploy='be cap production deploy'

alias in_app='oibsh app1.insights.prod.ec2.oib.com'

alias sl_app='oibsh app1.sl.prod.ec2.oib.com'
alias sl_alpha='oibsh app1.sl.alpha.ec2.oib.com'
alias sl_alpha_deploy='HOSTS=app1.sl.alpha.ec2.oib.com cap production deploy'

alias oibsh='ssh -i ~/.ssh/oi-production-keypair.key -l root'
alias oibdb='ssh -i ~/.ssh/oi-production-keypair.key'
alias oibsftp='sftp -i ~/.ssh/oi-production-keypair.key'
