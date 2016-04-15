#import <Preferences/PSTableCell.h>

@interface PSTableCell (KarenPrefsCustomTextColorButtonCell)
-(UILabel *) textLabel;
@end

@interface KarenPrefsCustomTextColorButtonCell : PSTableCell
-(UIColor *) karenPrefsCustomTextColor;
@end