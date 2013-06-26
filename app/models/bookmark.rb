#module RedmineSimpleBookmarks
  class Bookmark < ActiveRecord::Base
    self.table_name = "rsb_bookmarks"
    unloadable

    belongs_to :user
  end
#end
