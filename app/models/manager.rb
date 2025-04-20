class Manager < ApplicationRecord
  extend Enumerize
  devise :database_authenticatable, :async,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable, :password_expirable, :password_archivable

  belongs_to :company, inverse_of: :managers, counter_cache: true

  has_many :notices, inverse_of: :manager, dependent: :destroy
  has_many :reports, inverse_of: :manager, dependent: :destroy

  validates :name, presence: true
  validates_presence_of :email, if: :email_required?
  validates_uniqueness_of :email, allow_blank: true, if: :will_save_change_to_email?, scope: :company_id
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, allow_blank: true, if: :will_save_change_to_email?

  # validates_format_of :password, with: /\A^.*(?=.{8,})(?!.*\s)(?=.*[a-z])(?=.*[A-Z])(?=.*\d).*$\z/, if: :password_required?
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of :password, within: 6..128, allow_blank: true

  def self.find_for_authentication(warden_conditions)
    includes(:company).where(email: warden_conditions[:email], companies: { host: warden_conditions[:host] }).first
    # where(email: warden_conditions[:email]).first
  end

  def full_name
    "#{name} #{name}"
  end

  def initial_letters
    "#{name[0]}"
  end

  protected

  def email_required?
    true
  end

  def password_required?
    !persisted? and (!password.present? || !password_confirmation.nil?)
  end
end
