class CreateCustomerSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :customer_subscriptions do |t|
      t.boolean :active
      t.references :customers, null: false, foreign_key: true
      t.references :subscriptions, null: false, foreign_key: true

      t.timestamps
    end
  end
end
