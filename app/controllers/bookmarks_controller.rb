class BookmarksController < ApplicationController
  
  before_filter :authenticate_user

  def index
    bookmarks = current_user.bookmarks.order('created_at DESC')
    render json: bookmarks, include: :tags
  end

  def create
    bookmark = current_user.bookmarks.create(bookmark_params)
    render json: bookmark, include: :tags
  end

  def update
    bookmark = Bookmark.update(params[:id], {tag_ids: []}.merge(bookmark_params))
    render json: bookmark, include: :tags
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy!
    render nothing: true, status: 200
  end

  protected

  def bookmark_params
    params.require(:bookmark).permit(:path, :name, tag_ids: [])
  end
end
