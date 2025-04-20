class ReportJob < ApplicationJob
  queue_as :import

  def perform(*args)
    begin
      report = args[0]

      if report.may_run?
        report.update_column(:started_at, Time.now)
        report.run!
        report.model_class.send(report.method_name, {report: report, params: report.params})
        if report.params['queue'].present?
          report.aasm_state = :created
          report.save
          ReportJob.set(queue: :hard_worker).perform_later(report)
        else
          report.update_column(:ended_at, Time.now)
          report.stop!
        end
      end
    rescue => e
      report.last_error = "#{e.message}\n#{e.backtrace.join("\n")}"
      report.update_column(:ended_at, Time.now)
      report.error!
    end
  end

end
