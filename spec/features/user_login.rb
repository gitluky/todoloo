require 'rails_helper'

describe 'login', type: :feature do
  let(:attributes) do
    {
      name: 'Jon Snow',
      email: 'jsnow@gmail.com',
      password: 'password',
    }
  end

  let(:user) { User.create(attributes)}

  it "user can log in with valid credentials and the user feed is displayed" do
    log_in_using_form(user.email, user.password)
    expect(page).to have_css('h3', text: user.name)
  end

  it "user is returned to login page when an invalid password is entered" do
    log_in_using_form(user.email, 'wrongpassword')
    expect(current_path).to eq(login_path)
  end


end
