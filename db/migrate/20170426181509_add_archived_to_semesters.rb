class AddArchivedToSemesters < ActiveRecord::Migration
  def change
    add_column :semesters, :archived, :boolean
  end
end
