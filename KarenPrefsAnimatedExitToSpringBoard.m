#import "KarenPrefsAnimatedExitToSpringBoard.h"
#import <version.h>

@implementation UIApplication (KarenPrefsAnimatedExitToSpringBoard)
-(void) karenPrefsAnimatedExit {
	BOOL multitaskingSupported = NO;
	if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
		multitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
	}
	if ([self respondsToSelector:@selector(suspend)]) {
		if (multitaskingSupported) {
			[self beginBackgroundTaskWithExpirationHandler:^{}];
			// iOS 11 changed something and now delay values above 0 no longer work reliably (sometimes it will work, other times it will not)
			// Setting the delay value to 0 makes it look… ugly, to say the least (the app will flash to black before animating), but it's the best we can do until I figure out a better solution.
			// Note that setting a delay of 0 does not equate to instantaneous call, it still waits on the thread properly so the animation /does/ still work
			[self performSelector:@selector(exit) withObject:nil afterDelay:((kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_11_0) ? 0.4 : 0)];
		}
		[self suspend];
	} else {
		[self exit];
	}
}

-(void) exit {
	if ([self respondsToSelector:@selector(terminateWithSuccess)]) {
		[self terminateWithSuccess];
	} else {
		exit(0);
	}
}
@end