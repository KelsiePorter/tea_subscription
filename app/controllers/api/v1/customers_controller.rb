class Api::V1::CustomersController < ApplicationController
  before_action :find_customer
  before_action :find_subscription, only: :subscribe

  def subscribe 
    @customer.subscriptions << @subscription
    customer_sub = @customer.customer_subscriptions.last

    render json: CustomerSubscriptionSerializer.new(customer_sub), status: 201
  end

  private

  def permitted_params
    params.permit(:customer_id, :subscription_id)
  end

  def find_customer
    @customer = Customer.find(permitted_params[:customer_id])
  end

  def find_subscription
    @subscription = Subscription.find(permitted_params[:subscription_id])
  end

end