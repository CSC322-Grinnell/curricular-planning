class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_id
      t.string :title
      t.text :description
      t.boolean :required

      t.timestamps null: false
    end
  end
end
