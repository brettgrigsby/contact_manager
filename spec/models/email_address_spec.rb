require 'rails_helper'

RSpec.describe EmailAddress, type: :model do
  let(:email_address) { EmailAddress.new(address: 'test@ruby.com', contact_id: 1, contact_type: 'Company')}

  it "is valid" do
    expect(email_address).to be_valid
  end

  it "is invalid without an address" do
    email_address.address = nil
    expect(email_address).not_to be_valid
  end

  it "is invalid without a person id" do
    email_address.contact_id = nil
    expect(email_address).not_to be_valid
  end

  it "is associated with a person" do
    expect(email_address).to respond_to(:contact)
  end
end
