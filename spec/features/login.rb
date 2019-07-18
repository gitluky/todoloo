require 'rails_helper'

describe 'login' do
  let(:attributes) do
    {
      name: 'Jon Snow',
      email: 'jsnow@gmail.com',
      password: 'password',
    }
  end

  let(:user) { User.create(attributes)}

  it "user can log in with valid credentials" do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Login'
    expect(page).to have_css('h3', text: user.name)
  end

  it "user is returned to login page when an invalid password is entered" do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'wrongpassword'
    click_button 'Login'
    expect(current_path).to eq(login_path)
  end


end
