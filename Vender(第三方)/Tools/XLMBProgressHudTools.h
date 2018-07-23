//
//  XLMBProgressHudTools.h
//  XLTaoMall
//
//  Created by Hawky on 2018/5/29.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLMBProgressHudTools : NSObject

/*****  显示文本信息 *****/
+(void)showText:(NSString *)str;
+(void)showText:(NSString *)str duration:(CGFloat )duration;

/*****  显示图片和文本信息 *****/
+(void)showImage:(UIImage *)image;
+(void)showImage:(UIImage *)image text:(NSString *)text;
+(void)showImage:(UIImage *)image text:(NSString *)text duration:(CGFloat )duration;


@end
