require 'rails_helper'
RSpec.describe User, :type => :model do
  it "should be invalid if github_id is missing" do
    user = build(:user)
    user.github_id = nil
    expect(user.valid?).to be false
  end

  it "should be invalid if name is missing" do
    user = build(:user)
    user.name = nil
    expect(user.valid?).to be false
  end

  context 'find_or_create_from_auth_hash method' do
    
    before(:each) do
      @auth_hash = attributes_for(:github_auth_hash).with_indifferent_access
    end

    it "should successfully create a user from an auth hash" do
      user = User.find_or_create_from_auth_hash(@auth_hash)
      expect(user.id).not_to be_nil
      expect(user.valid?).to be true
    end

    it "should return false if a hash is empty" do
      user = User.find_or_create_from_auth_hash({})
      expect(user).to be false
    end

    it "should return existing user if github uid is already in system" do
      existing_user = create(:user)
      expect(existing_user.id)

      @auth_hash['uid'] = existing_user.github_id
      retrieved_user = User.find_or_create_from_auth_hash(@auth_hash)
      expect(retrieved_user).to eq existing_user
    end

  end


  context 'with tags' do

    it "should create a tag for User" do
      user = create(:user)
      user.tags.create(attributes_for(:tag))
      user.save!
      expect(user.valid?)
      expect(user.tags.count).to eq 1
    end

    it "should fail to save user with invalid tag" do
      user = create(:user)
      user.tags.build()
      expect{user.save!}.to raise_error ActiveRecord::RecordInvalid
    end

  end

  context 'with tags' do

    it "should create a bookmark for User" do
      user = create(:user)
      user.bookmarks.create(attributes_for(:bookmark))
      user.save!
      expect(user.valid?)
      expect(user.bookmarks.count).to eq 1
    end

    it "should fail to save user with invalid bookmark" do
      user = create(:user)
      user.bookmarks.build()
      expect{user.save!}.to raise_error ActiveRecord::RecordInvalid
    end

  end

end