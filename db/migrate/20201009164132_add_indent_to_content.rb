class AddIndentToContent < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :indent, :integer, default: 0
  end
end
