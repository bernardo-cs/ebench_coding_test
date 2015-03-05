class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text
      t.references :user, index: true
      t.text :text_trimed

      t.timestamps null: false
    end
    add_foreign_key :tweets, :users
  end
end
