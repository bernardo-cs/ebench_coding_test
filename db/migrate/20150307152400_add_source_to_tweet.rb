class AddSourceToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :source, :json
  end
end
