//
//  XLNetworkManager.h
//  XLTaoMall
//
//  Created by Hawky on 2018/5/28.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(NSDictionary *response);
typedef void(^FaildBlock)(NSError *error);

@interface XLNetworkManager : NSObject
/**
 封装了POST请求

 @param urlString 接口地址
 @param params 参数
 @param success 成功回调
 @param faild 失败的回调
 */
+(void)POST:(NSString *)urlString WithParams:(id)params ForSuccess:(SuccessBlock)success AndFaild:(FaildBlock)faild;
/**
 封装了POST请求

 @param urlString 接口地址
 @param params 参数
 @param view hud添加视图
 @param success 成功回调
 @param faild 失败的回调
 */
+(void)POST:(NSString *)urlString WithParams:(id)params AndView:(UIView *)view ForSuccess:(SuccessBlock)success AndFaild:(FaildBlock)faild;

/**
 封装数据流请求

 @param urlString 接口地址
 @param params 参数
 @param view 加载视图
 @param block 数据流
 @param success 成功回调
 @param faild 失败回调
 */
+(void)POST:(NSString *)urlString WithParams:(id)params AndView:(UIView *)view constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block ForSuccess:(SuccessBlock)success AndFaild:(FaildBlock)faild;


/**
 封装了POST请求

 @param urlString 接口地址
 @param params 参数
 @param success 成功回调
 @param faild 失败的回调
 */
+(void)TEXTPOST:(NSString *)urlString WithParams:(id)params ForSuccess:(SuccessBlock)success AndFaild:(FaildBlock)faild;
@end
