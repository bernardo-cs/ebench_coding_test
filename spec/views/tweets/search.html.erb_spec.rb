require 'rails_helper'

RSpec.describe "tweets/search.html.erb", type: :view do

  it 'has an angular controller TweetsPaginationCtrl' do

    render

    expect(rendered).to match /TweetsPaginationCtrl/
  end
end
