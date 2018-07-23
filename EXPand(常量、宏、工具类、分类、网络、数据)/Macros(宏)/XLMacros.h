//
//  XLMacros.h
//  XLTaoMall
//
//  Created by Hawky on 2018/4/10.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#ifndef XLMacros_h
#define XLMacros_h

#pragma mark - 系统常用

#define KApplication [UIApplication sharedApplication]
#define KUserDefaults [NSUserDefaults standardUserDefaults]
#define KNotificationCenter [NSNotificationCenter defaultCenter]
#define KDeviceID [[UIDevice currentDevice].identifierForVendor UUIDString] //设备唯一标识
#define CurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue] //获取系统版本

#pragma mark - 常用代码
/*****  APP版本号 *****/
#define KVersion_XL [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
/*****  APPBuild版本号 *****/
#define KVersionBuild_XL [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
/*****  URL *****/
#define KNSURL(A) [NSURL URLWithString:A]
/*****  字号 *****/
#define KNSFONT(A) [UIFont systemFontOfSize:A]
/*****  最大的size *****/
#define KMAXSIZE CGSizeMake(MAXFLOAT, MAXFLOAT)
/*****  图片 *****/
#define KImage(A) [UIImage imageNamed:A]

/*****  RGB颜色 *****/
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

/*****  手机屏幕尺寸 *****/
#define KScreen_Size [UIScreen mainScreen].bounds.size
/*****  手机屏幕Bounds *****/
#define KScreen_Bounds [UIScreen mainScreen].bounds
/*****  屏高 *****/
#define KScreen_Height [UIScreen mainScreen].bounds.size.height
/*****  屏宽 *****/
#define KScreen_Width [UIScreen mainScreen].bounds.size.width

/*****  iphone X适配 *****/
#define KSafeTopHeight (KScreen_Height==812.0?24:0)
#define KSafeAreaTopNaviHeight (KScreen_Height == 812.0 ? 88 : 64)
#define KSafeAreaBottomHeight (KScreen_Height == 812.0 ? 34 : 0)

/*****  封装的计算坐标 *****/
#define CWidth(x) [CalculateManager calculateWidthWithNum:x]
#define CWeight(y) [CalculateManager calculateHeightWithNum:y]

/*****  重写NSLog,DeBug模式下打印当前日志和当前行数 *****/
#if DEBUG
#define XLLog(FORMAT, ...) fprintf(stderr,"%s line:%d ------->---> %s\n\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define YLog(FORMAT, ...) nil
#endif



#pragma mark - 约定
/*****  APP主色调 *****/
#define MAINCOLOR RGB(39,36,36)
/*****  APP主要渲染色调 *****/
#define MAINBRIGHTCOLOR RGB(221,172,68)
/*****  App灰色背景 *****/
#define BACKGRAYCOLOR RGB(241, 241, 241)
/*****  一级字体基本黑色 *****/
#define TEXTFIRSTBLACKCOLOR RGB(51, 51, 51)
/*****  二级字体基本黑色 *****/
#define TEXTSECONDBLACKCOLOR RGB(74, 74, 74)
/*****  字体基本灰色 *****/
#define TEXTGRAYCOLOR RGB(153, 153, 153)
/*****  字体白色 *****/
#define TEXTWHITECOLOR [UIColor whiteColor]

#endif /* XLMacros_h */
