class Company < ApplicationRecord
  has_many :notices, inverse_of: :company, dependent: :destroy
  has_many :reports, inverse_of: :company, dependent: :destroy
  has_many :managers, inverse_of: :company, dependent: :destroy
  has_many :users, inverse_of: :company, dependent: :destroy
  has_many :countries, inverse_of: :company, dependent: :destroy
  has_many :districts, inverse_of: :company, dependent: :destroy
  has_many :customers, inverse_of: :company, dependent: :destroy
  has_many :foods, inverse_of: :company, dependent: :destroy
  has_many :food_categories, class_name: 'FoodCategory', inverse_of: :company, dependent: :destroy
  has_many :diets, inverse_of: :company, dependent: :destroy
  has_many :pathologies, inverse_of: :company, dependent: :destroy
  has_many :rates, inverse_of: :company, dependent: :destroy
  has_many :documents, inverse_of: :company, dependent: :destroy
  has_many :appointments, inverse_of: :company, dependent: :destroy

  has_one_attached :backup_file
end
