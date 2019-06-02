class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.boolean :pending, default: true
      t.references :sender
      t.references :receiver 

      t.timestamps
    end
  end
end
