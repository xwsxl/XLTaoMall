//
//  XLTabBarVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/4/12.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLTabBarVC.h"

#import "XLHomeVC.h"
#import "XLClassifyVC.h"
#import "XLShoppingCartVC.h"
#import "XLMineVC.h"

@interface XLTabBarVC ()
/**
 Description 4个模块导航栏
 */
@property (nonatomic, strong) UINavigationController                *homeNavi;
@property (nonatomic, strong) UINavigationController                *classifyNavi;
@property (nonatomic, strong) UINavigationController                *shoppingCartNavi;
@property (nonatomic, strong) UINavigationController                *profileNavi;

@end

@implementation XLTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBarItems];
    // Do any additional setup after loading the view.
}

/**
 Description 设置4个Tab
 */
- (void)setupTabBarItems {

    NSMutableArray *controllers = [NSMutableArray array];

    //首页
    XLHomeVC *homeVC = [[XLHomeVC alloc] init];
    UIImage *homeUnselectedImage = [[UIImage imageNamed:@"XL_TabBar_首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeSelectedImage = [[UIImage imageNamed:@"XL_TabBar_首页_选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.homeNavi = [[UINavigationController alloc] initWithRootViewController:homeVC]; //tabbar_chatsHL
    self.homeNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:homeUnselectedImage selectedImage:homeSelectedImage];
    self.homeNavi.navigationBar.barTintColor = MAINCOLOR;
    self.homeNavi.navigationItem.title = @"首页";
    homeVC.jz_navigationBarHidden = YES;
    [controllers addObject:self.homeNavi];

    //分类
    XLClassifyVC *classifyVC = [[XLClassifyVC alloc] init];
    UIImage *classifyUnselectedImage = [[UIImage imageNamed:@"XL_TabBar_分类"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *classifySelectedImage = [[UIImage imageNamed:@"XL_TabBar_分类_选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.classifyNavi = [[UINavigationController alloc] initWithRootViewController:classifyVC];
    self.classifyNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:classifyUnselectedImage selectedImage:classifySelectedImage];
    self.classifyNavi.navigationBar.barTintColor = MAINCOLOR;
    classifyVC.jz_navigationBarHidden = YES;
    [controllers addObject:self.classifyNavi];

    //购物车
    XLShoppingCartVC *shoppingCartVC = [[XLShoppingCartVC alloc] init];
    UIImage *classifyshoppingCartUnselectedImage = [[UIImage imageNamed:@"XL_TabBar_购物车"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *classifyshoppingCartSelectedImage = [[UIImage imageNamed:@"XL_TabBar_购物车_选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.shoppingCartNavi = [[UINavigationController alloc] initWithRootViewController:shoppingCartVC];
    self.shoppingCartNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:classifyshoppingCartUnselectedImage selectedImage:classifyshoppingCartSelectedImage];
    self.shoppingCartNavi.navigationBar.barTintColor = MAINCOLOR;
    self.shoppingCartNavi.navigationItem.title = @"购物车";
    shoppingCartVC.jz_navigationBarHidden = YES;
    [controllers addObject:self.shoppingCartNavi];

    //我的
    XLMineVC *profileVC = [[XLMineVC alloc] init];
    UIImage *profileUnselectedImage = [[UIImage imageNamed:@"XL_TabBar_我的"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *profileSelectedImage = [[UIImage imageNamed:@"XL_TabBar_我的_选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.profileNavi = [[UINavigationController alloc] initWithRootViewController:profileVC];
    self.profileNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:profileUnselectedImage selectedImage:profileSelectedImage];
    self.profileNavi.navigationBar.barTintColor = MAINCOLOR;
    self.profileNavi.navigationItem.title = @"我的";
    profileVC.jz_navigationBarHidden = YES;
    [controllers addObject:self.profileNavi];

    [self setViewControllers:controllers];

    [[UITabBar appearance] setBackgroundImage:[XLUIImageTools createImageWithColor:MAINCOLOR]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MAINBRIGHTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                     NSForegroundColorAttributeName:[UIColor whiteColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}

/**
 Description push到某个控制器

 @param viewController <#viewController description#>
 @param animated <#animated description#>
 */
- (void)pushToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation pushViewController:viewController animated:animated];
    }
}

/**
 Description 模态到某个控制器

 @param viewController <#viewController description#>
 @param animated <#animated description#>
 @param completion <#completion description#>
 */
- (void)presentToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation presentViewController:viewController animated:animated completion:completion];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
