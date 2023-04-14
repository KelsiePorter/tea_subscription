class CustomerSubscription < ApplicationRecord 
  belongs_to :customer 
  belongs_to :subscription

  validates_presence_of :customer_id, :subscription_id

  validate :validate_unique_subscription

  private

  def validate_unique_subscription
    duplicates = CustomerSubscription.where(
      customer_id: self.customer_id, 
      subscription_id: self.subscription_id
    )
    
    if duplicates.size > 0
      errors.add(:customer, "is already subscribed to this tea subscription")
    end
  end
end