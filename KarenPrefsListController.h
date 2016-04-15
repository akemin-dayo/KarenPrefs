#import <Preferences/PSListController.h>

@interface PSListController (KarenPrefsListController)
-(void) loadView;
-(void) viewDidDisappear:(BOOL)animated;
@end

@interface KarenPrefsListController : PSListController
-(NSString *) karenPrefsLoadFromPlist;
-(NSString *) karenPrefsTwitterUsername;
-(NSString *) karenPrefsDonateURL;
-(NSString *) karenPrefsRepoURL;
-(NSString *) karenPrefsSiteURL;
-(NSString *) karenPrefsDeviantArtUsername;
-(NSString *) karenPrefsNavbarIconLoadFromImage;
-(BOOL) karenPrefsShouldBypassCfprefsd;
-(void) respring;
-(void) openTwitter;
-(void) openSite;
-(void) openDonate;
-(void) openRepo;
-(void) openDeviantArt;
@end