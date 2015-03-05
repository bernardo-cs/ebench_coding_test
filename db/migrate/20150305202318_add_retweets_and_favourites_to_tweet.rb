class AddRetweetsAndFavouritesToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :retweets, :integer
    add_column :tweets, :favourites, :integer
  end
end
