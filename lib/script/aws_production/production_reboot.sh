cd /var/www/quizapp/current

echo '-- kill all Job'
JOBS=$(pgrep -f jobs:work)
if [ "$JOBS" != "" ]; then
  kill -9 $JOBS
fi

echo '-- start jobs:work'

nohup /home/ubuntu/.rbenv/shims/bundle exec rake jobs:work </dev/null &>/dev/null &