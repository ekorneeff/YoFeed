class Story < ActiveRecord::Base
  belongs_to :feed
  default_scope { order("time_marker DESC") }

  state_machine :state, initial: :got_from_feed do
    event :full_load do
      transition :got_from_feed => :full_loaded
    end
    after_transition any => :full_loaded do |entry, transition|
      Pusher.trigger('stories', 'story_updated', entry.to_json)
    end
  end
end
