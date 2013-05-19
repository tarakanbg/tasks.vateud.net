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