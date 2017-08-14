#import "KarenPrefsCustomColorBounceBackSwitchCell.h"

@implementation KarenPrefsCustomColorBounceBackSwitchCell
-(void) layoutSubviews {
	[super layoutSubviews];
	[((UISwitch *)[self control]) setOn:1 animated:1];
	if ([self karenPrefsCustomSwitchColor]) {
		[((UISwitch *)[self control]) setOnTintColor:[self karenPrefsCustomSwitchColor]];
	}
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setOn) name:[self karenPrefsBounceBackObserverName] object:nil];
}

-(NSString *) karenPrefsBounceBackObserverName {
	return nil;
}

-(void) setOn {
   [((UISwitch *)[self control]) setOn:1 animated:1];
}

-(UIColor *) karenPrefsCustomSwitchColor {
	return nil;
}
@end