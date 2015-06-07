class PhoneNumber < ActiveRecord::Base
  belongs_to :person
  belongs_to :company
  validates :number, presence: true
  validates :person_id, presence: true
end
