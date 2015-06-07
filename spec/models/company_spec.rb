require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { Company.new(name: 'Acme') }

  it "is valid" do
    expect(company).to be_valid
  end

  it "is invalid without a name" do
    company.name = nil
    expect(company).not_to be_valid
  end

  it "has an array of associated phone numbers" do
    expect(company.phone_numbers).to eq([])
  end
end
