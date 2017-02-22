class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.string :professor
      t.string :time
      t.integer :capacity
      t.belongs_to :course, index: true
      t.belongs_to :semester, index: true

      t.timestamps null: false
    end
  end
end
