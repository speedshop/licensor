class AddEmailChangedBoolean < ActiveRecord::Migration[6.0]
  def change
    add_column :license_keys, :email_changed, :boolean, default: false
  end
end
