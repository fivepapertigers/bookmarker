require 'uri'
class Bookmark < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags, before_add: :ensure_tag_user

  validates :name, presence: true
  validates :path, presence: true, format: /https?:\/\/.+/
  validates_presence_of :user

  def path=(str)
    write_attribute :path, URI.escape(str)
  end

  private

  def ensure_tag_user(tag)
    if user_id
      raise TagUserMismatch if tag.user_id && tag.user_id != user_id
      tag.user_id = user_id
    end
    true
  end

  class TagUserMismatch < StandardError
  end
end
