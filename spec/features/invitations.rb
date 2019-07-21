require "rails_helper"

describe "sending and responding to invitations" do

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

  let(:attributes3) do
    {
      name: 'Sansa Stark',
      email: 'sstark@gmail.com',
      password: 'password'
    }
  end

  let(:user) { User.create(attributes)}
  let(:user2) { User.create(attributes2)}
  let(:user3) { User.create(attributes3)}

  let!(:create_group1) do
    log_in_using_form(user.email, user.password)
    create_group('The North', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')
  end
  let(:group1) { Group.find_by(name: 'The North') }

  it "users can send invitations to another user" do
    log_in_using_form(user.email, user.password)
    send_an_invitation(group1, user2)
    expect(page).to have_content('Invitation Sent.')
  end

  it "users cannot send invitations from a group that they are not a member of" do
    log_in_using_form(user2.email, user2.password)
    visit new_group_invitation_path(group1)
    expect(current_path).to eq(root_path)
  end

  it "users can accept an invitation and join a group" do
    log_in_using_form(user.email, user.password)
    send_an_invitation(group1, user2)
    visit logout_path
    log_in_using_form(user2.email, user2.password)
    click_link 'Accept'
    expect(current_path).to eq(group_path(group1))
  end

  it "users can decline an invitation and the invitation is deleted" do
    log_in_using_form(user.email, user.password)
    send_an_invitation(group1, user2)
    visit logout_path
    log_in_using_form(user2.email, user2.password)
    click_link 'Decline'
    visit logout_path
    log_in_using_form(user.email, user.password)
    visit group_path(group1)
    expect(page).to_not have_link 'Cancel Invitation'
  end

  it "the sender can cancel the sent invitation from the group page" do
    group1.users << user3
    log_in_using_form(user.email, user.password)
    send_an_invitation(group1, user2)
    visit logout_path
    log_in_using_form(user3.email, user3.password)
    visit group_path(group1)
    expect(page).to_not have_link 'Cancel Invitation'
  end

  it "admins can cancel any invitation from the group page" do
    log_in_using_form(user.email, user.password)
    send_an_invitation(group1, user2)
    visit group_path(group1)
    expect(page).to have_link 'Cancel Invitation'
  end

end
