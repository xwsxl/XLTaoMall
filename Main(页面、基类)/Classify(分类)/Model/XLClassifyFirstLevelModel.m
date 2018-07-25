//
//  XLClassifyFirstLevelModel.m
//  XLTaoMall
//
//  Created by Hawky on 2018/7/24.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLClassifyFirstLevelModel.h"

@implementation XLClassifyFirstLevelModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ClassiFyId":@"id"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"SmallClass_list":@"XLClassifySecondLevelModel"};
}
/*****  lazy loading *****/
-(NSArray *)SmallClass_list
{
    if (!_SmallClass_list) {
        _SmallClass_list=[[NSArray alloc] init];
    }
    return _SmallClass_list;
}
@end
