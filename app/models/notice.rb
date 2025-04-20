class Notice < ApplicationRecord
  belongs_to :company, inverse_of: :notices
  belongs_to :manager, inverse_of: :notices
  # belongs_to :user, inverse_of: :notices
  belongs_to :notifiable, polymorphic: true

  validates_presence_of :title

  default_scope -> { order(created_at: :desc) }

  after_create_commit -> { broadcast_prepend_to "notices", partial: "managers/notices/notice" }
  after_update_commit { broadcast_replace_to "notices", partial: 'managers/notices/notice' }
  after_destroy_commit -> { broadcast_remove_to "notices", partial: "managers/notices/notice" }

  scope :filter_by_params, ->(filters) {
    result = all
    result
  }

  def description
    des = "#{self.title}"
    des = "#{des} - #{self.notes}" if self.notes.present?
    des
  end

end
