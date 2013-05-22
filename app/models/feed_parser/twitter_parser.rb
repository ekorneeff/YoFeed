class FeedParser::TwitterParser
  CONSUMER_KEY = "230VG13eXRiYVbHPrr4Hlg"
  CONSUMER_SECRET = "XYoHWin0z6SaVsRwZyAJaVbqmxOnJ1YPC8RWC3yy6Xc"

  def initialize(context)
    @context = context
  end

  def parse_feed(timemarker)
    client = Twitter::Client.new(
      consumer_key: CONSUMER_KEY,
      consumer_secret: CONSUMER_SECRET,
      oauth_token: @context.token,
      oauth_token_secret: @context.secret
    )
    attrs = {
      count: 20 
    }
    unless timemarker == "0"
      attrs[:since_id] = timemarker.to_i
      attrs[:count] = 100
    end
    tl = client.home_timeline(attrs)
    Rails.logger.ap tl.map(&:to_hash)
    parse_entries(tl)
  end

  private

  def parse_entries(feed)
    feed.map do |entry|
      attrs = {
        author: entry.user.screen_name,
        avatar_url: entry.profile_image_url,
        announce: entry.text,
        time_marker: entry.id
      }
      if entry.media.present?
        attrs[:cover_url] = entry.media.first.media_url
      end
      url = entry.urls.first.expanded_url if entry.urls.present?
      attrs[:url] = url if url
      done_entry = @context.stories.create(attrs)
      TwitterParseWorker.perform_async(done_entry.id) if url
      done_entry
    end
  end
end