class CreateContent < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :title, null: false
      t.integer :position
      t.timestamps
    end
  end
end
