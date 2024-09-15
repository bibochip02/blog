require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'associations' do
    it { should have_many(:brands) }
  end
end
