require 'rails_helper'
MODAL_SLEEP = 0.5 #it's possible you may need to change this on slower machines

describe "bookmarks", :type => :feature, :js => true do
  before(:each) do
    visit '/signout'
    visit '/'
    click_button 'Github'
  end

  it "creates a tag" do
    attrs = attributes_for(:tag)
    listing = create_tag attrs
    expect(listing).to have_content attrs[:label]
  end

  it "creates a bookmark without a tag" do
    attrs = attributes_for(:bookmark)
    listing = create_bookmark attrs
    expect(listing.find('h3')).to have_content attrs[:name]
    expect(listing.find('li')).to have_content attrs[:path]
  end

  it "creates a bookmark with a tag" do
    tag_attrs = attributes_for(:tag)
    tag_li = create_tag tag_attrs
    sleep MODAL_SLEEP
    attrs = attributes_for(:bookmark)
    listing = create_bookmark attrs, tag_attrs[:label]
    
    expect(listing.find('h3')).to have_content attrs[:name]
    expect(listing.find('ul')).to have_content attrs[:path]
    expect(listing.find('ul')).to have_content tag_attrs[:label]
  end




  def create_tag(attrs)
    click_link 'Add New Tag'
    within '#add_tag_modal' do
      fill_in 'label', with: attrs[:label]
      click_button 'Add'
    end
    find('.tag-list-item')
  end

  def create_bookmark(attrs, checkbox = nil)
    click_button 'Add New Bookmark'
    within '#add_bookmark_modal' do
      fill_in 'name', with: attrs[:name]
      fill_in 'path', with: attrs[:path]
      check checkbox if checkbox
      click_button 'Add'
    end
    find('.bookmark-listing')
  end

end