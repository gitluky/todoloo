require 'rails_helper'

class GroupTest < ActiveSupport::TestCase
  describe Group do
    it 'can be created' do
      g = Group.new
      expect(g).to be_valid
    end


  end
end
