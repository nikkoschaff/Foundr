# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

// Geolocation code

// TODO error checking


// Gets geolocation, sends data to savePosition
function getGeoLocation() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(savePosition)
	}
}

// Saves geolocation data in a JSON object and saves in a cookie
function savePosition(position) {
	var JSONposition = {
	"accuracy" : "position.coords.accuracy",
	"altitude" : "position.coords.altitude",
	"altitude_accuracy" : "position.coords.altitudeAccuracy",
	"heading" : "position.coords.heading",
	"latitude" : "position.coords.latitude",
	"longitude" : "position.coords.longitude" };

	// TODO Save as cookie
	$.cookie("basket-data", JSON.stringify($(JSONposition).data()));
}


