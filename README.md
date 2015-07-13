## CameraPlus Plugin For Cordova ##

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

## Known Issues ##

On iOS there are known memory leaks issues related to UIWebView, the application will most likely crash after a few minutes of intensive usage (pulling images at 15-20fps). The Android version doesn't seem to suffer from similar problems.

If you think that you can help on resolving this problem, feel free to participate in one of these topic:

http://forum.ionicframework.com/t/camera-plus-cordova-plugin-ios-help-needed/18375

http://stackoverflow.com/questions/28771897/cordova-custom-camera-plugin-ios-memory-leak

## Known Solution ##

In order to solve the above problem, we have decided to change the approach and to use HTTP for transferring the images between the native code back to Cordova rather than using the "standard" plugin approach. 

Therefore we have created the <strong>CameraServer</strong> Plugin which is a fusion between <strong>CameraPlus</strong> and <strong>CorHttpd</strong>:

[CameraServer Plugin](https://github.com/Moonware/cordova-cameraserver/)

