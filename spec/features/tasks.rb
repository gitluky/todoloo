require 'rails_helper'

describe 'creating and editing tasks' do
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
    create_group('The North', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end
  let(:group1) { Group.find_by(name: 'The North') }

  it 'users can create tasks from the group page' do
    log_in_using_form(user.email, user.password)
    create_task_from_group_page(group1, 'Task 1', 'Lorem ipsum dolor description blah blah.')
    expect(page).to have_css('h5.card-title', text: 'Task 1')
  end

  it 'users can edit task from group page with the edit dropdown' do
    log_in_using_form(user.email, user.password)
    create_task_from_group_page(group1, 'Task 1', 'Lorem ipsum dolor description blah blah.')
    click_on(class: 'nav-link dropdown-toggle px-2', text: 'Edit')
    find_field('task[name]', with: 'Task 1').set("Task Edit 1")
    click_button 'Update'
    expect(page).to have_css('h5.card-title', text: 'Task Edit 1')
  end

  it 'users can volunteer and drop a task' do
    log_in_using_form(user.email, user.password)
    create_task_from_group_page(group1, 'Task 1', 'Lorem ipsum dolor description blah blah.')
    click_on(class: 'nav-item nav-link px-2', text: 'Volunteer')
    expect(page).to have_css("a.nav-item.nav-link.px-2", text: 'Drop')
    expect(page).to_not have_css("a.nav-item.nav-link.px-2", text: 'Volunteer')
    click_on(class: 'nav-item nav-link px-2', text: 'Drop')
    expect(page).to have_css("a.nav-item.nav-link.px-2", text: 'Volunteer')
  end

end
