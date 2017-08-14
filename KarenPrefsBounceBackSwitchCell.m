#import "KarenPrefsBounceBackSwitchCell.h"

@implementation KarenPrefsBounceBackSwitchCell
-(void) layoutSubviews {
	[super layoutSubviews];
	[((UISwitch *)[self control]) setOn:1 animated:1];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setOn) name:[self karenPrefsBounceBackObserverName] object:nil];
}

-(NSString *) karenPrefsBounceBackObserverName {
	return nil;
}

-(void) setOn {
	[((UISwitch *)[self control]) setOn:1 animated:1];
}
@end