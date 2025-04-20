# Cancellare prima le tabelle e creare solo il database quiz_app_development e lo schema public
ssh -i "certs/diet-app.pem" ubuntu@ec2-15-161-80-19.eu-south-1.compute.amazonaws.com "pg_dump quiz_app_production > quizapp_production_backup.sql"
scp -i "certs/diet-app.pem" ubuntu@ec2-15-161-80-19.eu-south-1.compute.amazonaws.com:./quizapp_production_backup.sql ../../../tmp/quizapp_production_backup.sql
ssh -i "certs/diet-app.pem" ubuntu@ec2-15-161-80-19.eu-south-1.compute.amazonaws.com "sudo rm quizapp_production_backup.sql"
psql quiz_app_development < ../../../tmp/quizapp_production_backup.sql
rm ../../../tmp/quizapp_production_backup.sql