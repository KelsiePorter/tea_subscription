require 'rails_helper'

RSpec.describe 'PATCH /customers/:customer_id/subscriptions/:subscription_id' do 
  describe 'customer can unsubscribe from a tea subscription' do
    it 'success' do 
      customer = Customer.create(first_name: "River", last_name: "Porter", email: "river@example.com", address: "123 Main St")
      subscription1 = Subscription.create(title: "Summer Collection", price: 30.50, status: "available", frequency: 30)
      subscription2 = Subscription.create(title: "Winter Collection", price: 25.99, status: "available", frequency: 30)
      tea1 = Tea.create(title: "Sleepy Time", description: "sleepy", temperature: 95, brew_time: 3)
      tea2 = Tea.create(title: "Ginger", description: "ginger", temperature: 90, brew_time: 5)
      tea3 = Tea.create(title: "Peppermint", description: "peppermint", temperature: 92, brew_time: 4)
      subscription1.teas << tea1
      subscription1.teas << tea2
      subscription2.teas << tea3
      customer.subscriptions << subscription1
      customer.subscriptions << subscription2

      expect(customer.subscriptions.size).to eq(2)

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription2.id}"

      customer_subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to be(200)
      expect(customer.subscriptions.size).to eq(2)
      expect(customer_subscription_response[:message]).to be_a String
      expect(customer_subscription_response[:message]).to eq("Successfully unsubscribed from Winter Collection")
    end
  end
end