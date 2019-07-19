module SessionHelpers
  def log_in_using_form(email, password)
    visit login_path
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Login'
  end

  def create_group(name, description)
    visit new_group_path
    fill_in 'group[name]', with: name
    fill_in 'group[description]', with: description
    click_button 'Create Group'
  end
end
