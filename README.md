# KarenPrefs

KarenPrefs is a library that provides various conveniences and enhancements for developers seeking to create preference bundles for their iOS tweaks.

I originally wrote KarenPrefs back in 2013 for use with my tweak [mikoto](https://cydia.angelxwind.net/?page/net.angelxwind.mikoto), but only thought about open-sourcing it recently, since I've found it rather useful (especially for when I need to show/hide specifiers according to iOS version, something I use often in mikoto).

KarenPrefs is BSD-licensed. See `LICENSE` for more information.

### KarenPrefs setup and usage (assuming you already have the latest version of [Theos](https://github.com/theos/theos))

```
git clone https://github.com/angelXwind/KarenPrefs.git
cd KarenPrefs/
make setup
```

1. In your project's `Makefile`, add `karenprefs` to your `TweakName_LIBRARIES` variable.

1. In your project's `control` file, add `net.angelxwind.karenprefs` to the `Depends:` field.

### The various components of KarenPrefs

##### `KarenPrefsListController`

Tested to work on iOS 5/6/7/8/9/10/11.

This is a `PSListController` subclass that basically carries the weight of KarenPrefs' functionality.

In it, I implemented full support for [PreferenceLoader's CoreFoundationVersion filters](http://iphonedevwiki.net/index.php/PreferenceLoader#Filtering.5B4.5D), which is very useful for hiding/showing features according to iOS version.

That aside, I also added a few additional methods.

Here is a description of its basic methods:

1. `-(NSString *) karenPrefsLoadFromPlist` — Override this method and return the filename (_without_ `.plist` extension) of your desired plist that you want to load specifiers from. **Defaults to `nil` if not set.** This is the only thing you really need to override if you only desire basic functionality (with use of PreferenceLoader filters, etc.) from KarenPrefs.

1. `-(BOOL) shouldBypassCfprefsd` — If this is overriden to return `1`, KarenPrefs will read and write directly from your `plist` file, bypassing `cfprefsd`. Use this if you're loading your tweak's preferences directly from your `plist` on iOS 8+. If you use `cfprefsd` in your tweak, set this value to `0`. **Defaults to `1` if not set.**

1. `-(NSString *) karenPrefsNavbarIconLoadFromImage` — Override this method and return the filename (_without_ `.png` extension) of your desired PNG image that you want to display in the navigation bar. Defaults to `nil` if not set.

1. `-(void) respring` — When called, resprings the device intelligently (kills `backboardd` if running on iOS 6 and above, kills `SpringBoard` if running on iOS 5 and below).

Here is a description of its extra "convenience" methods (I use these for the "Credits" views in my tweaks' preferences):

1. `-(NSString *) karenPrefsDonateURL` — Override this method and return an URL that you want to open using `-(void) openDonate`.

1. `-(void) openDonate` — When called, opens the URL defined in `-(NSString *) karenPrefsDonateURL` in the web browser. Does nothing if `-(NSString *) karenPrefsDonateURL` is `nil`.

1. `-(NSString *) karenPrefsSiteURL` — Override this method and return an URL that you want to open using `-(void) openSite`.

1. `-(void) openSite` — When called, opens the URL defined in `-(NSString *) karenPrefsSiteURL` in the web browser. Does nothing if `-(NSString *) karenPrefsSiteURL` is `nil`.

1. `-(NSString *) karenPrefsRepoURL` — Override this method and return an Cydia/APT repo URL that you want to open using `-(void) openRepo`.

1. `-(void) openRepo` — When called, opens the Cydia/APT repo URL defined in `-(NSString *) karenPrefsRepoURL` in the Cydia. If Cydia is not installed (...for whatever reason), then it will display the repo URL in an `UIAlertView`. Does nothing if `-(NSString *) karenPrefsRepoURL` is `nil`.

1. `-(NSString *) karenPrefsTwitterUsername` — Override this method and return a Twitter username (_without_ the `@` username prefix) that you want to open using `-(void) openTwitter`.

1. `-(void) openTwitter` — When called, opens the Twitter username defined in `-(NSString *) karenPrefsTwitterUsername` in the official Twitter app. If the Twitter app is not installed, then it will open Twitter's web UI in the system's default browser instead. Does nothing if `-(NSString *) karenPrefsTwitterUsername` is `nil`.

1. `-(NSString *) karenPrefsDeviantArtUsername` — Override this method and return a deviantArt username that you want to open using `-(void) openDeviantArt`.

1. `-(void) openDeviantArt` — When called, opens the deviantArt username defined in `-(NSString *) karenPrefsDeviantArtUsername` in the official deviantArt app. If the deviantArt app is not installed, then it will open deviantArt's web UI in the system's default browser instead. Does nothing if `-(NSString *) karenPrefsDeviantArtUsername` is `nil`.

1. `-(NSString *) karenPrefsGitHubUsername` — Override this method and return a GitHub username that you want to open using `-(void) openGitHub`.

1. `-(void) openGitHub` — When called, opens the GitHub username defined in `-(NSString *) karenPrefsGitHubUsername` in the system's default browser. Does nothing if `-(NSString *) karenPrefsGitHubUsername` is `nil`.

1. `-(UIColor *) karenPrefsCustomTintColor` — Requires KarenPrefs version 1.2 or higher. (`Depends: net.angelxwind.karenprefs (>= 1.2)`) Override this method and return an `UIColor` to change the tint color of your preference pane. **Defaults to `nil` if not set.**

##### `KarenPrefsBannerCell`

Tested to work on iOS 5/6/7/8/9/10/11.

This is a `PSTableCell` subclass that sets an image as its own background.

Override `-(NSString *) karenPrefsBannerLoadFromImage` in your subclass's implementation to specify the filename of the **PNG** image (**without the extension!**) in your preference bundle that will be used as a banner.

In order to support the entire range of displays, you must have the following variations present in your bundle:

* **Non-Retina Display (iPhone 3GS, etc.):** `exampleBanner.png`

* **Retina Display (iPhone 4, 5, etc.):** `exampleBanner@2x.png`

* **4.7-inch Retina HD (iPhone 6, etc.):** `exampleBanner-667h@2x.png`

* **5.5-inch Retina HD (iPhone 6 Plus, etc.):** `exampleBanner@3x.png`

* **Super Retina HD Display (iPhone X):** `exampleBanner-812h@3x.png`

The height can be modified via your specifier plist by adding the `height` key/value pair in your property list. (Example: `<key>height</key><integer>205</integer>`)

##### `KarenPrefsAnimatedExitToSpringBoard`

Tested to work on iOS 5/6/7/8/9/10/11.

This adds the `-(void) animatedExit` method to `UIApplication` which when called, will gracefully close the Preferences app with the native iOS "closed app" animation, then terminate the process.

##### `KarenPrefsCustomTextColorButtonCell`

Tested to work on iOS 5/6/7/8/9/10/11.

This is a `PSTableCell` subclass that has a configurable text color.

Override `-(UIColor *) karenPrefsCustomTextColor` in your subclass's implementation to specify the text color of the cell.

##### `KarenPrefsBlackTextButtonCell`

Tested to work on iOS 5/6/7/8/9/10/11. Unnecessary if exclusively targeting iOS 5 and 6.

This is a `KarenPrefsCustomTextColorButtonCell` subclass that changes the text color to black.

Useful if you want a `PSButtonCell` on iOS 7 and above with black text instead of the default blue.

##### `KarenPrefsRedTextButtonCell`

Tested to work on iOS 5/6/7/8/9/10/11.

This is a `KarenPrefsCustomTextColorButtonCell` subclass that changes the text color to red.

Useful for buttons that perform destructive operations (such as "Reset Settings" buttons).

##### `KarenPrefsGreenTextButtonCell`

Tested to work on iOS 5/6/7/8/9/10/11.

This is a `KarenPrefsCustomTextColorButtonCell` subclass that changes the text color to green.

Useful for donation buttons.

##### `KarenPrefsPurpleTextButtonCell`

Tested to work on iOS 5/6/7/8/9/10/11.

This is a `KarenPrefsCustomTextColorButtonCell` subclass that changes the text color to purple.

##### `KarenPrefsCustomColorSwitchCell`

Tested to work on iOS 6/7/8/9/10/11. Requires KarenPrefs version 1.2 or higher. (`Depends: net.angelxwind.karenprefs (>= 1.2)`)

This is a `PSSwitchCell` subclass that has a configurable switch color.

Override `-(UIColor *) karenPrefsCustomSwitchColor` in your subclass's implementation to specify the color to set the switch to.

##### `KarenPrefsBounceBackSwitchCell`

Tested to work on iOS 6/7/8/9/10/11. Requires KarenPrefs version 1.2 or higher. (`Depends: net.angelxwind.karenprefs (>= 1.2)`)

Note that while this does *not* work on iOS 5, if the preference pane you are using this in also supports iOS 5, you must add `-F$(SYSROOT)/System/Library/PrivateFrameworks -weak_framework Preferences` to your `TweakName_LDFLAGS` Makefile variable to avoid a crash.

This is a `PSSwitchTableCell` subclass that is in a perpetual "on" state. When tapped, the switch will animate itself "bouncing back" to the on state.

In order for this to function properly, you must override `-(NSString *) karenPrefsBounceBackObserverName` with the name of an `NSNotificationCenter` observer. The way this works is that when the observer is called, the switch will be set to the "on" state.

Useful for communicating to users that there are options that cannot be disabled and are always enabled.

##### `KarenPrefsCustomColorBounceBackSwitchCell`

Tested to work on iOS 6/7/8/9/10/11. Requires KarenPrefs version 1.2 or higher. (`Depends: net.angelxwind.karenprefs (>= 1.2)`)

This is a `KarenPrefsBounceBackSwitchCell` subclass that has a configurable switch color.

Override `-(UIColor *) karenPrefsCustomSwitchColor` in your subclass's implementation to specify the color to set the switch to.

##### `KarenPrefsEditableTextCellWithReturn`

Tested to work on iOS 5/6/7/8/9/10/11.

This is a `PSEditableTableCell` subclass that just sets `-textFieldShouldReturn:textfield` to `1`. For more information on what `-(BOOL) textFieldShouldReturn:(UITextField *)textField` controls, consult [Apple's official documentation](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITextFieldDelegate_Protocol/#//apple_ref/occ/intfm/UITextFieldDelegate/textFieldShouldReturn:).