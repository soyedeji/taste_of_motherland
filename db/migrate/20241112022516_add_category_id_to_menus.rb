class AddCategoryIdToMenus < ActiveRecord::Migration[7.2]
  def change
    add_column :menus, :category_id, :integer
  end
end
