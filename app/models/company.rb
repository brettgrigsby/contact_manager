class Company < ActiveRecord::Base
  has_many :phone_numbers, as: :contact
  validates :name, presence: true
end
