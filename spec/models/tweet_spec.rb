require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let( :tweet ){ Tweet.new( {text: "just tweeted"} ) }
  it 'has a filed text' do
    expect( tweet.text ).to eq 'just tweeted'
  end

  it 'has a number of favourites' do
    tweet.favourites = 1
    expect( tweet.favourites ).to eq( 1 )
  end

  it 'has a number of retweets' do
    tweet.retweets = 2
    expect( tweet.retweets ).to eq 2
  end

  it 'has a user' do
    user = User.new( name: 'ben' )
    tweet.user = user
    expect( tweet.user ).to eq user
  end

  it 'has the source of the retrieved tweet' do
    tweet.source = {text: 'this is a tweet'}
    expect( tweet.source ).to have_key( "text" )
  end

  context 'When searching for tweets' do
    it 'Retrieves a list of tweets based on a given query' do
      Tweet.delete_all
      tweet1 = Tweet.create( text: 'dog' )
      tweet2 = Tweet.create( text: 'dog and cat' )
      tweet3 = Tweet.create( text: 'cat' )
      expect( Tweet.search_text('dog') ).to include( tweet1, tweet2 )
      expect( Tweet.search_text('birds') ).to be_empty
    end
  end
end
