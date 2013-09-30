// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require medium
//= require jquery.autosize
//= require_tree .

function save_to_form() {
	var content = $('#editor').html();
      $("input[id=feature_text]").val(content);
      };

$(document).ready(function(){
	$("#feature_title, #feature_subtitle, #feature_tag_list, #feature_text").autosize();
  var timeout;
  $('.editable, #feature_title, #feature_subtitle, #feature_tag_list').on('keyup paste', function () {
    clearTimeout(timeout);
    save_to_form();
    $('.status').html('saving...');
    timeout = setTimeout("$('form[data-remote]').submit();", 3000);
  });
});

$(document).ready(function(){
var editor = new Medium({
element: document.getElementById('editor'), 
mode: 'rich',
placeholder: 'write about your shipped feature'
});
});
