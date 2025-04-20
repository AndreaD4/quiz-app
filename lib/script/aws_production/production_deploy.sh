cd /var/www/quizapp

mkdir -p releases

cd releases

DIR=$(date '+%Y_%m_%d')_$1
mkdir $DIR

mv ../quizapp.zip $DIR
cd $DIR
unzip quizapp.zip

rm -rf script/certs
sudo rm quizapp.zip

/home/ubuntu/.rbenv/shims/bundle install

mkdir -p /var/www/quizapp/shared
mkdir -p /var/www/quizapp/shared/log
mkdir -p /var/www/quizapp/shared/tmp
mkdir -p /var/www/quizapp/shared/tmp/pids
mkdir -p /var/www/quizapp/shared/tmp/sockets
mkdir -p /var/www/quizapp/shared/tmp/cache

[[ -e /var/www/quizapp/shared/.rbenv-vars ]] || touch /var/www/quizapp/shared/.rbenv-vars

ln -s /var/www/quizapp/shared/.rbenv-vars .rbenv-vars
ln -s /var/www/quizapp/shared/log log

mkdir -p tmp
cd tmp

ln -s /var/www/quizapp/shared/tmp/cache cache
ln -s /var/www/quizapp/shared/tmp/pids pids
ln -s /var/www/quizapp/shared/tmp/sockets sockets

cd ..

echo '-- migrate'
RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rake db:migrate
echo '-- js:routes'
RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rake js:routes
echo '-- assets:precompile'
RAILS_ENV=production /home/ubuntu/.rbenv/shims/bundle exec rake assets:precompile

echo '-- kill all Job'
JOBS=$(pgrep -f jobs:work)
if [ "$JOBS" != "" ]; then
  kill -9 $JOBS
fi

echo '-- start jobs:work'
nohup /home/ubuntu/.rbenv/shims/bundle exec rake jobs:work </dev/null &>/dev/null &

cd /var/www/quizapp

[ -e current ] && rm current

ln -s releases/$DIR current

echo '-- Restart nginx'
sudo service nginx restart