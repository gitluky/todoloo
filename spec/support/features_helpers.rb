module FeaturesHelpers
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

  def create_announcement_from_group_page(group, title, content)
    visit group_path(group)
    click_link 'Post an Announcement'
    fill_in 'announcement[title]', with: title
    fill_in 'announcement[content]', with: content
    click_button 'Post Announcement'
  end

  def send_an_invitation(group, user)
    visit group_path(group)
    click_link 'Send an Invitation'
    expect(current_path).to eq(new_group_invitation_path(group))
    fill_in 'invitation[recipient_email]', with: user.email
    click_button 'Send Invite'
  end

end
