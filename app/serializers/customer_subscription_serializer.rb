class CustomerSubscriptionSerializer 
  include JSONAPI::Serializer 

  attributes :customer_id,
             :subscription_id,
             :active
end