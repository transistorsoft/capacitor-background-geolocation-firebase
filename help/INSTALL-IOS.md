# iOS Setup (Required)

### With `npm`

```shell
$ npm install capacitor-background-geolocation-firebase --save
$ npx cap sync
```

### With `yarn`

```shell
$ yarn add capacitor-background-geolocation-firebase
$ npx cap sync
```

### :open_file_folder: **`AppDelegate.swift`**

Add the following code:

```diff
import UIKit
import Capacitor
import TSBackgroundFetch
+import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

+       FirebaseApp.configure()
        .
        .
        .
        return true
    }
}

```

### **`Google-Services-Info.plist`**

From your **Firebase Console**, copy your downloaded `Google-Services-Info.plist` file into your application:

![](https://dl.dropboxusercontent.com/s/4s7kfa6quusqk7i/Google-Services.plist.png?dl=1)
