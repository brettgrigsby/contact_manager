require 'rails_helper'

describe 'the person view', type: :feature do
  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  describe 'for phone numbers' do
    before(:each) do
      person.phone_numbers.create(number: '555-1234')
      person.phone_numbers.create(number: '555-5678')
      visit person_path(person)
    end

    it "shows the phone numbers" do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it "has a link to add a new phone number" do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: person.id, contact_type: 'Person'))
    end

    it "adds a new phone number" do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end

    it "has links to edit phone numbers" do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it "edits a phone number" do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).not_to have_content(old_number)
    end

    it "has a link to delete phone numbers" do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it "deletes a phone number" do
      old_number = person.phone_numbers.first.number

      first(:link, 'delete').click
      expect(current_path).to eq(person_path(person))
      expect(page).not_to have_content(old_number)
    end
  end

  describe 'for email addresses' do
    before(:each) do
      person.email_addresses.create(address: 'test1@rspec.com')
      person.email_addresses.create(address: 'test2@rspec.com')
      visit person_path(person)
    end

    it "shows the email addresses" do
      person.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end

    it "has an add email address link" do
      expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: person.id, contact_type: 'Person'))
    end

    it "adds a new email address" do
      page.click_link('Add email address')
      page.fill_in('Address', with: 'mytest@address.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('mytest@address.com')
    end

    it "has a link to edit email addresses" do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it "edits an email address" do
      email = person.email_addresses.first
      old_address = email.address

      within("#emails-list") do
        first(:link, 'edit').click
      end
      page.fill_in('Address', with: 'newer@address.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('newer@address.com')
      expect(page).not_to have_content(old_address)
    end

    it "has a link to delete email addresses" do
      person.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end

    it "deletes an email" do
      old_address = person.email_addresses.first.address

      within("#emails-list") do
        first(:link, 'delete').click
      end
      expect(current_path).to eq(person_path(person))
      expect(page).not_to have_content(old_address)
    end
  end


end
