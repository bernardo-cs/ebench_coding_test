class UsersController < ApplicationController
  def index
    @users = User.order( count_of_mentions: :desc )
  end
end
