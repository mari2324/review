class CreateReviewTags < ActiveRecord::Migration[5.0]
  def change
    create_table :review_tags do |t|
      t.integer :tag_id
      t.integer :review_id
    end
  end
end
