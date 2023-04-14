require 'rails_helper'

RSpec.describe CustomerSubscription do 
  describe 'associations' do 
    it { should belong_to(:customer) }
    it { should belong_to(:subscription) }
  end

  describe 'validations' do 
    it {should validate_presence_of(:customer_id) }
    it {should validate_presence_of(:subscription_id) }
  end

  describe '#validate_unique_subscription' do 
    it 'validates that a customer can only subscribe to a subscription one time' do 
      customer = Customer.create(first_name: "River", last_name: "Porter", email: "river@example.com", address: "123 Main St")
      subscription1 = Subscription.create(title: "Summer Collection", price: 30.50, status: "available", frequency: 30)
      tea1 = Tea.create(title: "Sleepy Time", description: "sleepy", temperature: 95, brew_time: 3)
      tea2 = Tea.create(title: "Ginger", description: "ginger", temperature: 90, brew_time: 5)
      subscription1.teas << tea1
      subscription1.teas << tea2
      customer.subscriptions << subscription1

      expect(customer.subscriptions).to eq([subscription1])
      expect(customer.subscriptions.size).to eq([1)

      customer.subscriptions << subscription1

      expect(customer.subscriptions).to eq([subscription1])
      expect(customer.subscriptions.size).to eq([1)
    end
  end
end