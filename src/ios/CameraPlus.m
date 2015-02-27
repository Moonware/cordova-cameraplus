/********* CameraPlus.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

#import <AVFoundation/AVFoundation.h>

#import "CameraManager.h"

@interface CameraPlus : CDVPlugin {
    // Member variables go here.

}

@property(nonatomic, retain) CameraManager *cameraManager;

- (void)startCamera:(CDVInvokedUrlCommand*)command;
- (void)stopCamera:(CDVInvokedUrlCommand*)command;

- (void)getJpegImage:(CDVInvokedUrlCommand *)command;
- (void)getVideoFormats:(CDVInvokedUrlCommand *)command;
- (void)setVideoFormat:(CDVInvokedUrlCommand *)command;

@end

@implementation CameraPlus


- (void)pluginInitialize
{
}

- (void)startCamera:(CDVInvokedUrlCommand*)command
{
    if(self.cameraManager != nil) {
        [self.cameraManager stopScanning];
        [self.cameraManager deinitCapture];
        self.cameraManager = nil;
    }
    
    self.cameraManager = [[CameraManager alloc] init];
    [self.cameraManager initCapture];
    
    // start on demand / request :)
    //[self.cameraManager startScanning];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stopCamera:(CDVInvokedUrlCommand*)command
{
    if(self.cameraManager != nil) {
        [self.cameraManager stopScanning];
        [self.cameraManager deinitCapture];
        self.cameraManager = nil;
    }

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getJpegImage:(CDVInvokedUrlCommand *)command
{
    @autoreleasepool {
        NSData* jpgData = NULL;
        
        if(self.cameraManager != nil) {
            jpgData = [self.cameraManager getJpegImage];
        }
        
        NSString *base64String;
        
        if (jpgData != NULL)
        {
            base64String = [jpgData base64EncodedStringWithOptions:0];
            
#if !__has_feature(objc_arc)
            [jpgData release];
#endif
        }
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                          messageAsString:base64String];
    

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


- (NSString *)stringWithFourCharCode:(unsigned int) fourCharCode {
    
    char c0 = fourCharCode >> 24;
    char c1 = (fourCharCode >> 16) & 0xff;
    char c2 = (fourCharCode >> 8) & 0xff;
    char c3 = fourCharCode & 0xff;
    
    return [NSString stringWithFormat:@"%c%c%c%c", c0, c1, c2, c3];
}


- (void)getVideoFormats:(CDVInvokedUrlCommand *)command
{
    // messageAsArray NSArray*
    // messageAsArrayBuffer NSData*
    // messageAsDictionary NSDictionary*
    
    NSMutableArray* formats = [[NSMutableArray alloc] init];;
    
    if(self.cameraManager != nil) {
        for(AVCaptureDeviceFormat *vFormat in [self.cameraManager getVideoFormats] )
        {
            
            FourCharCode desc = CMVideoFormatDescriptionGetCodecType(vFormat.formatDescription);
            CMVideoDimensions size = CMVideoFormatDescriptionGetDimensions(vFormat.formatDescription);
            
            int minRate = 999;
            int maxRate = 0;
            
            for ( AVFrameRateRange *range in vFormat.videoSupportedFrameRateRanges ) {
                
                if ( range.maxFrameRate > maxRate ) {
                    maxRate = range.maxFrameRate;
                }
                
                if ( range.minFrameRate < minRate ) {
                    minRate = range.minFrameRate;
                }
            }
            
            // vFormat.mediaType
            // vFormat.formatDescription (Full Block info)
            
            //NSLog(@">> AVFormats  %@ %@ %@",vFormat.mediaType,vFormat.formatDescription,vFormat.videoSupportedFrameRateRanges);
            
            NSString *fourcc = [self stringWithFourCharCode:desc];
            NSString *formatStr = [NSString stringWithFormat:@"(%@) %dx%d , %d-%dfps", fourcc, size.width, size.height, minRate, maxRate];
            [formats addObject:formatStr];
        }
    }
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                       messageAsArray:formats];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setVideoFormat:(CDVInvokedUrlCommand *)command
{
    
    NSDictionary* options = [command.arguments objectAtIndex:0];
    NSString* vFormat = [options valueForKey:@"videoFormat"];
    
    NSLog(@">> Received AVFormat  %@",vFormat);
    
    if(self.cameraManager != nil) {
        [self.cameraManager setVideoFormat:vFormat.intValue];
    }
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                        messageAsBool:YES];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end