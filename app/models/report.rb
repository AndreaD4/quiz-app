class Report < ApplicationRecord
  include AASM
  extend Enumerize

  belongs_to :company, inverse_of: :reports
  belongs_to :manager, inverse_of: :reports

  default_scope { order(created_at: :desc) }

  has_one_attached :file

  after_create :enqueue, if: -> { may_run? }
  after_create_commit { broadcast_prepend_to "reports", partial: 'managers/reports/report', target: 'reports_table' }
  after_update_commit { broadcast_replace_to "reports", partial: 'managers/reports/report' }
  after_destroy_commit { broadcast_remove_to "reports" }

  aasm do
    state :created, initial: true
    state :started
    state :exported
    state :blocked

    event :run do
      transitions from: :created, to: :started
    end

    event :stop do
      transitions from: :started, to: :exported
    end

    event :error do
      transitions :from => [:created, :started], :to => :blocked
    end
  end

  def model_class
    model_name_of.constantize
  end

  private

  def enqueue
    ReportJob.perform_later self
  end
end
