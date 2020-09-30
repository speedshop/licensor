class AddLicenseKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :license_keys do |t|
      t.string :key, null: false
      t.index :key, unique: true
      t.timestamps
    end
  end
end
