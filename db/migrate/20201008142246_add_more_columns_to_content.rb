class AddMoreColumnsToContent < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :style, :string
  end
end
