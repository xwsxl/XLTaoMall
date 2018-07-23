//
//  CalculateManager.m
//  IDbears
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 蒋清明. All rights reserved.
//

#import "CalculateManager.h"


@implementation CalculateManager

+ (CGFloat)calculateWidthWithNum:(NSInteger)num {
    // 750x1334
    CGFloat scale = num / 375.0;
    CGFloat width = KScreen_Width * scale;

    return width;
}

+ (CGFloat)calculateHeightWithNum:(NSInteger)num {

    CGFloat scale = num / 667.0;
    CGFloat heigth = KScreen_Height * scale;
    if (KScreen_Height==812.0) {
        heigth=667*scale;
    }
    return heigth;
}

@end
