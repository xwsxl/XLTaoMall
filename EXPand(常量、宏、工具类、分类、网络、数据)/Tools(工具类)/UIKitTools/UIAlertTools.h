//
//  UIAlertTools.h
//  aTaohMall
//
//  Created by DingDing on 2017/8/21.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define cancelIndex    (-1)
@interface UIAlertTools : NSObject
typedef void(^AlertViewBlock)(NSInteger buttonTag);

/**
 创建alert   titleArray数组为nil时,不创建确定按钮，否则都会创建

 @param title 标题
 @param message  信息
 @param cancelTitle  取消按钮的标题
 @param titleArray 按钮数组
 @param vc 由哪个vc推出
 @param confirm 按钮点击回调 -1为取消，0为确定，其它为titleArray下标
 */
+(UIAlertController *)showAlertWithTitle:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
      alertStyle:(UIAlertControllerStyle)style
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm;
@end
