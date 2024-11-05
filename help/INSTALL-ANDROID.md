# Android Setup (Required)

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

## Gradle Configuration

### :open_file_folder: **`android/build.gradle`**

```diff
allprojects {
    repositories {
        google()
        mavenCentral()
        // capacitor-background-geolocation
        maven { url("${project(':transistorsoft-capacitor-background-geolocation').projectDir}/libs") }
        maven { url 'https://developer.huawei.com/repo/' }
        // capacitor-background-fetch
        maven { url("${project(':transistorsoft-capacitor-background-fetch').projectDir}/libs") }
+       // capacitor-background-geolocation-firebase
+       maven { url("${project(':transistorsoft-capacitor-background-geolocation-firebase').projectDir}/libs") }
    }
}
```

### :open_file_folder: **`android/variables.gradle`**


```diff
ext {
    .
    .
    .
+   FirebaseSDKVersion = "33.4.0" // or as-desired

}

```

> [!NOTE]  
> the param __`ext.FirebaseSdkVersion`__ controls the imported version of the *Firebase SDK* (`com.google.firebase:firebase-bom`).  Consult the [Firebase Release Notes](https://firebase.google.com/support/release-notes/android?_gl=1*viqpog*_up*MQ..*_ga*MTE1NjI2MDkuMTcyOTA4ODY0MQ..*_ga_CW55HF8NVT*MTcyOTA4ODY0MS4xLjAuMTcyOTA4ODY0MS4wLjAuMA..#latest_sdk_versions) to determine the latest version of the *Firebase* SDK


### :open_file_folder: **`google-services.json`**

Download your `google-services.json` from the *Firebase Console*.  Copy the file to your `android/app` folder.

## AndroidManifest.xml

:open_file_folder: **`android/app/src/main/AndroidManifest.xml`**

```diff
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.transistorsoft.backgroundgeolocation.react">

  <application
    android:name=".MainApplication"
    android:allowBackup="true"
    android:label="@string/app_name"
    android:icon="@mipmap/ic_launcher"
    android:theme="@style/AppTheme">

    <!-- capacitor-background-geolocation-firebase licence -->
+   <meta-data android:name="com.transistorsoft.firebaseproxy.license" android:value="YOUR_LICENCE_KEY_HERE" />
    .
    .
    .
  </application>
</manifest>

```

:information_source: [Purchase a License](https://shop.transistorsoft.com/collections/frontpage/products/background-geolocation-firebase)

