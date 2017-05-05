class AddSectionToOffering < ActiveRecord::Migration
  def change
    add_column :offerings, :section, :integer
  end
end
