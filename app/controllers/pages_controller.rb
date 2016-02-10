class PagesController < ApplicationController
  def home
    template = signed_in? ? 'home' : 'sign_in'
    render template
  end
end
