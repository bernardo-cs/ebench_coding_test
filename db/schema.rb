# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150317092706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mentions", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "tweet_id"
  end

  create_table "que_jobs", primary_key: "queue", force: :cascade do |t|
    t.integer  "priority",    limit: 2, default: 100,                   null: false
    t.datetime "run_at",                default: '2015-03-15 20:38:02', null: false
    t.integer  "job_id",      limit: 8, default: 0,                     null: false
    t.text     "job_class",                                             null: false
    t.json     "args",                  default: [],                    null: false
    t.integer  "error_count",           default: 0,                     null: false
    t.text     "last_error"
  end

  create_table "tweets", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.text     "text_trimed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "retweets"
    t.integer  "favourites"
    t.json     "source"
  end

  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "count_of_mentions"
  end

  add_index "users", ["name"], name: "index_users_on_name", using: :btree

end
