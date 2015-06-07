class PhoneNumber < ActiveRecord::Base
  belongs_to :contact, polymorphic: true
  validates :number, presence: true
  validates :contact_id, presence: true
end
