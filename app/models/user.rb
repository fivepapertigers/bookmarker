class User < ActiveRecord::Base
  has_many :bookmarks, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :github_id, presence: true
  validates :name, presence: true

  def self.find_or_create_from_auth_hash(auth_hash={})
    return false if auth_hash.empty?
    github_id = auth_hash['uid']
    users = User.where(github_id: github_id)
    if users.empty?
      User.create(github_id: github_id, name: auth_hash['info']['name'])
    else
      users.first
    end
  end

end
