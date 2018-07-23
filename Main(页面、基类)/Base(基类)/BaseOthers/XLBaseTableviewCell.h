//
//  XLBaseTableviewCell.h
//  XLTaoMall
//
//  Created by Hawky on 2018/5/31.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLBaseTableviewCell : UITableViewCell

/*****  布局子视图 *****/
-(void)setUpSubview;

/*****  加载数据 *****/
-(void)loadData:(id)dataModel;
@end
