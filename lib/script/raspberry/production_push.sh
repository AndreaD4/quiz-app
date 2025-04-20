ID_COMMIT=$(git log | head -1 | sed s/'commit '//)

cd ../../
git archive --format zip --output /tmp/quizapp.zip master

cd lib/script

scp production_deploy.sh pi@ericamarunutrizionista.local:/var/www/quizapp
scp /tmp/quizapp.zip pi@ericamarunutrizionista.local:/var/www/quizapp

ssh pi@ericamarunutrizionista.local "echo raspberry | sudo chmod a+x /var/www/quizapp/production_deploy.sh"

ssh pi@ericamarunutrizionista.local "/var/www/quizapp/production_deploy.sh ${ID_COMMIT}"

ssh pi@ericamarunutrizionista.local "rm /var/www/quizapp/production_deploy.sh"
