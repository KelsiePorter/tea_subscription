class Api::V1::CustomersController < ApplicationController
  before_action :find_customer
  before_action :find_subscription, only: [:subscribe, :unsubscribe]

  def index
    all_subscriptions = @customer.subscriptions.uniq

    render json: AllCustomerSubscriptionsSerializer.new(all_subscriptions), status: 200
  end

  def subscribe 
    customer_sub = @customer.customer_subscriptions.new(subscription_id: @subscription.id)

    if customer_sub.save 
      render json: CustomerSubscriptionSerializer.new(customer_sub), status: 201
    else
      render json: {error: customer_sub.errors.full_messages.to_sentence}
    end
  end

  def unsubscribe
    @customer.customer_subscriptions
             .where(subscription_id: @subscription.id)
             .first
             .update(active: false)

   render json: { message: "Successfully unsubscribed from #{@subscription.title}" }, status: 200 
  # Does not account for if a customer wants to re-subscribe. Would use a
  # conditional to handle that if that feature was added in the future
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