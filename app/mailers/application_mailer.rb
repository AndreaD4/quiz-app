class ApplicationMailer < ActionMailer::Base
  layout "mailer"

  def send_backup(company)
    if company.backup_file.attached?
      attachments[company.backup_file.filename.to_s] = {
        mime_type: company.backup_file.content_type,
        content: company.backup_file.download
      }

      mail(to: 'andreadiquattro95@gmail.com', subject: "Backup #{Time.zone.now.strftime("%d/%m/%Y %H:%M")}")
    end
  end

  def test_email(email)
    mail(to: email, subject: "TEST INVIO EMAIL")
  end
end
