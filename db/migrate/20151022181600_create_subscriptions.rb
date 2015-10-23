class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
