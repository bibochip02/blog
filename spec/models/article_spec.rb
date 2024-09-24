require 'rails_helper'

describe Article, type: :model do
  describe 'methods' do
    describe '#even?' do
      it { expect(Article.new.even?).to be_in([true, false]) }
    end
  end
end
