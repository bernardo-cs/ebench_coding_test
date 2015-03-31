class User < ActiveRecord::Base
  has_many :tweets, dependent: :destroy
  has_and_belongs_to_many :mentions, class_name: 'Tweet', join_table: 'mentions'

  def self.update_tweets
    all.each(&:update_tweets)
  end

  def self.update_mentions_count
    all.map(&:update_mentions_count)
  end

  def mentions_count_cache
    count_of_mentions || update_mentions_count()
  end

  def update_tweets
    TweetsStorer.new( self, { text: :text,
                             retweets: :retweet_count,
                             favourites: :favorite_count,
                             source: :to_json })
                .store( fetch_tweets )
  end

  def fetch_tweets
    tc = TweetsCatcher.new
    if tweets.empty?
      tc.fetch_all_user_tweets self.name
    else
      tc.fetch_latest_tweets self.name, latest_fetched_tweet_id
    end
  end

  def update_mentions_count
    update_attribute( :count_of_mentions, mentions.count)
    count_of_mentions
  end

  private
  def latest_fetched_tweet_id
    tweets.first.remote_id
  end
end
