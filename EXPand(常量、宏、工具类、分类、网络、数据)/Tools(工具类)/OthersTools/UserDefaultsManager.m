//
//  UserDefaultsManager.m
//  YFQChildPro
//
//  Created by ab on 2017/4/13.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import "UserDefaultsManager.h"


@implementation UserDefaultsManager
/*****  用户名 *****/
+(NSString *)getAccount
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str=[userDefaults stringForKey:@"account"];
    [userDefaults synchronize];
    if (!str||[str isEqual:[[NSNull alloc] init]]) {
        str=@"";
    }
    return str;
}
+(void)setAccount:(NSString *)account
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account forKey:@"account"];
    [userDefaults synchronize];
}
/*****  密码 *****/
+(NSString *)getPassword
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str=[userDefaults stringForKey:@"password"];
    [userDefaults synchronize];
    return str;
}
+(void)setPassword:(NSString *)password
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
}
/*****  sigen值 *****/
+(NSString *)getSigen
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str=[userDefaults stringForKey:@"sigen"];
    [userDefaults synchronize];
    if (!str||[str isEqual:[[NSNull alloc] init]]) {
        str=@"";
    }
    return str;
}
+(void)setSigen:(NSString *)Sigen
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:Sigen forKey:@"sigen"];
    [userDefaults synchronize];
}
/*****  删除用户信息 *****/
+(void)removeUserInfo
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"sigen"];
    [userDefaults removeObjectForKey:@"password"];
    [userDefaults synchronize];
}

#pragma mark - 搜索文件存储
//缓存商品搜索数组
+(void)SearchText :(NSString *)seaTxt
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组

    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    if ([searTXT containsObject:seaTxt]) {
        [searTXT removeObject:seaTxt];
    }
    [searTXT addObject:seaTxt];
    while (searTXT.count>10) {
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    [userDefaultes setObject:searTXT forKey:@"myArray"];
    [userDefaultes synchronize];
}

+(void)removeGoodsSearchArray{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"myArray"];
    [userDefaults synchronize];
}

//缓存订单搜索数组
+(void)SearchDingDanText:(NSString *)seaTxt{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [userDefaultes arrayForKey:@"myDingDanArray"];
    if (myArray.count > 0) {//先取出数组，判断是否有值，有值继续添加，无值创建数组

    }else{
        myArray = [NSArray array];
    }
    // NSArray --> NSMutableArray
    NSMutableArray *searTXT = [myArray mutableCopy];
    if ([searTXT containsObject:seaTxt]) {
        [searTXT removeObject:seaTxt];
    }
    [searTXT addObject:seaTxt];
    while (searTXT.count>12) {
        [searTXT removeObjectAtIndex:0];
    }
    //将上述数据全部存储到NSUserDefaults中
    //        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:searTXT forKey:@"myDingDanArray"];
    [userDefaultes synchronize];
}

+(void)removeDingDanSearchArray{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"myDingDanArray"];
    [userDefaults synchronize];
}


@end
