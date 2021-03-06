// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("ready", function() {
	$(".js-confirm-booking").on("click", function() {
		$(".js-reserve-time").show();
	})

	$('.datepicker').pickadate({
	    selectMonths: true, // Creates a dropdown to control month
	    selectYears: 15 // Creates a dropdown of 15 years to control year
	});

	$('.timepicker').timepicker({
		'timeFormat': 'H:i',
		'scrollDefault': 'now'
	});
})