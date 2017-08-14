#import "KarenPrefsListController.h"

@implementation KarenPrefsListController
-(NSString *) karenPrefsLoadFromPlist {
	return nil;
}

-(NSString *) karenPrefsTwitterUsername {
	return nil;
}

-(NSString *) karenPrefsDonateURL {
	return nil;
}

-(NSString *) karenPrefsRepoURL {
	return nil;
}

-(NSString *) karenPrefsSiteURL {
	return nil;
}

-(NSString *) karenPrefsDeviantArtUsername {
	return nil;
}

-(NSString *) karenPrefsNavbarIconLoadFromImage {
	return nil;
}

-(UIColor *) karenPrefsCustomTintColor {
	return nil;
}

-(BOOL) karenPrefsShouldBypassCfprefsd {
	return 1;
}

-(BOOL) karenPrefsIsRootBundle {
	return 1;
}

-(NSArray *) loadSpecifiersFromPlistName:(NSString *)plistName target:(PSListController *)target {
	NSMutableArray *plistSpecifiers = [[super loadSpecifiersFromPlistName:plistName target:target] mutableCopy];
	NSMutableArray *sakujo = [[NSMutableArray alloc] init];
	for (PSSpecifier *currentSpecifier in plistSpecifiers) {
		if (![PSSpecifier environmentPassesPreferenceLoaderFilter:[currentSpecifier.properties objectForKey:PLFilterKey]]) {
			[sakujo addObject:currentSpecifier];
		}
	}
	if ([sakujo count] > 0) {
		[plistSpecifiers removeObjectsInArray:sakujo];
	}
	return [plistSpecifiers copy];
}

-(id) specifiers {
	if (_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:[self karenPrefsLoadFromPlist] target:self] retain];
	}
	return _specifiers;
}

-(id) readPreferenceValue:(PSSpecifier *)specifier {
	if ([self karenPrefsShouldBypassCfprefsd]) {
		NSDictionary *karenPrefsPlist = [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]]];
		if (![karenPrefsPlist objectForKey:[specifier.properties objectForKey:@"key"]]) {
			return [specifier.properties objectForKey:@"default"];
		}
		return [karenPrefsPlist objectForKey:[specifier.properties objectForKey:@"key"]];
	}
	return [super readPreferenceValue:specifier];
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
	if ([self karenPrefsShouldBypassCfprefsd]) {
		NSMutableDictionary *karenPrefsPlist = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]]];
		[karenPrefsPlist setObject:value forKey:[specifier.properties objectForKey:@"key"]];
		[karenPrefsPlist writeToFile:[NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", [specifier.properties objectForKey:@"defaults"]] atomically:1];
		if ([specifier.properties objectForKey:@"PostNotification"]) {
			CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)[specifier.properties objectForKey:@"PostNotification"], NULL, NULL, YES);
		}
	}
	[super setPreferenceValue:value specifier:specifier];
}

-(void) loadView {
	[super loadView];
	if ([self karenPrefsNavbarIconLoadFromImage]) {
		[self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[self karenPrefsNavbarIconLoadFromImage] inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]]];
	}
	if ([self karenPrefsCustomTintColor]) {
		UIWindow *window = [[UIApplication sharedApplication] keyWindow];
		if (!window) {
			window = [[[UIApplication sharedApplication] windows] firstObject];
		}
		if ([window respondsToSelector:@selector(setTintColor:)]) {
			[window setTintColor:[self karenPrefsCustomTintColor]];
		}
	}
}

-(void) _unloadBundleControllers {
	[super _unloadBundleControllers];
	if ([self karenPrefsCustomTintColor] && [self karenPrefsIsRootBundle]) {
		UIWindow *window = [[UIApplication sharedApplication] keyWindow];
		if (!window) {
			window = [[[UIApplication sharedApplication] windows] firstObject];
		}
		if ([window respondsToSelector:@selector(setTintColor:)]) {
			[window setTintColor:nil];
		}
	}
}

// For some bizarre reason, some preference bundles (like the one I wrote for AirSpeaker) don't call -_unloadBundleControllers!?
// This is a workaround for those strange edge cases.
// However, the current (commented-out) implementation has a bug where it will reset the tint color if you transition (via say, a `PSLinkCell`) to any other view.
/*
-(void) viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	if ([self karenPrefsCustomTintColor] && [self karenPrefsIsRootBundle]) {
		UIWindow *window = [[UIApplication sharedApplication] keyWindow];
		if (!window) {
			window = [[[UIApplication sharedApplication] windows] firstObject];
		}
		if ([window respondsToSelector:@selector(setTintColor:)]) {
			[window setTintColor:nil];
		}
	}
}
*/

-(void) respring {
	pid_t respringPid;
	char *respringArgv[] = {"/usr/bin/killall", (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_6_0) ? "backboardd" : "SpringBoard", NULL};
	posix_spawn(&respringPid, respringArgv[0], NULL, NULL, respringArgv, NULL);
	waitpid(respringPid, NULL, WEXITED);
}

-(void) openTwitter {
	if ([self karenPrefsTwitterUsername]) {
		NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", [self karenPrefsTwitterUsername]]];
		if ([[UIApplication sharedApplication] canOpenURL:twitterURL]) {
			[[UIApplication sharedApplication] openURL:twitterURL];
		} else {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@", [self karenPrefsTwitterUsername]]]];
		}
	}
}

-(void) openSite {
	if ([self karenPrefsSiteURL]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self karenPrefsSiteURL]]];
	}
}

-(void) openDonate {
	if ([self karenPrefsDonateURL]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self karenPrefsDonateURL]]];
	}
}

-(void) openRepo {
	if ([self karenPrefsRepoURL]) {
		NSURL *cydiaURL = [NSURL URLWithString:[NSString stringWithFormat:@"cydia://url/https://cydia.saurik.com/api/share#?source=%@", [self karenPrefsRepoURL]]];
		if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) {
			[[UIApplication sharedApplication] openURL:cydiaURL];
		} else {
			UIAlertView *cydiaNotInstalled = [[UIAlertView alloc] initWithTitle:@"Cydia/APT Repository URL"
				message:[self karenPrefsRepoURL]
				delegate:self
				cancelButtonTitle:@"OK"
				otherButtonTitles:nil];
			[cydiaNotInstalled show];
		}
	}
}

-(void) openDeviantArt {
	if ([self karenPrefsDeviantArtUsername]) {
		NSURL *daURL = [NSURL URLWithString:[NSString stringWithFormat:@"deviantart://profile/%@", [self karenPrefsDeviantArtUsername]]];
		if ([[UIApplication sharedApplication] canOpenURL:daURL]) {
			[[UIApplication sharedApplication] openURL:daURL];
		} else {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://%@.deviantart.com/", [self karenPrefsDeviantArtUsername]]]];
		}
	}
}
@end