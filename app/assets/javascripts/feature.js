$(document).ready(function(){
  // content editable editor
  var editor = new MediumEditor('.editable', {
    anchorInputPlaceholder: 'Write your Feature',
    diffLeft: 75});
  
  // autosize
  $("#feature_title, #feature_subtitle, #feature_tag_list, #feature_text, #value_persona").autosize();

  // saving function for new and edit 
  var timeout;
  $('.editable, .feature_edit, .new_feature').on('keyup paste', function () {
    clearTimeout(timeout);
    save_to_form();
    $('.status').html('saving...');
    timeout = setTimeout("$('.new_feature, .feature_edit').submit(); ", 1500);
  });

  // saving function for role 
  $('.role').on('keyup paste', function () {
  clearTimeout(timeout);
  $('.status').html('saving...');
  timer = setTimeout("$('.edit_user').submit(); ", 3000);
  });
});

function save_to_form() {
  var content = $('#editor').html();
      $("input[id=feature_text]").val(content);
};

// $(document).ready(function(){
// var editor = new Medium({
// element: document.getElementById('editor'), 
// mode: 'rich',
// placeholder: 'write about your shipped feature'
// });
// })

