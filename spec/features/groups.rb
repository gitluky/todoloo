require 'rails_helper'
describe "my groups", type: :feature do

  let(:attributes) do
    {
      name: 'Jon Snow',
      email: 'jsnow@gmail.com',
      password: 'password'
    }
  end

  let(:user) { User.create(attributes)}

  it "users can navigate to the My Groups page and see all the groups they belong to" do
    log_in_using_form(user.email, user.password)
    create_group('The North', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    create_group('The Starks', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
    create_group("The Nights Watch", 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')

    visit groups_path
    expect(page).to have_content('The North')
    expect(page).to have_content('The Starks')
    expect(page).to have_content("The Nights Watch")
  end

end

# "all members can see the group page"
# "admin users can edit and delete group"
# "non-admin users cannot edit or delete a group"
# "users cannot view group pages that they are not a member of"
# "users cannot post announcements for a group that they are not a member of"
