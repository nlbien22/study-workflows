#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

__attribute__((constructor))
static void initTestFramework() {
    // Chạy trong block async main queue để tránh crash nếu app chưa load xong UI
    dispatch_async(dispatch_get_main_queue(), ^{
        // Lấy Root View Controller hiện tại của App
        UIViewController *rootVC = nil;
        UIWindow *window = nil;
        
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
                if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                    window = windowScene.windows.firstObject;
                    break;
                }
            }
        } else {
            window = [UIApplication sharedApplication].keyWindow;
        }
        
        rootVC = window.rootViewController;

        if (rootVC) {
            UIAlertController *alert = [UIAlertController 
                alertControllerWithTitle:@"🚀 INJECTED SUCCESS!"
                message:@"Dylib build từ GitHub Actions đã chạy thành công."
                preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"Tuyệt vời!" 
                                                     style:UIAlertActionStyleDefault 
                                                   handler:nil]];
            
            [rootVC presentViewController:alert animated:YES completion:nil];
        }
    });
}
