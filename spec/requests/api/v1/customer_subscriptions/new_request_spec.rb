require 'rails_helper'

RSpec.describe 'POST /customers/:customer_id/subscriptions/:subscription_id' do 
  describe 'customer can subscribe to tea subscription' do
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

      expect(CustomerSubscription.count).to eq(0)

      post "/api/v1/customers/#{customer.id}/subscriptions/#{subscription1.id}"

      customer_subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to be(201)
      expect(CustomerSubscription.count).to eq(1)

      customer_sub = CustomerSubscription.last

      expect(customer_sub.customer_id).to eq(customer.id)
      expect(customer_sub.subscription_id).to eq(subscription1.id)
      expect(customer.subscriptions.size).to eq(1)
      
      expect(customer_subscription_response[:data]).to be_a Hash
      expect(customer_subscription_response[:data][:type]).to eq("customer_subscription")
      expect(customer_subscription_response[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(customer_subscription_response[:data][:attributes][:subscription_id]).to eq(subscription1.id)
      expect(customer_subscription_response[:data][:attributes][:active]).to be true
    end

    it 'sad path - customer cannot subscribe to a subscription more than once' do 
      customer = Customer.create(first_name: "River", last_name: "Porter", email: "river@example.com", address: "123 Main St")
      subscription1 = Subscription.create(title: "Summer Collection", price: 30.50, status: "available", frequency: 30)
      tea1 = Tea.create(title: "Sleepy Time", description: "sleepy", temperature: 95, brew_time: 3)
      tea2 = Tea.create(title: "Ginger", description: "ginger", temperature: 90, brew_time: 5)
      subscription1.teas << tea1
      subscription1.teas << tea2

      post "/api/v1/customers/#{customer.id}/subscriptions/#{subscription1.id}"

      expect(CustomerSubscription.count).to eq(1)

      post "/api/v1/customers/#{customer.id}/subscriptions/#{subscription1.id}"

      customer_subscription_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to be(200)
      expect(CustomerSubscription.count).to eq(1)
      
      expect(customer_subscription_response).to be_a Hash
      expect(customer_subscription_response[:error]).to eq("Customer is already subscribed to this tea subscription")
    end
  end
end