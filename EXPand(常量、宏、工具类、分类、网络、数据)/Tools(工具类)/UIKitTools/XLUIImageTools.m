//
//  XLUIImageTools.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/23.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLUIImageTools.h"

@implementation XLUIImageTools
//用颜色创建一张图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
