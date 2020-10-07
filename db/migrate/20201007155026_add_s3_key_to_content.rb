class AddS3KeyToContent < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :s3_key, :string
  end
end
