class AddInterestsToUsers < ActiveRecord::Migration
  def change
    create_join_table :users, :offerings, table_name: :interests
  end
end
