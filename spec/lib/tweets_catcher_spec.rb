require 'spec_helper'

describe TweetsCatcher do
  let(:tweet_catcher) { TweetsCatcher.new }
  before{
    @tweets ||= tweet_catcher.fetch_all_user_tweets( 'golfadas' )
  }

  it 'fetches all user tweets' do
    expect( @tweets ).not_to be_empty
    expect( @tweets.first.text ).to eq( "Dai até  não pagar impostos..“@sapo: Passos: \"Ninguém espere que eu seja um cidadão perfeito\" http://t.co/8v6eJ0nkod http://t.co/vPNUhXmtw8”" )
    expect( @tweets.last.text ).to eq( "to a rasca para ir mijar" )
  end

  it 'doesnt have repeated ids' do
    tweets = @tweets.map(&:id)
    expect( tweets.to_set.size ).to eql( tweets.size )
  end

  describe '#fetch_latest_tweets' do
    before{
      @expected_new_tweets, @old_tweets = @tweets.in_groups(2, false)
      @new_tweets ||= tweet_catcher.fetch_latest_tweets( 'golfadas', @old_tweets.first.id )
    }

    it 'dowsnt have any nil values' do
      expect( @old_tweets ).not_to be nil
      expect( @expected_new_tweets ).not_to be nil
      expect( @new_tweets ).not_to be nil
    end

    it 'fetches a user latest tweets given the latest retrieved tweets id' do
      expect( @new_tweets ).to include( *@expected_new_tweets )
    end

    it 'doenst retrive already retrived tweets' do
      expect( @new_tweets ).not_to include( *@old_tweets )
    end

    it 'all tweets have unique ids' do
      tweets_ids = @new_tweets.map(&:id)
      expect( tweets_ids.to_set.size ).to eq( @new_tweets.size )
    end
  end
end
