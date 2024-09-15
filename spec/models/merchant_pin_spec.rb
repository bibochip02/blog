require 'rails_helper'

RSpec.describe MerchantPin, type: :model do
  describe 'associations' do
    it { should belong_to(:brand) }
  end
end
