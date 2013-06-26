  class BookmarksController < ApplicationController
    unloadable

    before_filter :find_bookmark, :only => [:edit, :update, :destroy]

    def new
      @bookmark = Bookmark.new(:url => request.env["HTTP_REFERER"])
    end

    def create
      @bookmark = User.current.bookmarks.new(params[:bookmark])
      if @bookmark.save
        redirect_to @bookmark.url
      end
    end

    def edit
    end

    def update
      Redmine::MenuManager.map(:top_menu).delete(@bookmark.name.to_sym)
      if @bookmark.update_attributes(params[:bookmark])
        redirect_to my_account_path
      else
        render 'edit'
      end
    end

    def destroy
      Redmine::MenuManager.map(:top_menu).delete(@bookmark.name.to_sym)
      @bookmark.destroy
      redirect_to my_account_path
    end

    private

    def find_bookmark
      @bookmark = User.current.bookmarks.find(params[:id])
    end
  end
