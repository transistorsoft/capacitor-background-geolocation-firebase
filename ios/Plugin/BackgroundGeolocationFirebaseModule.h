#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Capacitor/CAPPlugin.h>
#import <Capacitor/CAPBridgedPlugin.h>

@class CAPPluginCall;

@interface BackgroundGeolocationFirebaseModule : CAPPlugin

@property (nonatomic) NSString* locationsCollection;
@property (nonatomic) NSString* geofencesCollection;
@property (nonatomic) BOOL updateSingleDocument;

@end

