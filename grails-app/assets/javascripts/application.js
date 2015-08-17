// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//
//= require jquery
//= require bootstrap
//= require validator
//= require fileinput
//= require_tree .
//= require_self

if (typeof jQuery !== 'undefined') {
    (function ($) {
        $('#spinner').ajaxStart(function () {
            $(this).fadeIn();
        }).ajaxStop(function () {
            $(this).fadeOut();
        });
    })(jQuery);
}

var fadeOut = function (divId) {
    $('#' + divId).fadeOut();
}

var showAndHide = function (toShow, toHide) {
    $("#" + toShow).show();
    $("#" + toHide).hide();
}

var selectAllCheckboxes = function () {
    $('input:checkbox').not(this).prop('checked', 'true');
}