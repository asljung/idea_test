# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  hide_full_content = (id) ->
    $('li#' + String(id) + ' .full_content').hide()
    $('li#' + String(id) + ' .comments').hide()
    $('li#' + String(id) + ' .content').show()
    return
    
  show_full_content = (id) ->
    $('li#' + String(id) + ' .content').hide()
    $('li#' + String(id) + ' .full_content').show()
    $('li#' + String(id) + ' .comments').hide()
    $('li#' + String(id) + ' .show_comments').show()
    $('li#' + String(id) + ' .hide_comments').hide()
    return

  $(document).on 'click', 'a.hide_full_content', (e) ->
    hide_full_content($(this).closest("li").attr("id"))
    e.preventDefault()
    return

  $(document).on 'click', 'a.show_full_content', (e) ->
    show_full_content($(this).closest("li").attr("id"))
    e.preventDefault()
    return

  $(document).on 'click', 'a.show_comments', (e) ->
    $idea =  $(this).closest("li");
    $idea.find('.comments').show();
    $idea.find('.show_comments').hide();
    $idea.find('.hide_comments').show();
    e.preventDefault()
    return

  $(document).on 'click', 'a.hide_comments', (e) ->
    $idea =  $(this).closest("li");
    $idea.find('.comments').hide();
    $idea.find('.show_comments').show();
    $idea.find('.hide_comments').hide();
    e.preventDefault()
    return
  return
