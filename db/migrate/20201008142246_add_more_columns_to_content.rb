class AddMoreColumnsToContent < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :filename, :string
    add_column :contents, :type, :string
  end
end
