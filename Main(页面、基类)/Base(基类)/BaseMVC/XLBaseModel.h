//
//  XLBaseModel.h
//  XLTaoMall
//
//  Created by Hawky on 2018/4/10.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "MJExtension.h"
@interface XLBaseModel : NSObject

/*****  获取属性 *****/
- (NSArray *)getAllProperties;
/* 获取对象的所有属性 以及属性值 */
- (NSDictionary *)properties_aps;
/* 获取对象的所有方法 */
-(void)printMothList;



@end
