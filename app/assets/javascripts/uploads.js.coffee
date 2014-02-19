# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $uploadList = $('#upload .upload-list')

  # trigger file upload browser on Browse click
  $('#dropzone .browse').click () ->
    $('#uploaded_file').click()

  $('#uploaded_file').fileupload({
    dataType: 'script',

    # this element will accept file drag/drop uploading dropZone:
    dropZone: $('#dropzone'),

    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        tpl = $('<li class="working panel panel-default"><div class="canvas"><input type="text" value="0" data-width="48"' +
          'data-height="48" data-fgColor="#0788a5" data-readOnly="1" data-bgColor="#3e4043" /></div>' +
          '<div><p></p></div><span class="glyphicon glyphicon-remove"></span></li>')
        
        # Append the file name and file size
        tpl.find("p").text(file.name).append "<i>" +
        formatFileSize(file.size) + "</i>"
        # Add the HTML to the UL element 
        data.context = tpl.appendTo($uploadList)
        # Initialize the knob plugin
        tpl.find("input").knob()
        # Listen for clicks on the cancel icon
        tpl.find("span").click ->
          jqXHR.abort() if tpl.hasClass("working")
          tpl.fadeOut ->
            tpl.remove()

        #Automatically upload the file once it is added to the queue
        jqXHR = data.submit()
      else
        alert("#{file.name} is not a gif, jpeg or png image file")

    progress: (e, data) ->
      # Calculate the completion percentage of the upload
      progress = parseInt(data.loaded / data.total * 100, 10)
      # Update the hidden input field and trigger a change
      # so that the jQuery knob plugin knows to update the dial
      data.context.find("input").val(progress).change()
      data.context.removeClass "working" if progress is 100
      data.context.find("span").removeClass "glyphicon glyphicon-remove" if progress is 100
      data.context.find("span").addClass "glyphicon glyphicon-ok" if progress is 100

    fail: (e, data) ->
      data.context.addClass "error"
  })

  formatFileSize = (bytes) ->
    return "" if typeof bytes isnt "number"
    return (bytes / 1000000000).toFixed(2) + " GB" if bytes >= 1000000000
    return (bytes / 1000000).toFixed(2) + " MB" if bytes >= 1000000
    (bytes / 1000).toFixed(2) + " KB"

  # Prevent the default action when a file is dropped on the window
  $(document).on "drop dragover", (e) ->
    e.preventDefault()