//
//  XLBaseVC.h
//  XLTaoMall
//
//  Created by Hawky on 2018/4/10.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLNetworkManager.h"
#import "XLNaviView.h"
@interface XLBaseVC : UIViewController
//返回
-(void)QurtButClick:(UIButton *)sender;
//判断是否在主窗口
- (BOOL)isShowingOnKeyWindow;

/*****  上拉刷新 *****/
-(void)refreshData;
/*****  下拉加载 *****/
-(void)loadMoredata;
@end

