class CreateMenus < ActiveRecord::Migration[7.2]
  def change
    create_table :menus do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :category
      t.boolean :availability_status

      t.timestamps
    end
  end
end
