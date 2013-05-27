// var tree = $("#tasks");
// tree.bind("loaded.jstree", function (event, data) {
//     tree.jstree("open_all");
// });

$(function () {
    $("#tasks").jstree({
        "plugins" : [ "themes", "html_data" ]
    });
    $("#tasks").jstree("set_theme","default");
    // $("#tasks").jstree("open_all");

});


$('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
    });

$('[data-behaviour~=datepicker]').datepicker({
    "format": "yyyy-mm-dd",
    "weekStart": 1,
    "autoclose": true
});


$(document).ready(function() {
    $('.multiselect').multiselect({
      buttonClass: 'btn',
      buttonWidth: 'auto',
      buttonContainer: '<div class="btn-group" />',
      maxHeight: 200,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'None selected <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });
  });