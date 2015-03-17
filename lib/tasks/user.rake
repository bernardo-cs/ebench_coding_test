namespace :user do
  desc "TODO"
  task scaffold: :environment do
    RAILS_CORE_MEMBERS = ['dhh', 'bitsweat', 'nzkoz', 'josevalim', 'spastorino', 'fxn', 'tenderlove']
    ANGULAR_CORE_MEMBERS = []
    members = RAILS_CORE_MEMBERS + ANGULAR_CORE_MEMBERS

    # Clean Users and Tweets
    User.delete_all
    Tweet.delete_all

    # Create new users
    User.create( members.map{|m| { name: m }} )

    # Fetch users tweets
    FetchTweetsJob.perform_later
  end
end
