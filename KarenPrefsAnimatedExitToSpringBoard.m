#import "KarenPrefsAnimatedExitToSpringBoard.h"

@implementation UIApplication (KarenPrefsAnimatedExitToSpringBoard)
-(void) karenPrefsAnimatedExit {
	BOOL multitaskingSupported = NO;
	if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
		multitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
	}
	if ([self respondsToSelector:@selector(suspend)]) {
		if (multitaskingSupported) {
			[self beginBackgroundTaskWithExpirationHandler:^{}];
			[self performSelector:@selector(exit) withObject:nil afterDelay:0.4];
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