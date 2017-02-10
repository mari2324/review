class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :content
      t.timestamps null: false
      t.integer :user_id
    end
  end
end
