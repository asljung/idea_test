# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('a.load-more-ideas').on 'inview', (e, visible) ->
    return unless visible
    
    $.getScript $(this).attr('href')

$ ->
  $('a.load-more-comments').on 'inview', (e, visible) ->
    return unless visible
    
    $.getScript $(this).attr('href')

jQuery ->
  $("a.swipebox").swipebox()

  $('#comment_body').keypress (e) ->
    if e.keyCode == 13 && !e.shiftKey
      e.preventDefault()
      $(this).closest("form").submit()  

  $(document).on 'click', 'a.hide_full_content', (e) ->
    $idea = $(this).closest("li")
    $idea.find('.full_content').hide()
    $idea.find('.content').show()
    e.preventDefault()
    return

  $(document).on 'click', 'a.show_full_content', (e) ->
    $idea = $(this).closest("li")
    $idea.find('.content').hide()
    $idea.find('.full_content').show()
    e.preventDefault()
    return

  $(document).on 'click', 'a.show_comments', (e) ->
    $idea =  $(this).closest("li")
    $idea.find('.comments').show()
    $(this).removeClass('show_comments').addClass('hide_comments')
    e.preventDefault()
    return

  $(document).on 'click', 'a.hide_comments', (e) ->
    $idea =  $(this).closest("li")
    $idea.find('.comments').hide()
    $(this).removeClass('hide_comments').addClass('show_comments')
    e.preventDefault()
    return
  return
