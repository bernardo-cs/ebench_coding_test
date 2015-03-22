namespace :user do
  desc "Manage user related tasks, like fetching new tweets and cleaning existing users"

  task default: :update_all

  task scaffold: [:environment, :clean] do
    RAILS_CORE_MEMBERS = ['dhh', 'bitsweat', 'nzkoz', 'josevalim', 'spastorino', 'fxn', 'tenderlove']
    ANGULAR_CORE_MEMBERS = []
    members = RAILS_CORE_MEMBERS + ANGULAR_CORE_MEMBERS

    # Create new users
    User.create( members.map{|m| { name: m }} )
  end

  task fetch_tweets: :environment do
    ActiveRecord::Base.transaction do
      User.update_tweets
    end
  end

  task update_mentions_count: :environment do
    ActiveRecord::Base.transaction do
      User.update_mentions_count
    end
  end

  task update_all: [:environment, :fetch_tweets, :update_mentions_count] do
  end

  task clean: :environment do
    # Clean Users and Tweets
    User.delete_all
    Tweet.delete_all
  end
end
