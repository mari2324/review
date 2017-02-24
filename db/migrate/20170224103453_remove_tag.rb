class RemoveTag < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :tag
  end
end
