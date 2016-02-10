class Tag < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :bookmarks, before_add: :ensure_bookmark_user

  validates :label, presence: true
  validates_associated :user

  private

  def ensure_bookmark_user(bm)
    raise BookmarkUserMismatch if bm.user_id && bm.user_id != user_id
    bm.user_id = user_id
  end

  class BookmarkUserMismatch < StandardError
  end
end

