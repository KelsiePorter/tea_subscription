require 'rails_helper'

RSpec.describe CustomerSubscription do 
  describe 'associations' do 
    it { should belong_to(:customer) }
    it { should belong_to(:subscription) }
  end

  describe 'validations' do 
    it {should validate_presence_of(:customer_id) }
    it {should validate_presence_of(:subscription_id) }
    it {should validate_presence_of(:active) }
  end
end