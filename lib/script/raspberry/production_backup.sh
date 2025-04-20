# Cancellare prima le tabelle e creare solo il database quiz_app_development e lo schema public
ssh pi@ericamarunutrizionista.local "pg_dump quizapp_production > quizapp_production_backup.sql"
scp pi@ericamarunutrizionista.local:./quizapp_production_backup.sql ../../tmp/quizapp_production_backup.sql
ssh pi@ericamarunutrizionista.local "sudo rm quizapp_production_backup.sql"
psql quiz_app_development < ../../tmp/quizapp_production_backup.sql
rm ../../tmp/quizapp_production_backup.sql