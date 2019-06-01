//
//  AppDelegate.m
//  3DTouch
//
//  Created by Pawan kumar on 9/18/17.
//  Copyright © 2017 Pawan Kumar. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedVC.h"
#import "NotificationVC.h"
#import "SettingsVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//Navigation
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Create 3D Touch
    [self createItemsWithIcons];
    
    // determine whether we've launched from a shortcut item or not
    UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (item) {
        NSLog(@"We've launched from shortcut item: %@", item.localizedTitle);
    } else {
        NSLog(@"We've launched properly.");
    }
    
    // have we launched Feed
    if ([item.type isEqualToString:@"com.pk.Feed"]) {
        [self launchViewController1];
    }
    
    // have we launched Notification
    if ([item.type isEqualToString:@"com.pk.Notification"]) {
        [self launchViewController2];
    }
    
    // have we launched Settings
    if ([item.type isEqualToString:@"com.pk.Settings"]) {
        [self launchViewController3];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"_DTouch"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (void)createItemsWithIcons {
    
   // icons with my own images
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon1"];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon2"];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon3"];
    
    // create several (dynamic) shortcut items
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.pk.Feed" localizedTitle:@"Launch Feed Controller" localizedSubtitle:@"Launch Feed Controller" icon:icon1 userInfo:nil];
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.pk.Notification" localizedTitle:@"Launch Notification Controller" localizedSubtitle:@"Launch Notification Controller" icon:icon2 userInfo:nil];
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"com.pk.Settings" localizedTitle:@"Launch Settings Controller" localizedSubtitle:@"Launch Settings Controller" icon:icon3 userInfo:nil];
    
    // add all items to an array
    NSArray *items = @[item1, item2, item3];
    
    // add this array to the potentially existing static UIApplicationShortcutItems
    NSArray *existingItems = [UIApplication sharedApplication].shortcutItems;
    NSArray *updatedItems = [existingItems arrayByAddingObjectsFromArray:items];
    [UIApplication sharedApplication].shortcutItems = updatedItems;
    
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    // react to shortcut item selections
    NSLog(@"A shortcut item was pressed. It was %@.", shortcutItem.localizedTitle);

    // have we launched Feed
    if ([shortcutItem.type isEqualToString:@"com.pk.Feed"]) {
        [self launchViewController1];
    }
    
    // have we launched Notification
    if ([shortcutItem.type isEqualToString:@"com.pk.Notification"]) {
        [self launchViewController2];
    }
    
    // have we launched Settings
    if ([shortcutItem.type isEqualToString:@"com.pk.Settings"]) {
        [self launchViewController3];
    }
}

- (void)launchViewController1 {
    
    // grab our storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // instantiate our navigation controller
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
    
    // instantiate second view controller
    FeedVC *feedVC = (FeedVC*)[storyboard instantiateViewControllerWithIdentifier:@"FeedVC"];
    
    // now push both controllers onto the stack
    [controller pushViewController:feedVC animated:NO];
    
    // make the nav controller visible
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}
- (void)launchViewController2 {
    
    // grab our storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // instantiate our navigation controller
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
    
    // instantiate second view controller
    NotificationVC *notificationVC = (NotificationVC*)[storyboard instantiateViewControllerWithIdentifier:@"NotificationVC"];
    
    // now push both controllers onto the stack
    [controller pushViewController:notificationVC animated:NO];
    
    // make the nav controller visible
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}

- (void)launchViewController3 {
    
    // grab our storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // instantiate our navigation controller
    UINavigationController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Navigation"];
    
    // instantiate second view controller
    SettingsVC *settingsVC = (SettingsVC*)[storyboard instantiateViewControllerWithIdentifier:@"SettingsVC"];
    
    // now push both controllers onto the stack
    [controller pushViewController:settingsVC animated:NO];
    
    // make the nav controller visible
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}

@end
