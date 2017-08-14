#import "KarenPrefsCustomColorSwitchCell.h"

@implementation KarenPrefsCustomColorSwitchCell
-(void) layoutSubviews {
	[super layoutSubviews];
	if ([self karenPrefsCustomSwitchColor]) {
		[((UISwitch *)[self control]) setOnTintColor:[self karenPrefsCustomSwitchColor]];
	}
}

-(UIColor *) karenPrefsCustomSwitchColor {
	return nil;
}
@end