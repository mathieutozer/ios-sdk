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

#### Adding Auth0 Credentials

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


## Usage

#### Initializing

```swift
EightBase.auth(with: __YOUR_8BASE_ENDPOINT__)
```

## Apollo Documentation

[Read the full docs at apollographql.com/docs/ios/](https://www.apollographql.com/docs/ios/)

## How migrate from Apollo

Just use Apollo variable from EightBase

You should 
```swift
EightBase.Apollo?.watch(query: AllCustomersQuery()) { (result, error) in
    if let error = error {
        NSLog("Error while fetching query: \(error.localizedDescription)")
        return
    }
    ...
}
```
