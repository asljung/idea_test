#= require active_admin/base
$ ->
  $(document)
    .on('ajax:success', (event, data) ->
      $this = $(this)
      $("body").html(data)
      $this.trigger('ajax:replaced')
      return false
  )
  return false