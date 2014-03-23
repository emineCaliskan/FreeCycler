class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      #t.integer :id
      t.string :name
      t.string :email
      t.string :password
      t.boolean :isBanned
      t.string :profilePhotoUrl
      t.integer :roleId

      t.timestamps
    end
  end
end
