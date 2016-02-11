class Bookmark < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags, before_add: :ensure_tag_user

  validates :name, presence: true
  validates :path, presence: true, format: /https?:\/\/.+/
  validates_presence_of :user

  private

  def ensure_tag_user(tag)
    raise TagUserMismatch if tag.user_id && tag.user_id != user_id
    tag.user_id = user_id
  end

  class TagUserMismatch < StandardError
  end
end
