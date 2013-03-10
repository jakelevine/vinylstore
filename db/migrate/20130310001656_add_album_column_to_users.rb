class AddAlbumColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :albumHash, :text, :limit => nil
  end
end
