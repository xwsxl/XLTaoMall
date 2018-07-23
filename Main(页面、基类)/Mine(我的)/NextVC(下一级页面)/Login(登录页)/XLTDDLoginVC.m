//
//  XLTDDLoginVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/29.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLTDDLoginVC.h"
#import "XLUserModel.h"
@interface XLTDDLoginVC ()

@end

@implementation XLTDDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - UI
/*****  <#desc#> *****/
-(void)setUI
{
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"登录" ImageName:nil];
    typeof(self) weakself=self;
    navi.qurtBlock = ^{
        [weakself QurtButClick:nil];
    };
    [self.view addSubview:navi];

    /*****  用户名 *****/
    UIView *AccountView=[[UIView alloc] initWithFrame:CGRectMake(15, 94+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 44)];
    UIImageView *AccountBackIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AccountView.frame.size.width, 44)];
    AccountBackIV.image=[UIImage imageNamed:@"XL_Mine_login_边框"];
    [AccountView addSubview:AccountBackIV];

    UIImageView *accountIV =[[UIImageView alloc] initWithFrame:CGRectMake(20, 6, 33, 33)];
    accountIV.image=[UIImage imageNamed:@"XL_Mine_login_用户名"];
    [AccountView addSubview:accountIV];

    UIImageView *lineIV=[[UIImageView alloc] initWithFrame:CGRectMake(73, 7, 1, 30)];
    [lineIV setBackgroundColor:BACKGRAYCOLOR];
    [AccountView addSubview:lineIV];

    UITextField  * accountNameTF=[[UITextField alloc] initWithFrame:CGRectMake(94, 7, AccountView.frame.size.width-105, 30)];
    accountNameTF.tag=100;
    accountNameTF.placeholder=@"用户名";
    accountNameTF.font=[UIFont fontWithName:@"PingFangSC-Medium" size:14];
    accountNameTF.textAlignment=NSTextAlignmentLeft;
    accountNameTF.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    accountNameTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    accountNameTF.borderStyle=UITextBorderStyleNone;
    [accountNameTF setText:[UserDefaultsManager getAccount]];
    [accountNameTF addTarget:self action:@selector(AccountNameOrPasswordTFDidChange:) forControlEvents:UIControlEventEditingChanged];
    [AccountView addSubview:accountNameTF];
    [self.view addSubview:AccountView];

    /*****  密码 *****/
    UIView *PasswordView=[[UIView alloc] initWithFrame:CGRectMake(15, 168+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-30, 44)];
    UIImageView *PasswordBackIV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AccountView.frame.size.width, 44)];
    PasswordBackIV.image=[UIImage imageNamed:@"XL_Mine_login_边框"];
    [PasswordView addSubview:PasswordBackIV];

    UIImageView *passwordIV =[[UIImageView alloc] initWithFrame:CGRectMake(20, 6, 33, 33)];
    passwordIV.image=[UIImage imageNamed:@"XL_Mine_login_密码"];
    [PasswordView addSubview:passwordIV];

    UIImageView *passwordlineIV=[[UIImageView alloc] initWithFrame:CGRectMake(73, 7, 1, 30)];
    [passwordlineIV setBackgroundColor:BACKGRAYCOLOR];
    [PasswordView addSubview:passwordlineIV];

    UITextField  * passwordTF=[[UITextField alloc] initWithFrame:CGRectMake(94, 7, AccountView.frame.size.width-128, 30)];
    passwordTF.placeholder=@"密码";
    passwordTF.font=[UIFont fontWithName:@"PingFangSC-Medium" size:14];
    passwordTF.textAlignment=NSTextAlignmentLeft;
    passwordTF.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    passwordTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    passwordTF.borderStyle=UITextBorderStyleNone;
    passwordTF.keyboardType=UIKeyboardTypeASCIICapable;
    [passwordTF addTarget:self action:@selector(AccountNameOrPasswordTFDidChange:) forControlEvents:UIControlEventEditingChanged];
    passwordTF.tag=200;
    passwordTF.secureTextEntry=YES;
    [PasswordView addSubview:passwordTF];

    UIButton *secureTextEntryBut=[UIButton buttonWithType:UIButtonTypeCustom];
    secureTextEntryBut.frame=CGRectMake(PasswordView.frame.size.width-45, 0, 45, 44);
    [secureTextEntryBut setImage:KImage(@"XL_Mine_login_不可视") forState:UIControlStateNormal];
    [secureTextEntryBut addTarget:self action:@selector(secureTextEntryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [PasswordView addSubview:secureTextEntryBut];
    [self.view addSubview:PasswordView];


    UIView *loginView=[[UIView alloc] initWithFrame:CGRectMake(0, 256+KSafeTopHeight, KScreen_Width, 94)];
    loginView.tag=300;
    UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.layer.frame=CGRectMake(15,0, [UIScreen mainScreen].bounds.size.width-30, 44);
    loginButton.layer.cornerRadius=3;
    loginButton.layer.masksToBounds=YES;
    [loginButton setBackgroundColor:BACKGRAYCOLOR];
    [loginButton setTitle:@"登录" forState:0];
    [loginButton setTintColor:[UIColor whiteColor]];
    loginButton.tag=310;
    loginButton.enabled=NO;
    loginButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:20];
    [loginButton addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loginButton];


    UIButton *zhuCeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    zhuCeButton.frame=CGRectMake(15, 64, 104, 15);
    [zhuCeButton setTitle:@"手机快速注册" forState:0];
    [zhuCeButton setTitleColor:MAINBRIGHTCOLOR forState:0];
    zhuCeButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    zhuCeButton.titleLabel.textAlignment=NSTextAlignmentLeft;
    [zhuCeButton addTarget:self action:@selector(zhuCeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:zhuCeButton];


    UIButton *ForgetButton=[UIButton buttonWithType:UIButtonTypeCustom];
    ForgetButton.frame=CGRectMake(KScreen_Width-100, 64, 85, 15);
    [ForgetButton setTitle:@"忘记密码？" forState:0];
    ForgetButton.titleLabel.textAlignment=NSTextAlignmentRight;
    [ForgetButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:0];
    ForgetButton.titleLabel.font=[UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [ForgetButton addTarget:self action:@selector(ForgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:ForgetButton];

    [self.view addSubview:loginView];
}
#pragma mark - events
/*****  用户名变动 *****/
-(void)AccountNameOrPasswordTFDidChange:(UITextField *)TF
{
    XLLog(@"TF.text=%@",TF.text);
    UITextField *accountTF=[self.view viewWithTag:100];
    UITextField *passwordTF=[self.view viewWithTag:200];
    UIButton *loginBut=[self.view viewWithTag:310];
    if (accountTF.text.length>0&&passwordTF.text.length>0) {
        loginBut.layer.backgroundColor=MAINBRIGHTCOLOR.CGColor;
        loginBut.enabled=YES;
    }else
    {
        loginBut.layer.backgroundColor=BACKGRAYCOLOR.CGColor;
        loginBut.enabled=NO;
    }

}
/*****  密码可见 *****/
-(void)secureTextEntryBtnClick:(UIButton *)sender
{
    sender.selected=!sender.selected;
    NSString *str=(sender.selected?@"XL_Mine_login_可视":@"XL_Mine_login_不可视");
    [sender setImage:KImage(str) forState:UIControlStateNormal];
    UITextField *passwordTF=[self.view viewWithTag:200];
    passwordTF.secureTextEntry=!sender.selected;
}
/*****  登录 *****/
-(void)loginBtnClick:(UIButton *)sender
{
    UITextField *accountTF=[self.view viewWithTag:100];
    UITextField *passwordTF=[self.view viewWithTag:200];
    [self requestForLoginWithAccount:accountTF.text AndPassword:passwordTF.text];
}
/*****  注册 *****/
-(void)zhuCeBtnClick:(UIButton *)sender
{

}
/*****  忘记密码 *****/
-(void)ForgetBtnClick:(UIButton *)sender
{

}
#pragma mark - network
/*****  登录 *****/
-(void)requestForLoginWithAccount:(NSString *)account AndPassword:(NSString *)password
{
    [XLNetworkManager POST:@"login_mob.shtml" WithParams:@{@"phone":account,@"password":password} AndView:self.navigationController.view ForSuccess:^(NSDictionary *response) {
        if ([response[@"status"] isEqualToString:@"10000"]) {
            XLUserModel *model=[XLUserModel mj_objectWithKeyValues:response];
            [UserDefaultsManager setSigen:model.sigen];
            [UserDefaultsManager setAccount:model.username];
            [UserDefaultsManager setPassword:model.password];
            [KNotificationCenter postNotificationName:XLLoginInSuccessNoti object:nil];
            [self QurtButClick:nil];
        }
    } AndFaild:^(NSError *error) {

    }];
}
#pragma mark - network
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
