class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :stories

  def generate_stories(timemarker)
    parser = ("FeedParser::#{self.provider.titleize}Parser").constantize.new(self)
    parser.parse_feed(timemarker)
  end
  
  def self.find_or_create_with_omniauth(auth)
    obj = find_by_provider_and_uid(auth['provider'], auth['uid'])
    unless obj.present?
      attrs = { uid: auth['uid'],
                provider: auth['provider'],
                name: "#{auth['provider']} feed",
                token: auth['credentials']['token'],
                secret: auth['credentials']['secret'] }
      obj = create(attrs) # and other data you might want from the auth hash
    end
  end

end
