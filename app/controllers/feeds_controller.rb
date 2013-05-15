class FeedsController < ApplicationController
  def index
    @feeds = current_user.feeds
  end

  def create
    @user = current_user.feeds.find_or_create_with_omniauth(auth_hash)
    redirect_to root_path, notice: "Good!"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
