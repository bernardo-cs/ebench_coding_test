class TweetsController < ApplicationController
  def search
    @result = Tweet.search_text( search_query )
  end

  private
  def search_query
    params[:q]
  end
end
