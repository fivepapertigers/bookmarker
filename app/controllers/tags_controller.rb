class TagsController < ApplicationController
  def index
  end

  def list
  end

  def create
    tag = Tag.new()

  end

  private

  def tag_params
    params.require(:tag).permit(:label)  
  end

end