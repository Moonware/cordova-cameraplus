## CameraPlus For Cordova ##

Supported platform:
* iOS
* Android

CameraPlus has the following features
* Retrieve live images from Camera in the background
* Retrieve the images in HTML/JS in Base64 so that they can be displayed, saved in localstorage and sent using HTTP POST
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

getJpegImage( success_callback, error_callback );
```


getJpegImage will return a JPEG image encoded in base 64.

You can then set it to an image from HTML/JS part of the application:

Standard JS:

```camImage.src = "data:image/jpeg;base64," + data;```

or

AngularJS/Ionic:

```<img src="data:image/jpeg;base64, {{data}}">```

## Test Application ##

A ready to try Ionic application is available here:
https://github.com/Moonware/cordova-cameraplus-testapp

## Known issues ##

Unfortunately at this time, the iOS version suffers from an identified issue probably due to a memory leak.

If you think that you can help, feel free to participate in one of these topic:

http://forum.ionicframework.com/t/camera-plus-cordova-plugin-ios-help-needed/18375

http://stackoverflow.com/questions/28771897/cordova-custom-camera-plugin-ios-memory-leak
