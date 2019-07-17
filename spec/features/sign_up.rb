require 'rails_helper'

describe "user sign up" do

  before do
    visit new_user_path
    fill_in 'user[name]', with: "Jon Snow"
    fill_in 'user[email]', with: "jsnow@gmail.com"
    find('form input[type="file"]').set('app/assets/images/jon_snow.png')
    fill_in 'user[password]', with: "password"
    fill_in 'user[password_confirmation]', with: "password"
    click_button "Create Account"
  end

  describe "successful user sign up", type: :feature do
    
    let(:user) { User.find_by(email: "jsnow@gmail.com") }

    it "creates a new user account" do
      expect(user).to_not be_nil
    end

    it "logs in the user after successful sign up" do
      expect(page).to have_css('h3', text: user.name)
    end

  end

  describe "unsuccessful sign up attempts", type: :feature do
    it "renders the sign up template when input fields are blank" do
      visit logout_path
      visit new_user_path
      fill_in 'user[name]', with: ""
      fill_in 'user[email]', with: ""
      fill_in 'user[password]', with: ""
      fill_in 'user[password_confirmation]', with: ""
      click_button "Create Account"
      expect(page).to have_css('li', text: "Name can't be blank")
      expect(page).to have_css('li', text: "Email can't be blank")
      expect(page).to have_css('li', text: "Password can't be blank")
    end

    it "will not allow a user to sign up with a pre-existing email address" do
      visit logout_path
      visit new_user_path
      fill_in 'user[name]', with: "something"
      fill_in 'user[email]', with: "jsnow@gmail.com"
      fill_in 'user[password]', with: "something"
      fill_in 'user[password_confirmation]', with: "something"
      click_button "Create Account"
      expect(page).to have_css('li', text: "Email has already been taken")
    end


  end
end
