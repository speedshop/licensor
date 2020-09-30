class AddLicenseKeys < ActiveRecord::Migration[6.0]
  def change
    create_table :license_keys do |t|
      t.string :key
      t.index :key
      t.timestamps
    end
  end
end
