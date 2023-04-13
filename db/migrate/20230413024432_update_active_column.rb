class UpdateActiveColumn < ActiveRecord::Migration[6.0]
  def change
    change_column(:customer_subscriptions, :active, :boolean, default: true)
  end
end
