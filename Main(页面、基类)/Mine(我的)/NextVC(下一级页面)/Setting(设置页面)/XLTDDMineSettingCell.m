//
//  XLTDDMineSettingCell.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/31.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLTDDMineSettingCell.h"
@interface XLTDDMineSettingCell()
@property (nonatomic,strong)UILabel *descLab;
@property (nonatomic,strong)UIImageView *moreIV;
@end
@implementation XLTDDMineSettingCell

-(void)setUpSubview
{
    [super setUpSubview];
    self.textLabel.textColor=TEXTSECONDBLACKCOLOR;
    self.textLabel.font=KNSFONT(14);

    self.moreIV=[[UIImageView alloc] init];
    [self addSubview:self.moreIV];
}

-(void)loadData:(id)dataModel
{
    NSString *str=(NSString *)dataModel;
    [self.textLabel setText:str];
    [self.moreIV setImage:KImage(@"XL_Mine_icon_more")];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
   // self.descLab.frame=CGRectMake(CWidth(15), 0, 200, 44);
    self.moreIV.frame=CGRectMake(KScreen_Width-15-6, (40-11)/2.0, 6, 11);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
