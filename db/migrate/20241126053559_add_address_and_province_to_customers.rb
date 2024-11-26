class AddAddressAndProvinceToCustomers < ActiveRecord::Migration[7.0]
  def change
    # Add the address column only if it doesn't already exist
    unless column_exists?(:customers, :address)
      add_column :customers, :address, :string
    end

    # Add the province column only if it doesn't already exist
    unless column_exists?(:customers, :province)
      add_column :customers, :province, :string
    end
  end
end
