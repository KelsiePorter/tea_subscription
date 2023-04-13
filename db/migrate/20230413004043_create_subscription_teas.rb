class CreateSubscriptionTeas < ActiveRecord::Migration[6.0]
  def change
    create_table :subscription_teas do |t|
      t.belongs_to :subscription, null: false, foreign_key: true
      t.belongs_to :tea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
