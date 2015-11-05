class RenameListings < ActiveRecord::Migration
  def change
  	rename_table :listings, :projects
  end
end
