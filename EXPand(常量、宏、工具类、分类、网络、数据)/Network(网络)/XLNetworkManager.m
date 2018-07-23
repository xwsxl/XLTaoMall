//
//  XLNetworkManager.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/28.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLNetworkManager.h"

#import "SecretCodeTool.h"
#import "DESUtil.h"
#import "MJExtension.h"

#import "MBProgressHUD.h"

@implementation XLNetworkManager

/**
 封装了POST请求

 @param urlString 接口地址
 @param params 参数
 @param success 成功回调
 @param faild 失败的回调
 */
+(void)POST:(NSString *)urlString WithParams:(id)params ForSuccess:(SuccessBlock)success AndFaild:(FaildBlock)faild
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"image/jpeg",@"text/html",@"image/png", nil];
    manager.requestSerializer.timeoutInterval=30;

    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,urlString];

    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];

    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        XLLog(@"url=%@\nparams=%@\nuploadProgress=%@",url,[params mj_JSONString],uploadProgress.localizedDescription);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str2=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *codeKey = [SecretCodeTool getDesCodeKey:str2];
        NSString *content = [SecretCodeTool getReallyDesCodeString:str2];
        NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        XLLog(@"url=%@\nparams=%@\nresponseObject=%@",urlString,[params mj_JSONString],[result mj_JSONString]);
        if ([result isKindOfClass:NSClassFromString(@"__NSCFArray")]||[result isKindOfClass:NSClassFromString(@"__NSArrayM")]) {
            NSDictionary *response=[result lastObject];
            success(response);
        }else
        {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XLLog(@"url=%@\nparams=%@\nerror=%@",urlString,[params mj_JSONString],error.localizedDescription);
        faild(error);
    }];
    
}
/**
 封装了POST请求

 @param urlString 接口地址
 @param params 参数
 @param view hud添加视图
 @param success 成功回调
 @param faild 失败的回调
 */
+(void)POST:(NSString *)urlString WithParams:(id)params AndView:(UIView *)view ForSuccess:(SuccessBlock)success AndFaild:(FaildBlock)faild
{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    [XLNetworkManager POST:urlString WithParams:params ForSuccess:^(NSDictionary *response) {
        [hud hideAnimated:YES];
        success(response);
    } AndFaild:^(NSError *error) {
        [hud hideAnimated:YES];
        faild(error);
    }];
}


/**
 封装数据流请求

 @param urlString 接口地址
 @param params 参数
 @param view 加载视图
 @param block 数据流
 @param success 成功回调
 @param faild 失败回调
 */
+(void)POST:(NSString *)urlString WithParams:(id)params AndView:(UIView *)view constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block ForSuccess:(SuccessBlock)success AndFaild:(FaildBlock)faild
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"image/jpeg",@"text/html",@"image/png", nil];
    manager.requestSerializer.timeoutInterval=30;

    NSString *url=[NSString stringWithFormat:@"%@%@",URL_Str,urlString];

    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    [manager POST:url parameters:params constructingBodyWithBlock:block progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];
        NSString *str2=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *codeKey = [SecretCodeTool getDesCodeKey:str2];
        NSString *content = [SecretCodeTool getReallyDesCodeString:str2];
        NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        XLLog(@"url=%@\nparams=%@\nresponseObject=%@",url,[params mj_JSONString],[result mj_JSONString]);
        if ([result isKindOfClass:NSClassFromString(@"__NSCFArray")]||[result isKindOfClass:NSClassFromString(@"__NSArrayM")]) {
            NSDictionary *response=[result lastObject];
            success(response);
        }else
        {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        XLLog(@"url=%@\nparams=%@\nerror=%@",urlString,[params mj_JSONString],error.localizedDescription);
        faild(error);
    }];
}

/**
 封装了POST请求

 @param urlString 接口地址
 @param params 参数
 @param success 成功回调
 @param faild 失败的回调
 */
+(void)TEXTPOST:(NSString *)urlString WithParams:(id)params ForSuccess:(SuccessBlock)success AndFaild:(FaildBlock)faild
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"image/jpeg",@"text/html",@"image/png", nil];
    manager.requestSerializer.timeoutInterval=30;

    NSString *url=[NSString stringWithFormat:@"%@%@",@"http://192.168.1.24:8084/",urlString];

    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str2=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *codeKey = [SecretCodeTool getDesCodeKey:str2];
        NSString *content = [SecretCodeTool getReallyDesCodeString:str2];
        NSString *xmlStr = [DesUtil decryptUseDES:content key:codeKey];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        xmlStr = [xmlStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        NSData *data = [[NSData alloc] initWithData:[xmlStr dataUsingEncoding:NSUTF8StringEncoding]];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        XLLog(@"url=%@\nparams=%@\nresponseObject=%@",url,[params mj_JSONString],[result mj_JSONString]);
        if ([result isKindOfClass:NSClassFromString(@"__NSCFArray")]||[result isKindOfClass:NSClassFromString(@"__NSArrayM")]) {
            NSDictionary *response=[result lastObject];
            success(response);
        }else
        {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        XLLog(@"url=%@\nparams=%@\nerror=%@",urlString,[params mj_JSONString],error.localizedDescription);
        faild(error);
    }];

}
@end
