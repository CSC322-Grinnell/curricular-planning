class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.string :professor
      t.string :time
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
