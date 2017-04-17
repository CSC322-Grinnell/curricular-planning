class CreateOfferingsUsers < ActiveRecord::Migration
  def change
    create_table :offerings_users do |t|
      t.belongs_to :offering, index: true
      t.belongs_to :user, index: true
    end
  end
end
