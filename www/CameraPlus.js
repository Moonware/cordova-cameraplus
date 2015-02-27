
var argscheck = require('cordova/argscheck'),
    exec = require('cordova/exec');

var cameraplus_exports = {};

cameraplus_exports.startCamera = function(success, error) {
	exec(success, error, "CameraPlus", "startCamera", []);
};

cameraplus_exports.stopCamera = function(success, error) {
	exec(success, error, "CameraPlus", "stopCamera", []);
};

cameraplus_exports.getJpegImage = function(success, error) {
	exec(success, error, "CameraPlus", "getJpegImage", []);
};

cameraplus_exports.setVideoFormat = function(options, success, error) {
	var defaults = {
		'videoFormat': 0
	};

	// Merge optional settings into defaults.
	for (var key in defaults) {
		if (typeof options[key] !== 'undefined') {
			defaults[key] = options[key];
		}
	}

	exec(success, error, "CameraPlus", "setVideoFormat", [defaults]);
};

cameraplus_exports.getVideoFormats = function(success, error) {
	exec(success, error, "CameraPlus", "getVideoFormats", []);
};

module.exports = cameraplus_exports;

