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
buildscript {
    dependencies {
        classpath 'com.android.tools.build:gradle:3.1.4'
+       classpath 'com.google.gms:google-services:4.3.10'    // Or higher.
    }

}

allprojects {
    repositories {
        mavenLocal()
        .
        .
        .
+       maven {
+           // Required capacitor-background-geolocation-firebase
+           url("${project(':transistorsoft-capacitor-background-geolocation-firebase').projectDir}/libs")
+       }

    }
}
```

### :open_file_folder: **`android/variables.gradle`**


```diff
ext {
    .
    .
    .
+   firebaseCoreVersion = "19.0.1"                  // Or higher.
+   firebaseFirestoreVersion = "23.0.3"             // Or higher.

}

```

### :open_file_folder: **`android/app/build.gradle`**

```diff

dependencies {
    .
    .
    .
}

+ apply plugin: 'com.google.gms.google-services'
```

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

