class AddTagId < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :tag_id, :integer
  end
end
