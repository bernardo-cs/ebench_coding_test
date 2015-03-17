class TweetsStorer
  attr_reader :user, :parameters_mapping

  def initialize user, parameters_mapping
    @user = user
    @parameters_mapping = parameters_mapping
  end

  def store tweets
    create_tweets( Array.new(1){ tweets }.flatten )
  end

  private
  def create_tweets tweets
    tweets.each do |tweet|
      new_tweet = Tweet.new( build_attributes( tweet ) )
      add_tweet_to_user( new_tweet )
    end
  end

  def build_attributes tweet
    hsh = params_to_store.inject({}){ |acum, p| acum[p] = tweet.send( parameters_mapping[p] ); acum }
    fix_json( hsh )
  end

  def add_tweet_to_user tweet
    tweet.save
    user.tweets << tweet
  end

  # Fixes UTF8 encoding problem on pgdatabase when storing json strings
  def fix_json hsh
    hsh[:source] = hsh[:source].encode('utf-8')
    hsh
  end

  def params_to_store
    parameters_mapping.keys
  end
end
