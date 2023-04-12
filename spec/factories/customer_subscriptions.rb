FactoryBot.define do
  factory :customer_subscription do
    active { false }
    customers { nil }
    subscriptions { nil }
  end
end
