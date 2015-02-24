#import "UIAlertView+Additions.h"
#import "HelperFunctions.h"
#import <objc/runtime.h>

@interface PDFAlertWrapper : NSObject
@property (copy) void(^completionBlock)(UIAlertView *alertView, NSInteger buttonIndex);
@end

@implementation PDFAlertWrapper

#pragma mark - UIAlertViewDelegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completionBlock) {
        self.completionBlock(alertView, buttonIndex);
    }
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (self.completionBlock) {
        self.completionBlock(alertView, alertView.cancelButtonIndex);
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    if ([HelperFunctions isIOS8]) {
        // hack alert: fix bug in iOS 8 that prevents text field from appearing
        UITextRange *textRange = [[alertView textFieldAtIndex:0] selectedTextRange];
        [[alertView textFieldAtIndex:0] selectAll:nil];
        [[alertView textFieldAtIndex:0] setSelectedTextRange:textRange];
    }
}

@end

static const char kPDFAlertWrapper;
@implementation UIAlertView (Additions)

#pragma mark - Class Public

- (void)showWithCompletion:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))completion
{
    PDFAlertWrapper *alertWrapper = [[PDFAlertWrapper alloc] init];
    alertWrapper.completionBlock = completion;
    self.delegate = alertWrapper;
    
    // Set the wrapper as an associated object
    objc_setAssociatedObject(self, &kPDFAlertWrapper, alertWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // Show the alert as normal
    [self show];
}

@end