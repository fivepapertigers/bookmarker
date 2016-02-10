class User < ActiveRecord::Base
  has_many :bookmarks, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :github_id, presence: true
  validates :name, presence: true

  def self.find_or_create_from_auth_hash(auth_hash)
    github_id = auth_hash['uid']
    user = User.where(github_id: github_id)
    if user.empty?
      user = User.new(github_id: github_id, name: auth_hash['name'])
    end
  end

end
