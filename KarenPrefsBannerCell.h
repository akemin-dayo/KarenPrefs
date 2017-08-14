#import <UIKit/UIImage.h>
#import <Preferences/PSTableCell.h>
#import <version.h>

// +imageNamed:inBundle: is private but +imageNamed:inBundle:compatibleWithTraitCollection: is not, however the latter is only available on iOS >= 8.
@interface UIImage (Private)
+(UIImage *) imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@interface KarenPrefsBannerCell : PSTableCell
-(NSString *) karenPrefsBannerLoadFromImage;
@end