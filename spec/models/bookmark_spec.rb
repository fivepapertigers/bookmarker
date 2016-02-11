require 'rails_helper'

RSpec.describe Bookmark, type: :model do

  before(:all) do
    @user = create(:user)
  end

  it "should successfully create bookmark" do
    bookmark = Bookmark.create attributes_for(:bookmark, user_id: @user.id)
    expect(bookmark).to be_valid
    expect(bookmark.id)
    expect(bookmark.user).to eq @user
  end
  
  it "should be invalid if label is missing" do
    bookmark = Bookmark.new(user_id: @user.id)
    bookmark.save
    expect(bookmark).not_to be_valid
  end

  it "should be invalid if user_id is missing" do
    bookmark = build(:bookmark)
    bookmark.save
    expect(bookmark).not_to be_valid
  end

  context 'with tags' do
    before(:each) do
      @bookmark = create(:bookmark, user_id: @user.id)
    end

    it "should successfully save bookmark to bookmark" do
      tag = @bookmark.tags.create(attributes_for(:tag))
      expect(tag.id)
      expect(@bookmark).to be_valid
      expect(@bookmark.tags.count).to eq 1
      expect(tag.user).to eq @user
    end

    it "should fail to create bookmark association if mismatched user" do
      new_user = create(:user)
      tag = create(:tag, user_id: new_user.id)
      expect{ @bookmark.tags << tag }.to raise_error Bookmark::TagUserMismatch
    end

  end

end