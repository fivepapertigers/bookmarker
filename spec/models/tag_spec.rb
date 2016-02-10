require 'rails_helper'

RSpec.describe Tag, type: :model do

  before(:all) do
    @user = create(:user)
  end

  it "should successfully create tag" do
    tag = Tag.create attributes_for(:tag, user_id: @user.id)
    expect(tag).to be_valid
    expect(tag.id)
    expect(tag.user).to eq @user
  end
  
  it "should be invalid if label is missing" do
    tag = Tag.new(user_id: @user.id)
    tag.save
    expect(tag).not_to be_valid
  end

  it "should be invalid if user_id is missing" do
    tag = build(:tag)
    tag.save
    expect(tag).not_to be_valid
  end

  context 'with bookmarks' do
    before(:each) do
      @tag = create(:tag, user_id: @user.id)
    end

    it "should successfully save bookmark to tag" do
      bm = @tag.bookmarks.create(attributes_for(:bookmark))
      expect(bm.id)
      expect(@tag).to be_valid
      expect(@tag.bookmarks.count).to eq 1
      expect(bm.user).to eq @user
    end

    it "should fail to create bookmark association if mismatched user" do
      new_user = create(:user)
      bm = create(:bookmark, user_id: new_user.id)
      expect{ @tag.bookmarks << bm }.to raise_error Tag::BookmarkUserMismatch
    end

  end

end