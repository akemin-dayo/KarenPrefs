#import "KarenPrefsCustomColorListItemsController.h"

@implementation KarenPrefsCustomColorListItemsController
-(UIColor *) karenPrefsCustomTintColor {
	return nil;
}

-(void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
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

-(void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	if ([self karenPrefsCustomTintColor]) {
		UIWindow *window = [[UIApplication sharedApplication] keyWindow];
		if (!window) {
			window = [[[UIApplication sharedApplication] windows] firstObject];
		}
		if ([window respondsToSelector:@selector(setTintColor:)]) {
			[window setTintColor:nil];
		}
	}
}
@end