//
//  XLMineTableHeaderView.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/29.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLMineTableHeaderView.h"
#import "UIButton+UIButton_XLCategory.m"
#import "UIButton+badge.h"
@interface XLMineTableHeaderView ()

/*****  顶部背景图 *****/
@property (nonatomic,strong)UIImageView *TopBackIV;
/*****  头像框 *****/
@property (nonatomic,strong)UIButton *PortraitBut;
/*****  登录按钮 *****/
@property (nonatomic,strong)UIButton *logBut;
/*****  设置按钮 *****/
@property (nonatomic,strong)UIButton *settingBut;
/*****  用户名 *****/
@property (nonatomic,strong)UILabel *userNameLab;
/*****  账户余额 *****/
@property (nonatomic,strong)UILabel *accountBanlanceLab;
/*****  冻结余额 *****/
@property (nonatomic,strong)UILabel *frozenBanlanceLab;

/*****  我的订单 *****/
@property (nonatomic,strong)UILabel *MyOrderTitleLab;
/*****  查看全部订单 *****/
@property (nonatomic,strong)UIButton *checkAllOrderBut;
/*****  我的订单下边的分割线 *****/
@property (nonatomic,strong)UIView *orderLineView;
/*****  待付款订单 *****/
@property (nonatomic,strong)UIButton *orderWaitPaymentBut;
/*****  待发货订单 *****/
@property (nonatomic,strong)UIButton *orderWaitDeliveryBut;
/*****  待收货订单 *****/
@property (nonatomic,strong)UIButton *orderWaitReceiveBut;
/*****  交易完成订单 *****/
@property (nonatomic,strong)UIButton *orderCompleteBut;
/*****  退款订单 *****/
@property (nonatomic,strong)UIButton *orderRefundBut;


/*****  订单服务分割线 *****/
@property (nonatomic,strong)UIView *orderServicelineView;


/*****  我的服务 *****/
@property (nonatomic,strong)UILabel *MyServiceTitleLab;
/*****  我的服务分割线 *****/
@property (nonatomic,strong)UIView *serviceLineView;
/*****  推广返利 *****/
@property (nonatomic,strong)UIButton *serviceRecordBut;
/*****  账户余额 *****/
@property (nonatomic,strong)UIButton *serviceAccountBanlanceBut;
/*****  领券中心 *****/
@property (nonatomic,strong)UIButton *serviceGetTicketsBut;
/*****  可领券 *****/
@property (nonatomic,strong)UILabel *canGetTicketsLab;
/*****  优惠券 *****/
@property (nonatomic,strong)UIButton *serviceDiscountTicketsBut;

@end

@implementation XLMineTableHeaderView

///*****  初始化 *****/
//- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
//        [self setUpSubview];
//    }
//    return self;
//}

