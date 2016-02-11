class TagsController < ApplicationController

  before_filter :authenticate_user

  def index
    @tags = current_user.tags
    render json: @tags
  end

  def create
    tag = current_user.tags.create(tag_params)
    flash.now[:success] = "You've successfully created the \"#{tag.label}\" tag."
    render json: tag
  end

  def destroy
    tag = Tag.find(params[:id])
    flash.now[:success] = "You've successfully removed the \"#{tag.label}\" tag."
    tag.destroy
    render nothing: true, status: 200
  end

  private

  def tag_params
    params.require(:tag).permit(:label)
  end

end