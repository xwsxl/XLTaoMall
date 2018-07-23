//
//  AppDelegate.m
//  XLTaoMall
//
//  Created by Hawky on 2018/4/10.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>
#import "IQKeyboardManager.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic,assign) NSInteger lastSelectIndex;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Bugly startWithAppId:@"7c576df44e"];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyWindow];

    self.XLMallTabBarVC = [[XLTabBarVC alloc] init];
    self.window.rootViewController = self.XLMallTabBarVC;
    self.XLMallTabBarVC.delegate=self;
    self.XLMallTabBarVC.selectedIndex=0;

    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    //防止键盘盖住输入框
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    return YES;
}


/* 选择了某个位置 */
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
  //  XLLog(@"index=%ld,lastSelectIndex=%ld",self.XLMallTabBarVC.selectedIndex,self.lastSelectIndex);
    if (self.XLMallTabBarVC.selectedIndex==self.lastSelectIndex) {
        XLLog(@"发送重复点击通知");
        [KNotificationCenter postNotificationName:XLNotiTabBarDidSelectedRepeated object:nil userInfo:@{@"index":[NSString stringWithFormat:@"%ld",self.XLMallTabBarVC.selectedIndex]}];
    }else
    {
        // XLLog(@"记录这一次选择的索引");
        self.lastSelectIndex=self.XLMallTabBarVC.selectedIndex;
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