/*****  设置主视图 *****/
-(void)setUpSubview
{
    [super setUpSubview];
    self.userInteractionEnabled=YES;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width, 0)];
    view.backgroundColor=[UIColor whiteColor];
    [self setBackgroundView:view];
    self.TopBackIV=[[UIImageView alloc] init];
    [self addSubview:self.TopBackIV];
    /*****  头像 *****/
    self.PortraitBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.PortraitBut addTarget:self action:@selector(PortraitButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.PortraitBut];

    self.logBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.logBut addTarget:self action:@selector(loginButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.logBut];

    self.settingBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingBut addTarget:self action:@selector(settingButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.settingBut];

    self.userNameLab=[[UILabel alloc] init];
    self.userNameLab.font=KNSFONT(14);
    self.userNameLab.textColor=TEXTWHITECOLOR;
    self.userNameLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.userNameLab];

    self.accountBanlanceLab=[[UILabel alloc] init];
    self.accountBanlanceLab.font=KNSFONT(14);
    self.accountBanlanceLab.textColor=TEXTWHITECOLOR;
    self.accountBanlanceLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.accountBanlanceLab];

    self.frozenBanlanceLab=[[UILabel alloc] init];
    self.frozenBanlanceLab.font=KNSFONT(14);
    self.frozenBanlanceLab.textColor=TEXTWHITECOLOR;
    self.frozenBanlanceLab.textAlignment=NSTextAlignmentLeft;
    [self addSubview:self.frozenBanlanceLab];


    /*****  我的订单 *****/
    self.MyOrderTitleLab=[[UILabel alloc] init];
    self.MyOrderTitleLab.font=KNSFONT(20);
    self.MyOrderTitleLab.textColor=TEXTFIRSTBLACKCOLOR;
    self.MyOrderTitleLab.textAlignment=NSTextAlignmentLeft;
    self.MyOrderTitleLab.text=@"我的订单";
    [self addSubview:self.MyOrderTitleLab];

    self.checkAllOrderBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkAllOrderBut setTitleColor:TEXTGRAYCOLOR forState:UIControlStateNormal];
    [self.checkAllOrderBut setTitle:@"查看全部" forState:UIControlStateNormal];
    [self.checkAllOrderBut setImage:KImage(@"XL_Mine_icon_more") forState:UIControlStateNormal];
    [self.checkAllOrderBut.titleLabel setFont:KNSFONT(13)];
    self.checkAllOrderBut.tag=0;
    [self.checkAllOrderBut addTarget:self action:@selector(checkOrderButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.checkAllOrderBut];

    self.orderLineView=[[UIView alloc] init];
    self.orderLineView.backgroundColor=BACKGRAYCOLOR;
    [self addSubview:self.orderLineView];

    self.orderWaitPaymentBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderWaitPaymentBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.orderWaitPaymentBut setTitle:@"待付款" forState:UIControlStateNormal];
    [self.orderWaitPaymentBut setImage:KImage(@"XL_Mine_payment") forState:UIControlStateNormal];
    self.orderWaitPaymentBut.titleLabel.font=KNSFONT(13);
    self.orderWaitPaymentBut.tag=1;
    [self.orderWaitPaymentBut addTarget:self action:@selector(checkOrderButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.orderWaitPaymentBut];

    self.orderWaitDeliveryBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderWaitDeliveryBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.orderWaitDeliveryBut setTitle:@"待发货" forState:UIControlStateNormal];
    [self.orderWaitDeliveryBut setImage:KImage(@"XL_Mine_Pendingdelivery") forState:UIControlStateNormal];
    self.orderWaitDeliveryBut.titleLabel.font=KNSFONT(13);
    self.orderWaitDeliveryBut.tag=2;
    [self.orderWaitDeliveryBut addTarget:self action:@selector(checkOrderButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.orderWaitDeliveryBut];

    self.orderWaitReceiveBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderWaitReceiveBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.orderWaitReceiveBut setTitle:@"待收货" forState:UIControlStateNormal];
    [self.orderWaitReceiveBut setImage:KImage(@"XL_Mine_Collectgoods") forState:UIControlStateNormal];
    self.orderWaitReceiveBut.titleLabel.font=KNSFONT(13);
    self.orderWaitReceiveBut.tag=3;
    [self.orderWaitReceiveBut addTarget:self action:@selector(checkOrderButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.orderWaitReceiveBut];

    self.orderCompleteBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderCompleteBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.orderCompleteBut setTitle:@"交易完成" forState:UIControlStateNormal];
    [self.orderCompleteBut setImage:KImage(@"XL_Mine_Transactioncompletion") forState:UIControlStateNormal];
    self.orderCompleteBut.titleLabel.font=KNSFONT(13);
    self.orderCompleteBut.tag=4;
    [self.orderCompleteBut addTarget:self action:@selector(checkOrderButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.orderCompleteBut];

    self.orderRefundBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.orderRefundBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.orderRefundBut setTitle:@"退款订单" forState:UIControlStateNormal];
    [self.orderRefundBut setImage:KImage(@"XL_Mine_Refundorder") forState:UIControlStateNormal];
    self.orderRefundBut.titleLabel.font=KNSFONT(13);
    self.orderRefundBut.tag=5;
    [self.orderRefundBut addTarget:self action:@selector(checkOrderButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.orderRefundBut];

    /*****  订单服务分割线 *****/
    self.orderServicelineView=[[UIView alloc] init];
    [self.orderServicelineView setBackgroundColor:BACKGRAYCOLOR];
    [self addSubview:self.orderServicelineView];

    /*****  我的服务 *****/
    self.MyServiceTitleLab=[[UILabel alloc] init];
    self.MyServiceTitleLab.font=KNSFONT(20);
    self.MyServiceTitleLab.textColor=TEXTFIRSTBLACKCOLOR;
    self.MyServiceTitleLab.textAlignment=NSTextAlignmentLeft;
    self.MyServiceTitleLab.text=@"我的服务";
    [self addSubview:self.MyServiceTitleLab];

    self.serviceLineView=[[UIView alloc] init];
    self.serviceLineView.backgroundColor=BACKGRAYCOLOR;
    [self addSubview:self.serviceLineView];

    self.serviceRecordBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceRecordBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.serviceRecordBut setTitle:@"推广返利" forState:UIControlStateNormal];
    [self.serviceRecordBut setImage:KImage(@"XL_Mine_Rebate") forState:UIControlStateNormal];
    self.serviceRecordBut.titleLabel.font=KNSFONT(13);
    self.serviceRecordBut.tag=10;
    [self.serviceRecordBut addTarget:self action:@selector(checkServiceButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.serviceRecordBut];

    self.serviceAccountBanlanceBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceAccountBanlanceBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.serviceAccountBanlanceBut setTitle:@"账户余额" forState:UIControlStateNormal];
    [self.serviceAccountBanlanceBut setImage:KImage(@"XL_Mine_balance") forState:UIControlStateNormal];
    self.serviceAccountBanlanceBut.titleLabel.font=KNSFONT(13);
    self.serviceAccountBanlanceBut.tag=11;
    [self.serviceAccountBanlanceBut addTarget:self action:@selector(checkServiceButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.serviceAccountBanlanceBut];

    self.serviceGetTicketsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceGetTicketsBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.serviceGetTicketsBut setTitle:@"领券中心" forState:UIControlStateNormal];
    [self.serviceGetTicketsBut setImage:KImage(@"XL_Mine_core") forState:UIControlStateNormal];
    self.serviceGetTicketsBut.titleLabel.font=KNSFONT(13);
    self.serviceGetTicketsBut.tag=12;
    [self.serviceGetTicketsBut addTarget:self action:@selector(checkServiceButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.serviceGetTicketsBut];

    self.canGetTicketsLab=[[UILabel alloc] init];
    self.canGetTicketsLab.font=KNSFONT(10);
    self.canGetTicketsLab.textColor=MAINBRIGHTCOLOR;
    self.canGetTicketsLab.textAlignment=NSTextAlignmentCenter;
    self.canGetTicketsLab.text=@"(可领券)";
    [self.serviceGetTicketsBut addSubview:self.canGetTicketsLab];

    self.serviceDiscountTicketsBut=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.serviceDiscountTicketsBut setTitleColor:TEXTFIRSTBLACKCOLOR forState:UIControlStateNormal];
    [self.serviceDiscountTicketsBut setTitle:@"优惠券" forState:UIControlStateNormal];
    [self.serviceDiscountTicketsBut setImage:KImage(@"XL_Mine_Coupon") forState:UIControlStateNormal];
    self.serviceDiscountTicketsBut.titleLabel.font=KNSFONT(13);
    self.serviceDiscountTicketsBut.tag=13;
    [self.serviceDiscountTicketsBut addTarget:self action:@selector(checkServiceButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.serviceDiscountTicketsBut];


}

