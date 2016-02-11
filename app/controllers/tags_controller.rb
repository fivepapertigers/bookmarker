class TagsController < ApplicationController

  before_filter :authenticate_user

  def show
    @tags = current_user.tags
    render json: @tags
  end

  def create
    tag = current_user.tags.create(tag_params)
    render json: tag
  end

  private

  def tag_params
    params.require(:tag).permit(:label)
  end

end