require 'rails_helper'
describe "my groups", type: :feature do

  let(:attributes1) do
    {
      name: 'Jon Snow',
      email: 'jsnow@gmail.com',
      password: 'password'
    }
  end

  let(:attributes2) do
    {
      name: 'Arya Stark',
      email: 'astark@gmail.com',
      password: 'password'
    }
  end

  let(:user) { User.create(attributes1)}
  let(:user2) { User.create(attributes2)}
  let!(:group1) do
    log_in_using_form(user.email, user.password)
    create_group('The North', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end
  let!(:group2) do
    log_in_using_form(user.email, user.password)
    create_group('The Starks', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end
  let!(:group3) do
    log_in_using_form(user.email, user.password)
    create_group("The Nights Watch", 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end

  it "users can navigate to the My Groups page and see all the groups they belong to" do
    log_in_using_form(user.email, user.password)
    visit groups_path
    expect(page).to have_content('The North')
    expect(page).to have_content('The Starks')
    expect(page).to have_content("The Nights Watch")
  end

  it "users can visit the page of a group in which they are a member of" do
    log_in_using_form(user.email, user.password)
    group2 = Group.find_by(name: 'The Starks')
    visit groups_path
    click_link 'The Starks'
    expect(current_path).to eq(group_path(group2))
  end

  it "users cannot visit the page of a group in which they are not a member of" do
    log_in_using_form(user2.email, user2.password)
    group3 = Group.find_by(name: 'The Nights Watch')
    visit group_path(group3)
    expect(current_path).to eq(root_path)
  end

  it "admin users can see 'Edit Group' and 'Delete Group' links" do
    log_in_using_form(user.email, user.password)
    group1 = Group.find_by(name: 'The North')
    visit group_path(group1)
    expect(page).to have_selector(:link, 'Edit Group')
    expect(page).to have_selector(:link, 'Delete Group')
  end

  it "non-admin users cannot see 'Edit Group' and 'Delete Group' links" do
    log_in_using_form(user2.email, user2.password)
    group1 = Group.find_by(name: 'The North')
    visit group_path(group1)
    expect(page).to_not have_selector(:link, 'Edit Group')
    expect(page).to_not have_selector(:link, 'Delete Group')
  end

end
