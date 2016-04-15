#import "KarenPrefsCustomTextColorButtonCell.h"

@implementation KarenPrefsCustomTextColorButtonCell
-(UIColor *) karenPrefsCustomTextColor {
	return nil;
}

-(void) layoutSubviews {
	[super layoutSubviews];
	[[self textLabel] setTextColor:[self karenPrefsCustomTextColor]];
}
@end