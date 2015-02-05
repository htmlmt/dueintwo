// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-datepicker

$(document).ready(function(){
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})

})

function responsiveElements() {
    var windowWidth = window.innerWidth;

    if (Modernizr.mq('(max-width: 1000px)')) {
      var fontSize = windowWidth/62.5;
      var html = document.querySelector("html");
      html.style.fontSize = '' + fontSize + 'px';
    } else if (Modernizr.mq('(min-width: 1000px)')) {
      var fontSize = 16;
      var html = document.querySelector("html");
      html.style.fontSize = '' + fontSize + 'px';
    } else {
      var fontSize = windowWidth/35;
      var html = document.querySelector("html");
      html.style.fontSize = '' + fontSize + 'px';
    }
}

var resize;
window.onresize = function(){
    clearTimeout(resize);
    resize = setTimeout(responsiveElements(), 100);
};

window.onload = setupDom;
window.onfocus = setupDom;

function setupDom() {
  responsiveElements()
}