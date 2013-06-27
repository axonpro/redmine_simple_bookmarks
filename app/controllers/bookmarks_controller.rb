  class BookmarksController < ApplicationController
    unloadable

    before_filter :find_bookmark, :only => [:edit, :update, :destroy]

    helper_method :placements

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
      @bookmark.remove_from_menu
      if @bookmark.update_attributes(params[:bookmark])
        redirect_to my_account_path
      else
        render 'edit'
      end
    end

    def destroy
      @bookmark.remove_from_menu
      @bookmark.destroy
      redirect_to my_account_path
    end

    def placements
      Bookmark.human_placements.map { |k, v| [v, k] }
    end

    private

    def find_bookmark
      @bookmark = User.current.bookmarks.find(params[:id])
    end
  end
