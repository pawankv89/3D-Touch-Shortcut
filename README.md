# 3D Touch Shortcut

=========

## 3D-Touch-Shortcut in Swift 5 & Objective C.

------------
Added Some screens here.

![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_1.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_2.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_3.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_4.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_5.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_6.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_7.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_8.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_9.png)
![](https://github.com/pawankv89/3D-Touch-Shortcut/blob/master/images/screen_10.png)

## Usage
------------

#### iOS 9 Demo showing how to use 3D Touch on iPhone 6s devices in both Objective-C and Swift.

If 3D Touch is available, the Main View will bring up a Preview View upon shallow press (Peek), and a Commit View when the user presses deeper (Pop).

If 3D Touch is not available, a long press recognizer is implemented and calls the Preview View. Tapping the Preview View will transition back to the Main View.

Should the user disable 3D Touch while the app is running, the alternative long press recognizer is activated automatically (and disabled again if 3D Touch becomes available again).


####  3D Touch Shortcut

```swift

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
// Override point for customization after application launch.

//Add 3D Touch Shortcuts
self.addNewShortcuts(application: application)

return true
}

func applicationWillResignActive(_ application: UIApplication) {
// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

func applicationDidEnterBackground(_ application: UIApplication) {
// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

func applicationWillEnterForeground(_ application: UIApplication) {
// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

func applicationDidBecomeActive(_ application: UIApplication) {
// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

func applicationWillTerminate(_ application: UIApplication) {
// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
}

extension AppDelegate {

//MARK: - Add 3D Touch Shortcuts

func removeShortcuts(application: UIApplication) -> () {

//If you want to remove all items you can just simply do this.
application.shortcutItems = []

}

func addNewShortcuts(application: UIApplication) -> () {

let viewController = self.window?.rootViewController

// Check the trait collection to see if force is available.
if viewController!.traitCollection.forceTouchCapability == .available {
// Enable 3D Touch features
print("Enable 3D Touch features")
} else {
// Fall back to other non 3D Touch features.
print("Fall back to other non 3D Touch features.")
}

//If you want to remove all items you can just simply do this.
self.removeShortcuts(application: application)

let shortcut_search = UIMutableApplicationShortcutItem(type: "Search", localizedTitle: "Search", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .search), userInfo: nil)

let shortcut_dashboard = UIMutableApplicationShortcutItem(type: "Dashboard", localizedTitle: "Dashboard", localizedSubtitle: "", icon: UIApplicationShortcutIcon.init(templateImageName: "tab_dashboardblack"), userInfo: nil)

let shortcut_profile = UIMutableApplicationShortcutItem(type: "Profile", localizedTitle: "Profile", localizedSubtitle: "", icon: UIApplicationShortcutIcon.init(templateImageName: "tab_my_account"), userInfo: nil)

let shortcut_gift = UIMutableApplicationShortcutItem(type: "Gift", localizedTitle: "Gift", localizedSubtitle: "", icon: UIApplicationShortcutIcon.init(templateImageName: "tab_explore"), userInfo: nil)


//Add Only Four (4) Item by Daynamic or Static Total Show Five (5) iTems with Share by Default added in List
application.shortcutItems = [shortcut_search, shortcut_dashboard, shortcut_profile, shortcut_gift]

}

func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {

let handleShortCutItem = self.handleShortCutItem(shortcutItem: shortcutItem, application: application)
completionHandler(handleShortCutItem)
}

func handleShortCutItem(shortcutItem: UIApplicationShortcutItem, application: UIApplication) -> Bool {

var handle = false

//gurad to see if the shortcutItem type is string
guard let shortCutType = shortcutItem.type as String? else {
return false
}

switch (shortCutType) {
case "Search":
//Handle shortcut 1

//Move to Search Screen
self.moveToSearchViewControllerScreen()

handle = true
break
case "Dashboard":
//Handle shortcut 2

//Move to Dashboard Screen
self.moveToDashboardViewControllerScreen()

handle = true
break
case "Profile":
//Handle shortcut 3

//Move to Profile Screen
self.moveToProfileViewControllerScreen()

handle = true
break
case "Gift":
//Handle shortcut 4

//Move to Gift Screen
self.moveToGiftViewControllerScreen()

handle = true
break
default:
break
}

print("Select ShortCut Item.type:- \(shortcutItem.type)")
print("Select ShortCut Item.localizedTitle:- \(shortcutItem.localizedTitle)")

return handle
}

//MARK: - Search ViewController
func moveToSearchViewControllerScreen() -> () {

//gurad navigationController
guard let navigationController = UIApplication.shared.keyWindow?
.rootViewController as? UINavigationController else {
return
}

//Goto Search
let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
let viewcontroller = storyBoard.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController

var isController: Bool = true
for vController in (navigationController.viewControllers) {
// some process
if vController.isKind(of: SearchViewController.self) {
print("yes it is SearchViewController")

isController = false
return
}
}

if isController == true {
navigationController.pushViewController(viewcontroller, animated: true)
}

}

//MARK: - Dashboard ViewController
func moveToDashboardViewControllerScreen() -> () {

//gurad navigationController
guard let navigationController = UIApplication.shared.keyWindow?
.rootViewController as? UINavigationController else {
return
}

//Goto Search
let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
let viewcontroller = storyBoard.instantiateViewController(withIdentifier: DashboardViewController.identifier) as! DashboardViewController

var isController: Bool = true
for vController in (navigationController.viewControllers) {
// some process
if vController.isKind(of: DashboardViewController.self) {
print("yes it is DashboardViewController")

isController = false
return
}
}

if isController == true {
navigationController.pushViewController(viewcontroller, animated: true)
}

}

//MARK: - Profile ViewController
func moveToProfileViewControllerScreen() -> () {

//gurad navigationController
guard let navigationController = UIApplication.shared.keyWindow?
.rootViewController as? UINavigationController else {
return
}

//Goto Search
let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
let viewcontroller = storyBoard.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController

var isController: Bool = true
for vController in (navigationController.viewControllers) {
// some process
if vController.isKind(of: ProfileViewController.self) {
print("yes it is ProfileViewController")

isController = false
return
}
}

if isController == true {
navigationController.pushViewController(viewcontroller, animated: true)
}

}

//MARK: - Gift ViewController
func moveToGiftViewControllerScreen() -> () {

//gurad navigationController
guard let navigationController = UIApplication.shared.keyWindow?
.rootViewController as? UINavigationController else {
return
}

//Goto Search
let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
let viewcontroller = storyBoard.instantiateViewController(withIdentifier: GiftViewController.identifier) as! GiftViewController

var isController: Bool = true
for vController in (navigationController.viewControllers) {
// some process
if vController.isKind(of: GiftViewController.self) {
print("yes it is GiftViewController")

isController = false
return
}
}

if isController == true {
navigationController.pushViewController(viewcontroller, animated: true)
}

}
}




```


```objective-c
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

```

```objective-c

```objective-c

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

```


## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each this release can be found in the [CHANGELOG](CHANGELOG.mdown). 
