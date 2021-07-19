#import "BackgroundFetchModule.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Capacitor/Capacitor.h>
#import <Capacitor/Capacitor-Swift.h>
#import <Capacitor/CAPBridgedPlugin.h>
#import <Capacitor/CAPBridgedJSTypes.h>

#import <TSLocationManager/TSLocationManager.h>

static NSString *const BACKGROUND_FETCH_TAG = @"BackgroundGeolocationFirebasePlugin";
static NSString *const PLUGIN_ID = @"capacitor-background-geolocation-firebase";

static NSString *const PERSIST_EVENT                = @"TSLocationManager:PersistEvent";

static NSString *const FIELD_LOCATIONS_COLLECTION = @"locationsCollection";
static NSString *const FIELD_GEOFENCES_COLLECTION = @"geofencesCollection";
static NSString *const FIELD_UPDATE_SINGLE_DOCUMENT = @"updateSingleDocument";

static NSString *const DEFAULT_LOCATIONS_COLLECTION = @"locations";
static NSString *const DEFAULT_GEOFENCES_COLLECTION = @"geofences";

@implementation BackgroundGeolocationFirebaseModule {
    BOOL isRegistered;
}

- (void)load {
    isRegistered = NO;
    _locationsCollection = DEFAULT_LOCATIONS_COLLECTION;
    _geofencesCollection = DEFAULT_GEOFENCES_COLLECTION;
    _updateSingleDocument = NO;

    if (![FIRApp defaultApp]) {
        [FIRApp configure];
    }
}

- (void)configure:(CAPPluginCall *) call {
    NSDictionary *config = [call getObject:@"options" defaultValue:@{}];

    if (config[FIELD_LOCATIONS_COLLECTION]) {
        _locationsCollection = config[FIELD_LOCATIONS_COLLECTION];
    }
    if (config[FIELD_GEOFENCES_COLLECTION]) {
        _geofencesCollection = config[FIELD_GEOFENCES_COLLECTION];
    }
    if (config[FIELD_UPDATE_SINGLE_DOCUMENT]) {
        _updateSingleDocument = [config[FIELD_UPDATE_SINGLE_DOCUMENT] boolValue];
    }

    if (!isRegistered) {
        TSConfig *bgGeo = [TSConfig sharedInstance];
        [bgGeo registerPlugin:@"firebaseproxy"];
        isRegistered = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onPersist:)
                                                     name:PERSIST_EVENT
                                                   object:nil];
    }

    [call resolve:@{}];
}

-(void) onPersist:(NSNotification*)notification {
    NSDictionary *data = notification.object;
    NSString *collectionName = (data[@"location"][@"geofence"]) ? _geofencesCollection : _locationsCollection;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        FIRFirestore *db = [FIRFirestore firestore];
        // Add a new document with a generated ID
        if (!self.updateSingleDocument) {
            __block FIRDocumentReference *ref = [[db collectionWithPath:collectionName] addDocumentWithData:notification.object completion:^(NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Error adding document: %@", error);
                } else {
                    NSLog(@"Document added with ID: %@", ref.documentID);
                }
            }];
        } else {
            [[db documentWithPath:collectionName] setData:notification.object completion:^(NSError * _Nullable error) {
                if (error != nil) {
                    NSLog(@"Error writing document: %@", error);
                } else {
                    NSLog(@"Document successfully written");
                }
            }];
        }
    });
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
