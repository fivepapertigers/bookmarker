class TagsController < ApplicationController

  before_filter :authenticate_user

  def index
    @tags = current_user.tags
    render json: @tags
  end

  def create
    tag = current_user.tags.create(tag_params)
    render json: tag
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    render nothing: true, status: 200
  end

  private

  def tag_params
    params.require(:tag).permit(:label)
  end

end