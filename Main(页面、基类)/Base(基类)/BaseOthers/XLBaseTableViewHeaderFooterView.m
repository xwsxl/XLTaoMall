//
//  XLBaseTableViewHeaderFooterView.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/29.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLBaseTableViewHeaderFooterView.h"

@implementation XLBaseTableViewHeaderFooterView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUpSubview];
    }
    return self;
}
/*****  布局子视图 *****/
-(void)setUpSubview
{
   // XLLog(@"setUpSubview");
}

/*****  加载数据 *****/
-(void)loadData:(id)dataModel
{
    XLLog(@"cellloadData");
}
@end
