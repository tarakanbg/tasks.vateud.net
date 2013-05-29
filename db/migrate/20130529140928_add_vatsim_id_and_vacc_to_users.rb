class AddVatsimIdAndVaccToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vatsimid, :integer
    add_column :users, :vacc, :string
  end
end
