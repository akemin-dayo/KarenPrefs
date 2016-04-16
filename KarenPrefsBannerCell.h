#import <UIKit/UIImage.h>
#import <Preferences/PSTableCell.h>

#ifndef kCFCoreFoundationVersionNumber_IOS_8_0
#define kCFCoreFoundationVersionNumber_IOS_8_0 1140.10
#endif

@interface UIImage (KarenPrefsBannerCell)
+(UIImage *) imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@interface PSTableCell (KarenPrefsBannerCell)
-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

@interface KarenPrefsBannerCell : PSTableCell
-(NSString *) karenPrefsBannerLoadFromImage;
@end