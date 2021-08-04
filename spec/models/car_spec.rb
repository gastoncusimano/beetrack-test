require 'rails_helper'

RSpec.describe Car, type: :model do
  describe 'presence validation' do
    it { should validate_presence_of(:licence_plate) }
  end

  describe 'uniqueness licence_plate validation' do
    it { should validate_uniqueness_of(:licence_plate) }
  end

  describe 'should have many locations' do
    it { should have_many(:locations)}
  end
end
