class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.boolean :friend, default: false
      t.boolean :block, default: false
      t.boolean :pending, default: true
      t.references :sender
      t.references :receiver 

      t.timestamps
    end
  end
end
