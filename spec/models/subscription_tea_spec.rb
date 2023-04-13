require 'rails_helper'

RSpec.describe SubscriptionTea do 
  describe 'associations' do 
    it { should belong_to(:tea) }
    it { should belong_to(:subscription) }
  end

  describe 'validations' do 
    it {should validate_presence_of(:subscription_id) }
    it {should validate_presence_of(:tea_id) }
  end
end