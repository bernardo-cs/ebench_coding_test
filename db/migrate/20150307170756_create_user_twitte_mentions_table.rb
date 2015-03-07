class CreateUserTwitteMentionsTable < ActiveRecord::Migration
  def change
    create_table :mentions, id: false do |t|
      t.integer :user_id
      t.integer :tweet_id
    end
  end
end
