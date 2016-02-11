function handleFlashMessageHeader(xhr) {
  var _message_array = new Array();
  var _raw_messages = xhr.getResponseHeader("X-FlashMessages")
  
  if (_raw_messages) {
    $('#flash_messages').html('')
    var _json_messages = JSON.parse(_raw_messages);
    for (var key in _json_messages) {
      var text = _json_messages[key]
      $('#flash_messages').notify({message: {text: text, type: key}}).show();
    }
  }
}
 
$(document).ready(function() {
  var dummy = new Array();

  $(document).ajaxComplete(function(event, xhr, settings) {
    handleFlashMessageHeader(xhr);
  });
});