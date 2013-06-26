Redmine::Plugin.register :redmine_simple_bookmarks do
  name 'Redmine Simple Bookmarks plugin'
  author 'Juraj Sujan aka shivo, AXON PRO s.r.o.'
  description 'Simple bookmarking inside redmine'
  version '0.0.1'
  url 'https://github.com/axonpro/redmine_simple_bookmarks'
  author_url 'https://github.com/axonpro'

  menu :account_menu, :add_bookmark, { :controller => 'bookmarks', :action => 'new' }, :first => true
end

require_dependency 'redmine_simple_bookmarks/patches/user_patch'

module RedmineSimpleBookmarks
  module Hooks
    class MenuHook < Redmine::Hook::ViewListener
      def view_layouts_base_html_head(context)
        Redmine::MenuManager.map :top_menu do |menu|
          User.current.bookmarks.each do |bookmark|
            menu.push bookmark.name.to_sym, bookmark.url, :caption => bookmark.name, :last => true unless menu.find bookmark.name.to_sym
          end
        end
        nil
      end
    end

    class MyAccountHook < Redmine::Hook::ViewListener
      def view_layouts_base_content(context={})
        if context[:controller] && context[:controller].is_a?(MyController) && context[:controller].action_name == 'account'
          context[:bookmarks] = User.current.bookmarks
          return context[:controller].send(:render_to_string, {
            :partial => "bookmarks/index",
            :locals => context
          })
        end
        return ''
      end
    end
  end
end
