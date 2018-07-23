//
//  XLMineTableHeaderView.h
//  XLTaoMall
//
//  Created by Hawky on 2018/5/29.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLBaseTableViewHeaderFooterView.h"
#import "XLUserModel.h"
@protocol XLMineTableHeaderViewDelegate<NSObject>

@required
/*****  登录 *****/
-(void)loginButClick:(UIButton *)sender;
/*****  设置 *****/
-(void)settingButClick:(UIButton *)sender;
/*****  查看个人信息 *****/
-(void)PortraitButClick:(UIButton *)sender;
/*****  查看订单 *****/
-(void)checkOrderListWithIndex:(NSInteger )index;
/*****  查看服务 *****/
-(void)checkServiceWithIndex:(NSInteger )index;

@end


@interface XLMineTableHeaderView : XLBaseTableViewHeaderFooterView

@property (nonatomic,weak)id<XLMineTableHeaderViewDelegate> delegate;
/*****  加载数据 *****/
-(void)loadData:(XLUserModel *)model;

@end
