#import <UIKit/UIKit.h>

@interface UIApplication (Private)
-(void) suspend;
-(void) terminateWithSuccess;
@end

@interface UIApplication (KarenPrefsAnimatedExitToSpringBoard)
-(void) karenPrefsAnimatedExit;
@end