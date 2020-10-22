# base_app

Base App that contain all the boilerplate (MVVM and Provider).copy and past `lib` and `asset` folder

# Flavor Setup 
## Android 
- Add flavor dimension to `android/app/build.gradle`
    ```
    flavorDimensions "flavor-type"
    productFlavors {
        dev {
            dimension "flavor-type"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
        }
        stage {
            dimension "flavor-type"
            applicationIdSuffix ".stage"
            versionNameSuffix "-stage"
        }
        prod {
            dimension "flavor-type"
        }
    }
- Create `strings.xml` file in `android/app/src/main/res/values`
    ```
    <?xml version="1.0" encoding="utf-8"?>
    <resources>
        <string name="app_name">base_app</string>
    </resources>
- use strings value `android:label="@string/app_name"`    
- create flavor file in `android/app/src`

## IOS

- Create in the ios/Flutter folder a configuration file for every flavor. Add config fie in `ios/flutter` folder and paste below code. Prod config should
include `#include "Pods/Target Support Files/Pods-Runner/Pods-Runner.release.xcconfig"`
    ```
    #include "Pods/Target Support Files/Pods-Runner/Pods-Runner.debug.xcconfig"
    #include "Generated.xcconfig"
    FLUTTER_TARGET=lib/main_dev.dart
    APP_NAME=[DEV] BaseApp
    BUNDLE_SUFFIX =.prod
> **Note** file name should be the same with flavor ex : `dev.xcconfig`

- change info.plist value for `Bundle name` key to `$(APP_NAME)`
- change info.plist value for `Bundle identifier` key to `$(PRODUCT_BUNDLE_IDENTIFIER)$(BUNDLE_SUFFIX)`
- add configuration in `Runner/info/configuration`. Map the configuration with respective flavor for example : Debug-Dev map to dev flavor
- Then create a new ***scheme*** for every flavor. 
>Remember to check the shared checkbox in the dialog.

