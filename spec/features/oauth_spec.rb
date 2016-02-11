require 'rails_helper'

describe "sessions", :type => :feature, :js => true do
  before(:each) do
    visit '/signout'
  end

  it "signs in" do
    visit '/'
    expect(page).to have_content "Sign in using a service below"
    click_button 'Github'
    expect(page).to have_content 'Welcome'
  end

  it "signs out" do
    visit '/'
    click_button 'Github'
    click_link 'Sign Out'
    expect(page).to have_content 'See you again soon!'
  end

end