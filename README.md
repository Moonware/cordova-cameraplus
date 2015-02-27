## CameraPlus For Cordova ##

Supported platform:
* iOS
* Android

CameraPlus has the following features
* Retrieve live images from Camera from Phonegap application in Base64
* Set the target format (iOS only)
* Automatically stops capturing if no request made for 5 seconds, wake up camera when image requested


## How to use CameraPlus? ##

Add the plugin to your cordova project:

    cordova plugin add https://github.com/moonware/cordova-cameraplus.git

## Javascript APIs ##

```javascript

startCamera( options, success_callback, error_callback );

stopCamera( success_callback, error_callback );

getVideoFormats( success_callback, error_callback );

setVideoFormat( success_callback, error_callback );
```
