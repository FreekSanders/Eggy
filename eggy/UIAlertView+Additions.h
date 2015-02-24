// thanks to: http://nscookbook.com/2013/04/ios-programming-recipe-22-simplify-uialertview-with-blocks/

#import <UIKit/UIKit.h>

@interface UIAlertView (Additions)
- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion;
@end