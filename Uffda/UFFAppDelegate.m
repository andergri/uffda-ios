//
//  UFFAppDelegate.m
//  Uffda
//
//  Created by Griffin Anderson on 3/13/14.
//  Copyright (c) 2014 Griffin Anderson. All rights reserved.
//

#import "UFFAppDelegate.h"
#import <Parse/Parse.h>
#import "UFFInstagramOAuthReceiver.h"
#import "UFFMainViewController.h"
#import "UFFCategoryModel.h"
#import <AdSupport/AdSupport.h>
#import "HockeySDK.h"
#import <Crashlytics/Crashlytics.h>

@implementation UFFAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    // Version Script
    [self updateVersionInfo];
    
    // Parse Setup
    [Parse setApplicationId:kUFFParseNetworkApplicationIDKey
                  clientKey:kUFFParseNetworkClientKeyKey];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Register for push notifications
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeSound];
    
    // Test FLight setup
    // [TestFlight takeOff:@"39ee5286-bd5e-4ed2-84fa-5be771501c63"];
    
    // MagicRecord Setup
    [MagicalRecord shouldAutoCreateDefaultPersistentStoreCoordinator];
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:YES];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    // Crashlytics
    [Crashlytics startWithAPIKey:@"8fe2e99f7577f761cb42d9cb1f41e4affb971108"];
    
    // Hockey
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"2c357d20df8e328fb04c21ed962aab88"];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
    
    // Google Analytics
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-48563434-2"];
    
    return YES;

}

// scheme://host/path?query - fragment
// uffda://auth/instagram/?
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"url recieved: %@", url);
    [self isInstagramOAuth:url];
    return YES;
}

// checks if instragram oauth
- (void) isInstagramOAuth:(NSURL *)url{
    if ([[url host] isEqualToString:@"auth"] && [[url path] isEqualToString:@"/instagram"]) {
        NSDictionary *dict = [self parseQueryString:[url fragment]];
        for (NSString* key in dict) {
            if ([key isEqualToString:@"access_token"]) {

                [UFFInstagramOAuthReceiver saveInstagramToken:[dict objectForKey:key] block:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        
                        UINavigationController *navigationController = (UINavigationController*)self.window.rootViewController;
                        NSArray *controllers = navigationController.childViewControllers;
                        for (UIViewController *control in controllers) {
                            if ([NSStringFromClass([control class]) isEqualToString:@"UFFMainViewController"]) {
                                UFFMainViewController * mainViewController = (UFFMainViewController *) control;
                                [mainViewController completeInstagramOauth];
                            }
                            if ([NSStringFromClass([control class]) isEqualToString:@"UFFHomeViewController"]) {
                                UFFHomeViewController * homeViewController = (UFFHomeViewController *) control;
                                [homeViewController completeInstagramOauth];
                            }
                        }
                    }
                }];
            }
        }
    }
}

// parse query elements of a string url
- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

// Version Script
- (void) updateVersionInfo{
    // Get the Settings.bundle object
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Get bunch of values from the .plist file and take note that the values that
    // we pull are generated in a Build Phase script that is definied in the Target.
    NSString *appVersionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *buildNumber = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBuildNumber"];
    
    // Dealing with the date
    NSString *dateFromSettings = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBuildDate"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM d HH:mm:ss zzz yyyy"];
    NSDate *date = [dateFormatter dateFromString:dateFromSettings];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *buildDate = [dateFormatter stringFromDate:date];
    
    // Create the version number
    NSString *versionNumberInSettings = [NSString stringWithFormat:@"%@.%@", appVersionNumber, buildNumber];
    
    // Set the build date and version number in the settings bundle reflected in app settings.
    [defaults setObject:versionNumberInSettings forKey:@"version"];
    [defaults setObject:buildDate forKey:@"buildDate"];
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UFFDataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Uffda.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
