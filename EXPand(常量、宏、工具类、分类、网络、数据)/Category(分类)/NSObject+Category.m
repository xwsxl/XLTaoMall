//
//  NSObject+Category.m
//  aTaohMall
//
//  Created by DingDing on 2017/8/17.
//  Copyright © 2017年 ysy. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

/**
 *  自动生成属性列表
 *
 *  @param dict JSON字典/模型字典
 */
+(void)printPropertyWithDict:(NSDictionary *)dict{
    NSMutableString *allPropertyCode = [[NSMutableString alloc]init];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    
      //  XLLog(@"%@",[obj class]);
/*
 NSTaggedPointerString
__NSCFNumber
__NSCFString
__NSCFConstantString
 NSNull
 */
        NSString *oneProperty = [[NSString alloc]init];
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")]||[obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")]||[obj isKindOfClass:NSClassFromString(@"__NSCFConstantString")]||[obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]||[obj isKindOfClass:NSClassFromString(@"NSNull")]) {
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        }
        else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]||[obj isKindOfClass:NSClassFromString(@"__NSArrayM")]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            oneProperty = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;)",key];
        }
        [allPropertyCode appendFormat:@"\n%@",oneProperty];
    }];
    XLLog(@"---%@",allPropertyCode);
}

@end
