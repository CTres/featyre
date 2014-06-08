$(document).ready(function(){
  // content editable editor - get the medium-editor.js from github
  var editor = new MediumEditor('.editable', {
    anchorInputPlaceholder: 'Add your note',
    buttons: ['bold', 'italic', 'underline', 'header1', 'header2', 'unorderedlist', 'orderedlist'],
    diffLeft: 75});
  $('.editable').mediumImages();
  
  // autosize
  // $("#feature_title, #feature_subtitle, #feature_tag_list, #feature_text, #value_persona").autosize();

  // Autosave function that saves on the new and edit 1.5 seconds after the last typing on the included divs
  var timeout;
  $('.editable, .feature_edit, .new_feature').on('keyup paste', function () {
    clearTimeout(timeout);
    save_to_form();
    $('.status').html('saving...');
    timeout = setTimeout("$('.new_feature, .feature_edit').submit(); ", 1500);
  });

  // if you add a role to a collaborator, trigger the save function after 3 seconds
  $('.role').on('keyup paste', function () {
  clearTimeout(timeout);
  $('.status').html('saving...');
  timer = setTimeout("$('.edit_user').submit(); ", 3000);
  });

  $(".add_photo").on('click', function () {
    $('.photo').click();
  });
  $(".photo").change(function() {
  $(".photo_form").submit();
  });
});

function save_to_form() {
  var content = $('#editor').html();
  $("input[id=feature_text]").val(content);
};


