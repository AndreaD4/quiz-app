require 'zip'

class BackupS3Job < ApplicationJob
  def perform(*args)
    company = args[0]

    `pg_dump quiz_app_production > quizapp_production_backup.sql`
    `mv quizapp_production_backup.sql #{Rails.root.join('tmp')}/quizapp_production_backup.sql`

    s3_config = YAML.load(ERB.new(File.read(Rails.root.join('config', 's3.yml'))).result)[Rails.env]
    s3 = Aws::S3::Resource.new(access_key_id: s3_config['access_key_id'], secret_access_key: s3_config['secret_access_key'], region: 'eu-south-1')
    bucket = s3.bucket(s3_config['bucket'])

    zip_file_name = "backup_#{Time.now.strftime("%Y_%m_%d_%H_%M_%S")}.zip"
    zip_file_path = "#{Rails.root.join('tmp')}/#{zip_file_name}"

    Zip::File.open(zip_file_path, Zip::File::CREATE) do |zipfile|
      files = Dir.entries(Rails.root.join('tmp')).select { |e| e.ends_with? '.sql' }
      files.each do |filename|
        file_name = File.basename(filename)
        zipfile.add(file_name, "#{Rails.root.join('tmp')}/#{file_name}")
      end
    end

    bucket.object(zip_file_name).upload_file(Pathname.new(zip_file_path))

    company.backup_file.attach(io: File.open(zip_file_path), filename: File.basename(zip_file_path))

    ApplicationMailer.send_backup(company).deliver_later

    `cd #{Rails.root.join('tmp')} && rm quizapp_production_backup.sql`
    `cd #{Rails.root.join('tmp')} && rm *.zip`
  end
end