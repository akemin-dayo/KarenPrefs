# KarenPrefs

KarenPrefs is a library that provides various conveniences and enhancements for developers seeking to create preference bundles for their iOS tweaks.

I originally wrote KarenPrefs back in 2013 for use with my tweak [mikoto](https://cydia.angelxwind.net/?page/net.angelxwind.mikoto), but only thought about open-sourcing it recently, since I've found it rather useful (especially for when I need to show/hide specifiers according to iOS version, something I use often in mikoto).

KarenPrefs is BSD-licensed. See `LICENSE` for more information.

### KarenPrefs setup and usage (assuming you already have [Theos](https://github.com/theos/theos))

1. `git clone https://github.com/angelXwind/KarenPrefs.git`

1. `cd KarenPrefs/`

1. `make install-to-theos`

1. In your project's `Makefile`, add `karenlocalizer` to your `TweakName_LIBRARIES` variable.

1. In your project's `control` file, add `net.angelxwind.karenprefs` to the `Depends:` field.

### The various components of KarenPrefs

##### `KarenPrefsListController`

Tested to work on iOS 5/6/7/8/9.

This is a `PSListController` subclass that basically carries the weight of KarenPrefs' functionality.

In it, I implemented full support for [PreferenceLoader's CoreFoundationVersion filters](http://iphonedevwiki.net/index.php/PreferenceLoader#Filtering.5B4.5D), which is very useful for hiding/showing features according to iOS version.

That aside, I also added a few additional methods.

Here is a description of its basic methods:

1. `-(NSString *) karenPrefsLoadFromPlist` — Override this method and return the filename (without `.plist` extension) of your desired plist that you want to load specifiers from. **Defaults to `nil` if not set.** This is the only thing you really need to override if you only desire basic functionality (with use of PreferenceLoader filters, etc.) from KarenPrefs.

1. `-(BOOL) shouldBypassCfprefsd` — If this is overriden to return `1`, KarenPrefs will read and write directly from your `plist` file, bypassing `cfprefsd`. Use this if you're loading your tweak's preferences directly from your `plist` on iOS 8+. If you use `cfprefsd` in your tweak, set this value to `0`. **Defaults to `1` if not set.**

1. `-(NSString *) karenPrefsNavbarIconLoadFromImage` — Override this method and return the filename (without `.png` extension) of your desired PNG image that you want to display in the navigation bar. Defaults to `nil` if not set.

1. `-(void) respring` — When called, resprings the device intelligently (kills `backboardd` if running on iOS 6 and above, kills `SpringBoard` if running on iOS 5 and below).

Here is a description of its extra "convenience" methods (I use these for the "Credits" views in my tweaks' preferences):

1. `-(NSString *) karenPrefsDonateURL` — Override this method and return an URL that you want to open using `-(void) openDonate`.

1. `-(void) openDonate` — When called, opens the URL defined in `-(NSString *) karenPrefsDonateURL` in the web browser. Does nothing if `-(NSString *) karenPrefsDonateURL` is `nil`.

1. `-(NSString *) karenPrefsSiteURL` — Override this method and return an URL that you want to open using `-(void) openSite`.

1. `-(void) openSite` — When called, opens the URL defined in `-(NSString *) karenPrefsSiteURL` in the web browser. Does nothing if `-(NSString *) karenPrefsSiteURL` is `nil`.

1. `-(NSString *) karenPrefsRepoURL` — Override this method and return an Cydia/APT repo URL that you want to open using `-(void) openRepo`.

1. `-(void) openRepo` — When called, opens the Cydia/APT repo URL defined in `-(NSString *) karenPrefsRepoURL` in the Cydia. If Cydia is not installed (...for whatever reason), then it will display the repo URL in an `UIAlertView`. Does nothing if `-(NSString *) karenPrefsRepoURL` is `nil`.

1. `-(NSString *) karenPrefsTwitterUsername` — Override this method and return a Twitter username (without the `@` username prefix) that you want to open using `-(void) openTwitter`.

1. `-(void) openTwitter` — When called, opens the Twitter username defined in `-(NSString *) karenPrefsTwitterUsername` in the official Twitter app. If the Twitter app is not installed, then it will open Twitter's web UI instead. Does nothing if `-(NSString *) karenPrefsTwitterUsername` is `nil`.

1. `-(NSString *) karenPrefsDeviantArtUsername` — Override this method and return a deviantArt username that you want to open using `-(void) openDeviantArt`.

1. ``-(void) openDeviantArt` — When called, opens the deviantArt username defined in `-(NSString *) karenPrefsDeviantArtUsername` in the official deviantArt app. If the deviantArt app is not installed, then it will open deviantArt's web UI instead. Does nothing if `-(NSString *) karenPrefsDeviantArtUsername` is `nil`.


##### `KarenPrefsBannerCell`

Tested to work on iOS 5/6/7/8/9.

This is a `PSTableCell` subclass that sets an image as its own background.

Override `-(NSString *) karenPrefsBannerLoadFromImage` in your subclass's implementation to specify the filename of the image in your preference bundle that will be used as a banner.

The height can be modified via your specifier plist by adding the `height` key/value pair. (Example: `<key>height</key><integer>205</integer>`)

##### `KarenPrefsAnimatedExitToSpringBoard`

Tested to work on iOS 5/6/7/8/9.

This adds the `-(void) animatedExit` method to `UIApplication` which when called, will gracefully close the Preferences app with the native iOS "closed app" animation, then terminate the process.

##### `KarenPrefsCustomTextColorButtonCell`

Tested to work on iOS 5/6/7/8/9.

This is a `PSTableCell` subclass that changes the text color to any `UIColor *`.

Override `-(UIColor *) karenPrefsCustomTextColor` in your subclass's implementation to specify the text color of the cell.

Some pre-made subclasses are already included with KarenPrefs (`KarenPrefsBlackTextButtonCell`, `KarenPrefsRedTextButtonCell`, `KarenPrefsGreenTextButtonCell`, `KarenPrefsPurpleTextButtonCell`).

##### `KarenPrefsBlackTextButtonCell`

Tested to work on iOS 5/6/7/8/9. Unnecessary if exclusively targeting iOS 5 and 6.

This is a `KarenPrefsCustomTextColorButtonCell` subclass that changes the text color to black.

I wrote this because iOS 7 and above use a blue text color in their `PSButtonCell` implementations, and I wanted a black one for mikoto's `PSButtonCell` buttons.

##### `KarenPrefsRedTextButtonCell`

Tested to work on iOS 5/6/7/8/9.

This is a `KarenPrefsCustomTextColorButtonCell` subclass that changes the text color to red.

Useful for making scary-looking "Reset Settings" buttons.

##### `KarenPrefsGreenTextButtonCell`

Tested to work on iOS 5/6/7/8/9.

This is a `KarenPrefsCustomTextColorButtonCell` subclass that changes the text color to green.

I use this for my "Donate Using PayPal" buttons.

##### `KarenPrefsPurpleTextButtonCell`

Tested to work on iOS 5/6/7/8/9.

This is a `KarenPrefsCustomTextColorButtonCell` subclass that changes the text color to purple.

##### `KarenPrefsBounceBackSwitchCell`

Tested to work on iOS 6/7/8/9. If you're supporting iOS 5, you must add `-F$(SYSROOT)/System/Library/PrivateFrameworks -weak_framework Preferences` to your `TweakName_LDFLAGS` Makefile variable to avoid a crash.

This is a `PSSwitchTableCell` subclass that is in a perpetual "on" state. When tapped, the switch will animate itself "bouncing back" to the on state.

I wrote this for [mikoto](https://cydia.angelxwind.net/?page/net.angelxwind.mikoto), where it's used for two options ("OTA Software Update Disabler" and "Reset All Disabler") that are intentionally not disableable by design.

##### `KarenPrefsEditableTextCellWithReturn`

Tested to work on iOS 5/6/7/8/9.

This is a `PSEditableTableCell` subclass that just sets `-textFieldShouldReturn:textfield` to `1`. For more information on what `-(BOOL) textFieldShouldReturn:(UITextField *)textField` controls, consult [Apple's official documentation](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITextFieldDelegate_Protocol/#//apple_ref/occ/intfm/UITextFieldDelegate/textFieldShouldReturn:).
