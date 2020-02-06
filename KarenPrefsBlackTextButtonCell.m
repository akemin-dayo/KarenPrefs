#import "KarenPrefsBlackTextButtonCell.h"

@implementation KarenPrefsBlackTextButtonCell
-(UIColor *) karenPrefsCustomTextColor {
	if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_13_0 && self.traitCollection.userInterfaceStyle == 2) { //UIUserInterfaceStyleDark
        return [UIColor whiteColor];
    }
	return [UIColor blackColor];
}
@end