require 'rails_helper'

describe 'group announcements' do

  let(:attributes) do
    {
      name: 'Jon Snow',
      email: 'jsnow@gmail.com',
      password: 'password',
    }
  end

  let(:attributes2) do
    {
      name: 'Arya Stark',
      email: 'astark@gmail.com',
      password: 'password'
    }
  end

  let(:user) { User.create(attributes)}
  let(:user2) { User.create(attributes2)}
  let!(:create_group1) do
    log_in_using_form(user.email, user.password)
    create_group('The North', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end
  let(:group1) { Group.find_by(name: 'The North') }

  it "user can post announcements" do
    log_in_using_form(user.email, user.password)
    create_announcement_from_group_page(group1, 'Announcement Title', 'Posting an announcement and this is the content of the announcement.')
    expect(page).to have_content('Posting an announcement and this is the content of the announcement.')
  end

  it "user can see edit and delete links for their own announcements" do
    log_in_using_form(user.email, user.password)
    create_announcement_from_group_page(group1, 'Announcement Title', 'Posting an announcement and this is the content of the announcement.')
    expect(page).to have_css('a.mr-5', text: 'Edit')
    expect(page).to have_css( "a[data-method='delete']", text: 'Delete')
  end

  it "user cannot edit announcements created by another user" do
    log_in_using_form(user.email, user.password)
    create_announcement_from_group_page(group1, 'Announcement Title', 'Posting an announcement and this is the content of the announcement.')
    visit logout_path
    group1.users << user2
    log_in_using_form(user2.email, user2.password)
    visit group_path(group1)
    expect(page).to have_content('Posting an announcement and this is the content of the announcement.')
    expect(page).to_not have_css('a.mr-5', text: 'Edit')
    expect(page).to_not have_css( "a[data-method='delete']", text: 'Delete')
  end

  it "admin can edit all announcements" do
    group1.users << user2
    log_in_using_form(user2.email, user2.password)
    create_announcement_from_group_page(group1, 'Announcement Title', 'Posting an announcement and this is the content of the announcement.')
    visit logout_path
    log_in_using_form(user.email, user.password)
    visit group_path(group1)
    expect(page).to have_css('a.mr-5', text: 'Edit')
    expect(page).to have_css( "a[data-method='delete']", text: 'Delete')
  end

  it "user can edit the announcement" do
    log_in_using_form(user.email, user.password)
    visit group_path(group1)
    announcement = Announcement.find_by(title: "Welcome!")
    find("a", class: "mr-5", text: "Edit").click
    expect(current_path).to eq(edit_group_announcement_path(group1, announcement))
    fill_in 'announcement[title]', with: 'Updated Announcement'
    fill_in 'announcement[content]', with: 'This announcement has been updated.'
    click_button 'Post Announcement'
    expect(current_path).to eq(group_path(group1))
    expect(page).to have_content('This announcement has been updated.')
  end

end
