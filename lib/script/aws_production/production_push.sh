ID_COMMIT=$(git log | head -1 | sed s/'commit '//)

cd ../../../
git archive --format zip --output /tmp/quizapp.zip master

cd lib/script/aws_production

chmod 400 certs/diet-app.pem

scp -i "certs/diet-app.pem" production_deploy.sh ubuntu@ec2-15-161-80-19.eu-south-1.compute.amazonaws.com:/var/www/quizapp
scp -i "certs/diet-app.pem" /tmp/quizapp.zip ubuntu@ec2-15-161-80-19.eu-south-1.compute.amazonaws.com:/var/www/quizapp

ssh -i "certs/diet-app.pem" ubuntu@ec2-15-161-80-19.eu-south-1.compute.amazonaws.com "sudo chmod a+x /var/www/quizapp/production_deploy.sh"

ssh -i "certs/diet-app.pem" ubuntu@ec2-15-161-80-19.eu-south-1.compute.amazonaws.com "/var/www/quizapp/production_deploy.sh ${ID_COMMIT}"

ssh -i "certs/diet-app.pem" ubuntu@ec2-15-161-80-19.eu-south-1.compute.amazonaws.com "rm /var/www/quizapp/production_deploy.sh"
