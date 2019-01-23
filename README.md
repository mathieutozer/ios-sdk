# The EightBase iOS SDK

The EightBase iOS SDK, written in Swift

## Installation

### Available in CocoaPods

EightBase is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```objc
pod 'EightBase'
```

Then, from the command line, `cd` to your project directory, and do:

```
pod install
pod update
```

to install the EightBase pod and update it to the latest version of the SDK.

Make sure to do the `pod update`.  CocoaPods may not use the latest version of the SDK otherwise!

### Adding Auth0 Credentials

In your application bundle add a `plist` file named `Auth0.plist` with the following information.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>ClientId</key>
<string>{YOUR_CLIENT_ID}</string>
<key>Domain</key>
<string>{YOUR_DOMAIN}</string>
</dict>
</plist>
```

In your application's `Info.plist` file register your iOS Bundle Identifier as a custom scheme like this:
```xml
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleTypeRole</key>
<string>None</string>
<key>CFBundleURLName</key>
<string>auth0</string>
<key>CFBundleURLSchemes</key>
<array>
<string>{YOUR_BUNDLE_IDENTIFIER}</string>
</array>
</dict>
</array>
```

## Usage

## Initializing

You should authentificate using apiToken

```swift
EightBase.auth(with: __YOUR_8BASE_ENDPOINT__, apiToken: __YOUR_API_TOKEN__) { result in
switch(result) {
case .success():
print("Successfully authentificated")
break
case .failure(let error):
print("Failed with \(error)")
break
}
}
```
or idToken by passing `nil` for `apiToken`

```swift
EightBase.auth(with: __YOUR_8BASE_ENDPOINT__, apiToken: nil) { result in
    switch(result) {
        case .success():
            print("Successfully authentificated")
        break
        case .failure(let error):
            print("Failed with \(error)")
        break
    }
}
```

Allow EightBase to handle authentication callbacks. In your AppDelegate.swift add the following:
```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    return EightBase.resumeAuth(url, options: options)
}
```

To enable Face ID or Touch ID use the fillowing code:
```swift
EightBase.enableBiometrics(withTitle: "Touch ID / Face ID Login")
```

Call `logout` to clear all credentials

```swift
EightBase.logout()
```

# Apollo configuration details

## Downloading a schema

```
apollo schema:download --endpoint=___YOUR_ENDPOINT___/graphql schema.json
```

## Adding a code generation build step

In order to invoke apollo as part of the Xcode build process, create a build step that runs before “Compile Sources”.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script, change its name to “Generate Apollo GraphQL API” and drag it just above “Compile Sources”. Then add the following contents to the script area below the shell:

```swift
APOLLO_FRAMEWORK_PATH="$(eval find $FRAMEWORK_SEARCH_PATHS -name "Apollo.framework" -maxdepth 1)"

if [ -z "$APOLLO_FRAMEWORK_PATH" ]; then
    echo "error: Couldn't find Apollo.framework in FRAMEWORK_SEARCH_PATHS; make sure to add the framework to your project."
    exit 1
fi

cd "${SRCROOT}/${TARGET_NAME}"
$APOLLO_FRAMEWORK_PATH/check-and-run-apollo-cli.sh codegen:generate --queries="$(find . -name '*.graphql')" --schema=schema.json API.swift
```

The script above will invoke apollo through the check-and-run-apollo-cli.sh wrapper script, which is actually contained in the Apollo.framework bundle. The main reason for this is to check whether the version of apollo installed on your system is compatible with the framework version installed in your project, and to warn you if it isn’t. Without this check, you could end up generating code that is incompatible with the runtime code contained in the framework.

## Adding the generated API file to your target

Drag the generated API.swift file to your target.


## Full Apollo documentation

[Read the full docs at apollographql.com/docs/ios/](https://www.apollographql.com/docs/ios/)

## How migrate from Apollo

Just use Apollo variable from EightBase

You should just use `EightBase.Apollo`
```swift
EightBase.Apollo?.watch(query: AllCustomersQuery()) { (result, error) in
    if let error = error {
        NSLog("Error while fetching query: \(error.localizedDescription)")
        return
    }
    ...
}
```
