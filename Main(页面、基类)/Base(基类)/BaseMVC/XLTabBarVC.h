//
//  XLTabBarVC.h
//  XLTaoMall
//
//  Created by Hawky on 2018/4/12.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLTabBarVC : UITabBarController<UITabBarControllerDelegate>

/**
 Description 模态到某个控制器

 @param viewController <#viewController description#>
 @param animated <#animated description#>
 @param completion <#completion description#>
 */
- (void)presentToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

/**
 Description push到某个控制器

 @param viewController <#viewController description#>
 @param animated <#animated description#>
 */
- (void)pushToViewController:(UIViewController *)viewController animated:(BOOL)animated;


@end
