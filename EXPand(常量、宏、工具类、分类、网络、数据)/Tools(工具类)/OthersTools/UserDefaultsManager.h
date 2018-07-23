//
//  UserDefaultsManager.h
//  YFQChildPro
//
//  Created by ab on 2017/4/13.
//  Copyright © 2017年 YFQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsManager : NSObject

/*****  用户名 *****/
+(NSString *)getAccount;
+(void)setAccount:(NSString *)account;
/*****  密码 *****/
+(NSString *)getPassword;
+(void)setPassword:(NSString *)password;
/*****  sigen值 *****/
+(NSString *)getSigen;
+(void)setSigen:(NSString *)Sigen;
/*****  删除用户信息 *****/
+(void)removeUserInfo;
#pragma mark - 搜索文件存储
//缓存搜索的数组
+(void)SearchText :(NSString *)seaTxt;
//清除缓存数组
+(void)removeGoodsSearchArray;

//缓存订单搜索的数组
+(void)SearchDingDanText :(NSString *)seaTxt;
//清除订单缓存数组
+(void)removeDingDanSearchArray;


@end
