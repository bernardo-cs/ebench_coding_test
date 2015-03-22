class TweetsController < ApplicationController
  def search
    @result = sort( Tweet.search_text( search_query ) )
  end

  private
  def search_query
    params[:q]
  end

  def sort result
    sort_options[sort_type].call( result )
  end

  def sort_type
    params[:sort]
  end

  def sort_options
    {
      "favourites" => ->( result ){ result.order( favourites: :desc ) },
      "retweets" => ->( result ){  result.order( retweets: :desc )  }
    }.tap{ |hsh|
      hsh.default = ->( result ){  result.order( retweets: :desc, favourites: :desc )  }
    }
  end
end
