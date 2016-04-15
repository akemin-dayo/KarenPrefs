#import <UIKit/UIImage.h>
#import <Preferences/PSTableCell.h>

@interface PSTableCell (KarenPrefsBannerCell)
-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end

@interface KarenPrefsBannerCell : PSTableCell
-(NSString *) karenPrefsBannerLoadFromImage;
@end