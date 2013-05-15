class StoriesController < ApplicationController
  before_filter :get_feed

  def index
    last_entry = @feed.stories.first
    tm = last_entry.present? ? last_entry.time_marker : "0"
    @new_count = @feed.generate_stories(tm).count
    logger.ap "New Posts Count: #{@new_count}"
    @stories = @feed.stories
  end

  def show
    @story = @feed.stories.find(params[:id])
  end

  protected

  def get_feed
    @feed = current_user.feeds.find(params[:feed_id])
  end
end
