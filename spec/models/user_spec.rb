require 'rails_helper'

  describe User do
    it 'can be created' do
      user = User.new(email: 'something@gmail.com', password: 'password', name: 'Bob')
      expect(user).to be_valid
    end

  end
