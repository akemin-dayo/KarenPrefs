#import "KarenPrefsBannerCell.h"

@implementation KarenPrefsBannerCell
-(NSString *) karenPrefsBannerLoadFromImage {
	return nil;
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
			[self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[self karenPrefsBannerLoadFromImage] inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil]]];
		} else {
			[self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[self karenPrefsBannerLoadFromImage] inBundle:[NSBundle bundleForClass:self.class]]]];
		}
	}
	return self;
}
@end