require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'presence validation' do
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:sent_at) }
  end

  describe 'should belong_to cars' do
    it { should belong_to(:car)}
  end
  
end