/*****  加载数据 *****/
-(void)loadData:(XLUserModel *)model
{
    [self.TopBackIV setImage:KImage(@"XL_Mine_TopHeaderBGX")];
    [self.PortraitBut sd_setImageWithURL:KNSURL(model.portrait) forState:UIControlStateNormal placeholderImage:KImage(@"XL_Mine_portrait")];
    
    [self.logBut setTitle:@"登录/注册" forState:UIControlStateNormal];
    [self.settingBut setImage:KImage(@"XL_Mine_setting") forState:UIControlStateNormal];

    [self.userNameLab setText:model.username];
    [self.accountBanlanceLab setText:[NSString stringWithFormat:@"账户余额：%@",model.total_money]];
    [self.frozenBanlanceLab setText:[NSString stringWithFormat:@"冻结金额：%@",model.frozen_money]];

    [self.orderWaitPaymentBut setBadgeValue:model.wait_payment_sum];
    [self.orderWaitDeliveryBut setBadgeValue:model.wait_delivery_sum];
    [self.orderWaitReceiveBut setBadgeValue:model.wait_receive_goods_sum];

    BOOL login=model.isLogIn;
    self.logBut.hidden=login;
    self.settingBut.hidden=!login;
    self.userNameLab.hidden=!login;
    self.accountBanlanceLab.hidden=!login;
    self.frozenBanlanceLab.hidden=!login;

    BOOL canGetTickets=[model.ticket isEqualToString:@"0"];
    self.canGetTicketsLab.hidden=!canGetTickets;

}

