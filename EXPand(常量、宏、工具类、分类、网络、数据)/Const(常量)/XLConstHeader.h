//
//  XLConstHeader.h
//  XLTaoMall
//
//  Created by Hawky on 2018/4/10.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#ifndef XLConstHeader_h
#define XLConstHeader_h

#pragma mark - 服务器地址
/*
//本地
static NSString *const URL_Str=@"http://192.168.1.24:8085/";
static NSString *const URL_Str1=@"http://120.76.245.90:8089/pay/";
//*/

//*
static NSString *const TextURL_Str=@"http://192.168.1.45:8095/";
//测试
static NSString *const URL_Str=@"http:39.108.151.219:8095/";

//测试支付
static NSString *const URL_Str1=@"http://39.108.151.219:8095/pay/";

/*
//线上
static NSString *const URL_Str=@"http://athmall.com/";
static NSString *const URL_Str1=@"http://athmall.com/pay/";
//*/

#pragma mark - 通知

/*****  重复点击底部tabbar通知 *****/
static NSString *const XLNotiTabBarDidSelectedRepeated = @"tabBarDidSelectedRepeatNotification";
/*****  登录成功通知 *****/
static NSString *const XLLoginInSuccessNoti = @"XLLoginInSuccessNoti";
/*****  退出登录通知 *****/
static NSString *const XLLoginOutSucessNoti = @"XLLoginOutSucessNoti";

#endif /* XLConstHeader_h */
