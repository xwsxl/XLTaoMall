//
//  XLMBProgressHudTools.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/29.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLMBProgressHudTools.h"
#import "MBProgressHUD.h"
@implementation XLMBProgressHudTools

/*****  显示文本信息 *****/
+(void)showText:(NSString *)str
{
    [XLMBProgressHudTools showText:str duration:2.0];
}
+(void)showText:(NSString *)str duration:(CGFloat )duration
{
    UIViewController *VC=[XLMBProgressHudTools getCurrentVC];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:VC.view animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.label.text=str;
    [hud hideAnimated:YES afterDelay:duration];
}

/*****  显示图片和文本信息 *****/
+(void)showImage:(UIImage *)image
{
    [XLMBProgressHudTools showImage:image text:@""];
}
+(void)showImage:(UIImage *)image text:(NSString *)text
{
    [XLMBProgressHudTools showImage:image text:text duration:2.0];
}
+(void)showImage:(UIImage *)image text:(NSString *)text duration:(CGFloat )duration
{
    UIViewController *VC=[XLMBProgressHudTools getCurrentVC];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:VC.view animated:YES];

    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image1 = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.label.text = text;

    [hud hideAnimated:YES afterDelay:duration];
}

#pragma mark - 获取当前最上层视图控制器
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }

    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;

    return result;
}

@end
