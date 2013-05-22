# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  console.log "started"
  pusher = new Pusher('3014fc75d43bfdb0e011')
  channel = pusher.subscribe('stories')
  channel.bind 'updated', (data) ->
    console.log data
    story = $("#story_#{data.id}")
    story.find("h4 a").text(data.title)
    story.find("img").attr('src', data.cover_url).show()
    $('ul.stories').masonry('reload')

  $('ul.stories').imagesLoaded =>
    console.log "imgs loaded"
    $('ul.unstyled').masonry
      itemSelector: 'li'
