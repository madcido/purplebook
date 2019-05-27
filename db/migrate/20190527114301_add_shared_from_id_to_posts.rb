class AddSharedFromIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :shared_from_id, :integer
  end
end
