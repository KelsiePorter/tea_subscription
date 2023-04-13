class CreateCustomerSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_subscriptions do |t|
      t.belongs_to :customer, null: false, foreign_key: true
      t.belongs_to :subscription, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
