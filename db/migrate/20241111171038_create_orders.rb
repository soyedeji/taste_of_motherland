class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.date :order_date
      t.decimal :total_amount
      t.string :status

      t.timestamps
    end
  end
end
