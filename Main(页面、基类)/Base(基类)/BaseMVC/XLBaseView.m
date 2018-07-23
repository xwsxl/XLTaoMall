//
//  XLBaseView.m
//  XLTaoMall
//
//  Created by Hawky on 2018/4/10.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLBaseView.h"

@implementation XLBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
@end
