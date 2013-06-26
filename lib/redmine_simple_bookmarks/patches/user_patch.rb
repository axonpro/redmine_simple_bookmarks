require 'user'
#require 'bookmark'

module RedmineSimpleBookmarks::Patches::UserPatch
  extend ActiveSupport::Concern

  included do
    has_many :bookmarks
  end
end

unless User.included_modules.include?(RedmineSimpleBookmarks::Patches::UserPatch)
  User.send :include, RedmineSimpleBookmarks::Patches::UserPatch
end
