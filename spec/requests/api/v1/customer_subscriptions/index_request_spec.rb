require 'rails_helper'

RSpec.describe 'GET /customers/:customer_id/subscriptions' do 
  describe 'customer can receive all of their active and non active subscriptions' do
    it 'success' do 
      customer = Customer.create(first_name: "River", last_name: "Porter", email: "river@example.com", address: "123 Main St")
      subscription1 = Subscription.create(title: "Summer Collection", price: 30.50, status: "available", frequency: 30)
      subscription2 = Subscription.create(title: "Winter Collection", price: 25.99, status: "available", frequency: 30)
      subscription3 = Subscription.create(title: "Fall Collection", price: 25.99, status: "available", frequency: 30)
      tea1 = Tea.create(title: "Sleepy Time", description: "sleepy", temperature: 95, brew_time: 3)
      tea2 = Tea.create(title: "Ginger", description: "ginger", temperature: 90, brew_time: 5)
      tea3 = Tea.create(title: "Peppermint", description: "peppermint", temperature: 92, brew_time: 4)
      subscription1.teas << tea1
      subscription1.teas << tea2
      subscription2.teas << tea3
      subscription3.teas << tea3
      customer.subscriptions << subscription1
      customer.subscriptions << subscription2
      customer.customer_subscriptions.create(subscription_id: subscription3.id, active: false)

      get "/api/v1/customers/#{customer.id}/subscriptions"

      customer_subscriptions_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to be(200)
      expect(customer.subscriptions).to eq([subscription1, subscription2, subscription3])
      expect(customer_subscriptions_response[:data]).to be_an Array
      expect(customer_subscriptions_response[:data].size).to eq(3)
      expect(customer_subscriptions_response[:data][0][:id]).to eq(subscription1.id.to_s)
      expect(customer_subscriptions_response[:data][0][:type]).to eq("all_customer_subscriptions")
      expect(customer_subscriptions_response[:data][0][:attributes][:title]).to eq(subscription1.title)
      expect(customer_subscriptions_response[:data][0][:attributes][:price]).to eq(subscription1.price)
      expect(customer_subscriptions_response[:data][0][:attributes][:status]).to eq(subscription1.status)
      expect(customer_subscriptions_response[:data][0][:attributes][:frequency]).to eq(subscription1.frequency)
    end
  end
end