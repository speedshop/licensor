class AddProductToContent < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :product, :integer, default: 0
    add_column :license_keys, :product, :integer, default: 0
  end
end
