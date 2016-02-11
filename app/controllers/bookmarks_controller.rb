class BookmarksController < ApplicationController
  
  before_filter :authenticate_user

  def show
    bookmarks = current_user.bookmarks.order('created_at DESC')
    render json: bookmarks, include: {tags: {only: :id}}
  end

  def create
    bookmark = current_user.bookmarks.create(bookmark_params)
    render json: bookmark, include: {tags: {only: :id}}
  end

  protected

  def bookmark_params
    params.require(:bookmark).permit(:path, :name)
  end
end
