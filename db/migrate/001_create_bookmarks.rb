class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :rsb_bookmarks do |t|
      t.string :name
      t.string :url
      t.references :user
    end
  end
end
