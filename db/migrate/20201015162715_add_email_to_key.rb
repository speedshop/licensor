class AddEmailToKey < ActiveRecord::Migration[6.0]
  def change
    add_column :license_keys, :email, :string
  end
end
