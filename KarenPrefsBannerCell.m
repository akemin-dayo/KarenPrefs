#import "KarenPrefsBannerCell.h"

@implementation KarenPrefsBannerCell
-(NSString *) karenPrefsBannerLoadFromImage {
	return nil;
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
			UIImage *bannerImage = [UIImage imageNamed:[self karenPrefsBannerLoadFromImage] inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
			NSString *suffix = @"";
			if ([UIScreen mainScreen].bounds.size.height == 667.0) {
				suffix = @"-667h";
			} else if ([UIScreen mainScreen].bounds.size.height == 812.0) {
				suffix = @"-812h";
			}
			bannerImage = [UIImage imageNamed:[[self karenPrefsBannerLoadFromImage] stringByAppendingString:suffix] inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil] ?: bannerImage;
			[self addSubview:[[UIImageView alloc] initWithImage:bannerImage]];
		} else {
			[self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:[self karenPrefsBannerLoadFromImage] inBundle:[NSBundle bundleForClass:self.class]]]];
		}
	}
	return self;
}
@end