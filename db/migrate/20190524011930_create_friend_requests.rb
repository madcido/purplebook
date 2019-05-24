class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.boolean :accepted, default: false
      t.boolean :blocked, default: false
      t.boolean :pending, default: true
      t.references :sender
      t.references :receiver 

      t.timestamps
    end
  end
end
