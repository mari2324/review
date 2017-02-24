class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.integer :tag_id
      t.string :tag_name
    end
  end
end
