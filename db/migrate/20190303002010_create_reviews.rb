class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :stars
      t.integer :user_id
      t.integer :book_id
    end
  end
end
