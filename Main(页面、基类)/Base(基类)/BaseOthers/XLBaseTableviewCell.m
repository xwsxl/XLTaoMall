//
//  XLBaseTableviewCell.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/31.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLBaseTableviewCell.h"

@implementation XLBaseTableviewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubview];
    }
    return self;
}
/*****  布局子视图 *****/
-(void)setUpSubview
{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

/*****  加载数据 *****/
-(void)loadData:(id)dataModel
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
