#import "KarenPrefsBounceBackSwitchCell.h"

@implementation KarenPrefsBounceBackSwitchCell
-(void) layoutSubviews {
	[super layoutSubviews];
	[((UISwitch *)[self control]) setOn:1 animated:1];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setOn) name:@"resetAllAlert" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setOn) name:@"OTAAlert" object:nil];
}

-(void) setOn {
   [((UISwitch *)[self control]) setOn:1 animated:1];
}
@end