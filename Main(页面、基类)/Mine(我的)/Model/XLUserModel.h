//
//  XLUserModel.h
//  XLTaoMall
//
//  Created by Hawky on 2018/5/17.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLBaseModel.h"
@interface XLUserModel : XLBaseModel

@property (nonatomic,strong)NSString *username;//用户名
@property (nonatomic,strong)NSString *nickname;//昵称
@property (nonatomic,strong)NSString *sigen;//sigen值
@property (nonatomic,strong)NSString *phone;//手机号
@property (nonatomic,strong)NSString *password;//密码
@property (nonatomic,strong)NSString *portrait;//头像地址
@property (nonatomic,strong)NSString *uid;//
@property (nonatomic,strong)NSString *total_money;//账户余额
@property (nonatomic,strong)NSString *frozen_money;//冻结金额
@property (nonatomic,strong)NSString *ticket;//可领券
@property (nonatomic,strong)NSString *wait_delivery_sum;//代发货
@property (nonatomic,strong)NSString *wait_payment_sum;//待付款
@property (nonatomic,strong)NSString *wait_receive_goods_sum;//待收货

@property (nonatomic,assign)BOOL isLogIn;

@end
