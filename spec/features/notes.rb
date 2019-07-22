require 'rails_helper'

describe 'adding notes to tasks' do
  let(:attributes) do
    {
      name: 'Steve Rogers',
      email: 'srogers@gmail.com',
      password: 'password'
    }
  end

  let(:user) { User.create(attributes) }
  let!(:create_group1) do
    log_in_using_form(user.email, user.password)
    create_group('The Avengers', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end
  let(:group1) { Group.find_by(name: 'The Avengers') }

  it 'users can post a note to a task' do
    log_in_using_form(user.email, user.password)
    create_task_from_group_page(group1, 'Task 1', 'Lorem ipsum dolor description blah blah.')
    click_on(class: 'nav-item nav-link', text: 'View')
    click_on(class: 'nav-link dropdown-toggle', text: 'Add Note')
    fill_in  'note[content]', with: 'First Note'
    click_button 'Create Note'
    expect(page).to have_content('First Note')
  end

end
