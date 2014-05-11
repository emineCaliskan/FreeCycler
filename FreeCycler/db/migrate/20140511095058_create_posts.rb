class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :bodyText
      t.boolean :isConfirmed
      t.boolean :isStillAvailable
      t.integer :user_id
      t.integer :postType

      t.timestamps
    end
  end
end
