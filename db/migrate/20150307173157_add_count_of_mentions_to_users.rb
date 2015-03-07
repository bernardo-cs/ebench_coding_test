class AddCountOfMentionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :count_of_mentions, :integer
  end
end
