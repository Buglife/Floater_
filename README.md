![Floater💩](https://d19rwogc3unx97.cloudfront.net/assets/logo/floater_on_transparent_471x97-251372f87f8080fd5e0c57fa07be31b12eb2665fc2af62999cdecb6d11782457.png)

Easily add a floating fingertip to your app demo.

Ever tried to record a demo video of your app, but the end result looks weird without a finger on the screen? Floater💩 is a tool that puts a floating fingertip on your screen. It uses Xcode UI tests, and it's great. Your app needs it.

![Video](https://d19rwogc3unx97.cloudfront.net/assets/temp/floater1-ec98a567daaac8dacb253aeb03cb62fbce72ad73eaf10dee50eafd6d80095ef4.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### 1. Create UI test target

If you don't already have one, create a UI test target for your app.

### 2. Add Floater💩 to your app & UI test targets

#### CocoaPods

Floater💩 is available through [CocoaPods](http://cocoapods.org), **however the pod should not simply be imported in its entirety**. Rather, the two subspecs `Floater💩/AppStuff` and `Floater💩/UITestStuff` should each be included separately into your app target & UI test target, respectively.

```ruby
# Podfile
target 'MyApp' do
	pod 'Floater💩/AppStuff'
end

target 'MyAppUITests' do
	pod 'Floater💩/UITestStuff'
end
```

#### Sans CocoaPods

* Everything from `Floater💩/Classes/AppStuff` goes into your app target.
* Everything from `Floater💩/Classes/UITestStuff` goes into your UI test target.
* Everything from `Floater💩/Classes/Shared` goes into both your app target and your UI test target.
* Add [HSTestingBackchannel](https://github.com/ConfusedVorlon/HSTestingBackchannel) to both targets.

### 3. Use `Floater💩Application` as the application class

#### Swift

Remove `@UIApplicationMain` from your AppDelegate file, and create a main.swift file containing the following:

```swift
import Floater_

UIApplicationMain(Process.argc, Process.unsafeArgv, NSStringFromClass(Floater💩Application.self), NSStringFromClass(YOUR_APP_DELEGATE.self))
```

#### Objective-C

```objective-c
@import Floater_;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, NSStringFromClass([FLTRApplication class]), NSStringFromClass([AppDelegate class]));
    }
}
```


## Usage

1. Write UI tests!
	
	Write your UI tests as usual, with one difference: Use the `float💩()` method prior to each tap to move the floating fingertip between tap events.
	
	```swift
	let awesomeButton = XCUIApplication().buttons["Awesome Button"]
    awesomeButton.float💩()
    awesomeButton.tap()
	```
	
	You can call this method on both `XCUIElement` and `XCUICoordinate`.
	
	If you've never written Xcode UI tests, check out the WWDC 2015 session [UI Testing in Xcode](https://developer.apple.com/videos/play/wwdc2015/406/).

2. Run your tests in the simulator by hitting ⌘+U. You'll be presented with the following prompt:

	![Prompt](https://d19rwogc3unx97.cloudfront.net/assets/temp/lumbergh_alert-48089294266ce093ee54ec0176da863faa3f2b26b6876046a896080715b9975d.png)
	
	Hit “**Allow**”. This is necessary for the test process to communicate with your app process.

3. Use [Quicktime Player](https://support.apple.com/en-us/HT201066) to record your screen. Boom.