/*****  布局位置 *****/
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.TopBackIV setFrame:CGRectMake(0, 0, KScreen_Width, 180+KSafeTopHeight)];
    self.PortraitBut.layer.frame=CGRectMake(CWidth(15), KSafeAreaTopNaviHeight, 70, 70);
    self.PortraitBut.layer.cornerRadius=70/2.0;
    self.PortraitBut.layer.masksToBounds=YES;
    [self.logBut setFrame:CGRectMake(CWidth(25)+70, KSafeAreaTopNaviHeight, 120, 70)];
    [self.settingBut setFrame:CGRectMake(KScreen_Width-CWidth(15)-22, 50, 22, 22)];
    [self.userNameLab setFrame:CGRectMake(CWidth(25)+70, KSafeAreaTopNaviHeight, KScreen_Width-CWidth(40)-70, 14)];
    [self.accountBanlanceLab setFrame:CGRectMake(CWidth(25)+70, KSafeAreaTopNaviHeight+28, KScreen_Width-CWidth(40)-70, 14)];
    [self.frozenBanlanceLab setFrame:CGRectMake(CWidth(25)+70, KSafeAreaTopNaviHeight+56, KScreen_Width-CWidth(40)-70, 14)];

    CGFloat height=180+KSafeTopHeight;

    CGFloat height1=50;
    [self.MyOrderTitleLab setFrame:CGRectMake(CWidth(15), height, 120, height1)];
    [self.checkAllOrderBut setFrame:CGRectMake(KScreen_Width-CWidth(15)-70, height, 70, height1)];
    [self.checkAllOrderBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageRight imageTitleSpace:5];
    height+=height1;

    [self.orderLineView setFrame:CGRectMake(0, height, KScreen_Width, 5)];
    height+=5;

    CGFloat width=KScreen_Width/5.0;
    CGFloat butHeight=80;
    CGFloat ImageAndTitleMarin=10;
    [self.orderWaitPaymentBut setFrame:CGRectMake(0, height, width, butHeight)];
    [self.orderWaitPaymentBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];
    [self.orderWaitDeliveryBut setFrame:CGRectMake(width, height, width, butHeight)];
    [self.orderWaitDeliveryBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];
    [self.orderWaitReceiveBut setFrame:CGRectMake(width*2, height, width, butHeight)];
    [self.orderWaitReceiveBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];
    [self.orderCompleteBut setFrame:CGRectMake(width*3, height, width, butHeight)];
    [self.orderCompleteBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];
    [self.orderRefundBut setFrame:CGRectMake(width*4, height, width, butHeight)];
    [self.orderRefundBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];
    height+=butHeight;

    [self.orderServicelineView setFrame:CGRectMake(0, height, KScreen_Width, 5)];
    height+=5;

    [self.MyServiceTitleLab setFrame:CGRectMake(CWidth(15), height, KScreen_Width, 49)];
    height+=49;
    [self.serviceLineView setFrame:CGRectMake(0, height, KScreen_Width, 1)];
    height+=1;
    width=KScreen_Width/4.0;
    [self.serviceRecordBut setFrame:CGRectMake(0, height, width, butHeight)];
    [self.serviceRecordBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];

    [self.serviceAccountBanlanceBut setFrame:CGRectMake(width, height, width, butHeight)];
    [self.serviceAccountBanlanceBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];

    [self.serviceGetTicketsBut setFrame:CGRectMake(width*2, height, width, butHeight)];
    [self.serviceGetTicketsBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];

    [self.canGetTicketsLab setFrame:CGRectMake(0, butHeight-15, width, 10)];

    [self.serviceDiscountTicketsBut setFrame:CGRectMake(width*3, height, width, butHeight)];
    [self.serviceDiscountTicketsBut layoutButtonWithEdgeInsetsStyle:XLButtonEdgeInsetsStyleImageTop imageTitleSpace:ImageAndTitleMarin];

}

#pragma mark - events
/*****  登录 *****/
-(void)loginButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(loginButClick:)]) {
        [_delegate loginButClick:nil];
    }
}
/*****  设置 *****/
-(void)settingButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(settingButClick:)]) {
        [_delegate settingButClick:nil];
    }
}
/*****  查看个人信息 *****/
-(void)PortraitButClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(PortraitButClick:)]) {
        [_delegate PortraitButClick:nil];
    }
}
/*****  查看订单详情 *****/
-(void)checkOrderButClick:(UIButton *)sender
{
    NSInteger index=sender.tag;
    if (_delegate&&[_delegate respondsToSelector:@selector(checkOrderListWithIndex:)]) {
        [_delegate checkOrderListWithIndex:index];
    }
}

/*****  我的服务 *****/
-(void)checkServiceButClick:(UIButton *)sender
{
    NSInteger index=sender.tag-10;
    if (_delegate&&[_delegate respondsToSelector:@selector(checkServiceWithIndex:)]) {
        [_delegate checkServiceWithIndex:index];
    }
    
}

@end
