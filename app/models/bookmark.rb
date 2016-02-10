class Bookmark < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags, before_add: :ensure_tag_user

  validates :name, presence: true
  validates :path, presence: true
  validates_associated :user

  private

  def ensure_tag_user(tag)
    raise if tag.user_id && tag.user_id != user_id
    tag.user_id = user_id
  end
end
