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
//= require bootstrap
//= require_tree ./frontend
//=  require 'raphael'
//=  require 'morris'
//=  require 'graphs'
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales

var tree = $("#tasks");
tree.bind("loaded.jstree", function (event, data) {
    tree.jstree("open_all");
});

$(function () {
    $("#tasks").jstree({
        "plugins" : [ "themes", "html_data" ]
    });
    $("#tasks").jstree("set_theme","default");
    $("#tasks").jstree("open_all");

});



$('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
    });
