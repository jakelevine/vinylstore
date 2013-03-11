class AddShortNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shortname, :string
  end
end
