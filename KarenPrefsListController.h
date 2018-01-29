#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSSwitchTableCell.h>
#import <libprefs/prefs.h>
#import <UIKit/UIKit.h>
#import <version.h>
#include <spawn.h>

@interface KarenPrefsListController : PSListController
-(NSString *) karenPrefsLoadFromPlist;
-(NSString *) karenPrefsTwitterUsername;
-(NSString *) karenPrefsDonateURL;
-(NSString *) karenPrefsRepoURL;
-(NSString *) karenPrefsSiteURL;
-(NSString *) karenPrefsDeviantArtUsername;
-(NSString *) karenPrefsNavbarIconLoadFromImage;
-(UIColor *) karenPrefsCustomTintColor;
-(BOOL) karenPrefsShouldBypassCfprefsd;
-(void) respring;
-(void) openTwitter;
-(void) openSite;
-(void) openDonate;
-(void) openRepo;
-(void) openDeviantArt;
@end