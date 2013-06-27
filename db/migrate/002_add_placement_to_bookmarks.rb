class AddPlacementToBookmarks < ActiveRecord::Migration
  def change
    add_column :rsb_bookmarks, :placement, :integer, :default => 0
  end
end
