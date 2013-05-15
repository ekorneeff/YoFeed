class TwitterParseWorker
  include Sidekiq::Worker

  def perform(id)
    parse_urls(id)
  end

  private

  def parse_urls(id)
    attrs = {}
    entry = Story.find(id)
    url_is_image = false
    source = open(entry.url)
    # checks if urls is image
    url_is_image = source.content_type =~ /image/
    unless url_is_image
      article = Readability::Document.new(source.read)
      attrs[:title] = article.title
      attrs[:body] = article.content.html_safe
      attrs[:cover_url] = article.images.first if article.images.present? && entry.cover_url.blank?
    else
      attrs[:cover_url] = entry.url
    end
    entry.update_attributes(attrs)
    entry.full_load!
  end
end