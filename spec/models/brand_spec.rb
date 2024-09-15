require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe 'associations' do
    it { should belong_to(:country) }
  end
end
