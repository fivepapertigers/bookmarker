FactoryGirl.define do

  sequence(:github_id) { SecureRandom.random_number(1_000_000_000).to_s }
  sequence(:name_for_user) { |n| "Test User #{n}"}
  
  factory :user do
    name { generate(:name_for_user) }
    github_id { generate(:github_id) }
  end

  factory :tag do
    sequence(:label) { |n| "Test Tag #{n}" }
  end

  factory :github_auth_hash, class: OmniAuth::AuthHash do
    skip_create
    uid { generate(:github_id) }
    info { {name: generate(:name_for_user)} }
  end


  factory :bookmark do
    sequence(:name) { |n| "Test Bookmark Name #{n}" }
    path "http://github.com/fivepapertigers"
  end

end