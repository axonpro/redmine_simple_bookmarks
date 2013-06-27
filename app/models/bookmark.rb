#module RedmineSimpleBookmarks
  class Bookmark < ActiveRecord::Base
    self.table_name = "rsb_bookmarks"
    unloadable

    belongs_to :user

    enum_accessor :placement, [:top_menu, :account_menu, :application_menu]

    def symbolized_name
      "rsb_#{self.name}".to_sym
    end

    def push_into_menu
      unless Redmine::MenuManager.map(self.placement).exists? self.symbolized_name
        Redmine::MenuManager.map(self.placement).push self.symbolized_name, self.url, :caption => self.name, :last => true
      end
    end

    def remove_from_menu
      Redmine::MenuManager.map(self.placement).delete self.symbolized_name
    end
  end
#end
