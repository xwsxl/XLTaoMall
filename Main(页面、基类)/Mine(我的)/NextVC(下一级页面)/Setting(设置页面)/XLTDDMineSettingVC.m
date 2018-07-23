//
//  XLTDDMineSettingVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/31.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLTDDMineSettingVC.h"
#import "XLTDDMineSettingCell.h"

#import "XLTDDMineAboutUsVC.h"
#import "XLTDDMineSettingFeedBackVC.h"


@interface XLTDDMineSettingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSArray *dataSource;
@end

@implementation XLTDDMineSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI
{
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"设置" ImageName:nil];
    typeof(self) weakSelf=self;
    navi.qurtBlock = ^{
        [weakSelf QurtButClick:nil];
    };
    [self.view addSubview:navi];

    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, KScreen_Width, KScreen_Height-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight) style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    //_tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.showsVerticalScrollIndicator=NO;
    _tableview.showsHorizontalScrollIndicator=NO;
    _tableview.estimatedSectionHeaderHeight=10;
    _tableview.estimatedSectionFooterHeight=0.01;
    _tableview.estimatedRowHeight=44;
     [_tableview registerClass:[XLTDDMineSettingCell class] forCellReuseIdentifier:@"XLTDDMineSettingCell"];
    /*MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
     _tableview.mj_header=header;
     MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoredata)];
     _tableview.mj_footer=footer;*/
    [self.view addSubview:_tableview];

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(10, KScreen_Height-KSafeAreaBottomHeight-15-44, KScreen_Width-20, 44);
    layer.backgroundColor = RGBA(0, 0, 0,0.18).CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.8;
    layer.cornerRadius = 9;
    [self.view.layer addSublayer:layer];

    UIButton * quitLogBut=[UIButton buttonWithType:UIButtonTypeCustom];
    quitLogBut.layer.frame=CGRectMake(10, KScreen_Height-KSafeAreaBottomHeight-15-44, KScreen_Width-20, 44);
    quitLogBut.layer.cornerRadius=9;
    quitLogBut.layer.backgroundColor=MAINBRIGHTCOLOR.CGColor;
    [quitLogBut setTitle:@"退出当前账户" forState:UIControlStateNormal];
    [quitLogBut addTarget:self action:@selector(quitLogButClick:) forControlEvents:UIControlEventTouchUpInside];
    [quitLogBut.titleLabel setFont:KNSFONT(18)];
    [self.view addSubview:quitLogBut];
}

#pragma mark - events
/*****  退出登录 *****/
-(void)quitLogButClick:(UIButton *)sender
{
    [UIAlertTools showAlertWithTitle:nil message:@"确认要退出登录吗？" cancelTitle:@"取消" alertStyle:UIAlertControllerStyleAlert titleArray:@[@"确认"] viewController:self confirm:^(NSInteger buttonTag) {
        [UserDefaultsManager removeUserInfo];
        [KNotificationCenter postNotificationName:XLLoginOutSucessNoti object:nil];
        [self QurtButClick:nil];
    }];
}

/*****  账户信息 *****/
-(void)goToAccountInfoVC
{
    NSString *phone=@"18477175344";
    [XLNetworkManager TEXTPOST:@"checkUserName.shtml" WithParams:@{@"username":phone,@"game_id":@"1"} ForSuccess:^(NSDictionary *response) {
        if ([response[@"status"] isEqualToString:@"10000"]) {
            [XLNetworkManager TEXTPOST:@"sendMessage.shtml" WithParams:@{@"phone":phone} ForSuccess:^(NSDictionary *response) {
                if ([response[@"status"] isEqualToString:@"10000"]) {
                    [XLNetworkManager TEXTPOST:@"gotoRegister.shtml" WithParams:@{@"username":phone,@"password":@"a12345678",@"code":response[@"random"],@"game_id":@"1"} ForSuccess:^(NSDictionary *response) {
                        if ([response[@"status"] isEqualToString:@"10000"]) {
                            [XLNetworkManager TEXTPOST:@"gotoLogin.shtml" WithParams:@{@"username":phone,@"password":@"a12345678",@"game_id":@"1"} ForSuccess:^(NSDictionary *response) {

                            } AndFaild:^(NSError *error) {

                            }];

                        }
                    } AndFaild:^(NSError *error) {

                    }];
                }
            } AndFaild:^(NSError *error) {

            }];
        }
    } AndFaild:^(NSError *error) {

    }];



}
/*****  收货地址 *****/
-(void)goToAccountReceiveAddressVC
{

}
/*****  修改密码 *****/
-(void)goToChangePasswordVC
{
    [XLNetworkManager TEXTPOST:@"checkUserName.shtml" WithParams:@{@"username":@"18249989599"} ForSuccess:^(NSDictionary *response) {
        if ([response[@"status"] isEqualToString:@"10001"]) {
            [XLNetworkManager TEXTPOST:@"sendMessageForgetPwd.shtml" WithParams:@{@"phone":@"18249989599"} ForSuccess:^(NSDictionary *response) {
                if ([response[@"status"] isEqualToString:@"10000"]) {
                    [XLNetworkManager TEXTPOST:@"updateUserPassword.shtml" WithParams:@{@"username":@"18249989599",@"password":@"12345678a",@"code":response[@"random"]} ForSuccess:^(NSDictionary *response) {
                        if ([response[@"status"] isEqualToString:@"10000"]) {
                            [XLNetworkManager TEXTPOST:@"gotoLogin.shtml" WithParams:@{@"username":@"18249989599",@"password":@"a12345678"} ForSuccess:^(NSDictionary *response) {

                            } AndFaild:^(NSError *error) {

                            }];
                            [XLNetworkManager TEXTPOST:@"gotoLogin.shtml" WithParams:@{@"username":@"18249989599",@"password":@"12345678a"} ForSuccess:^(NSDictionary *response) {

                            } AndFaild:^(NSError *error) {

                            }];
                        }
                    } AndFaild:^(NSError *error) {

                    }];
                }
            } AndFaild:^(NSError *error) {

            }];
        }
    } AndFaild:^(NSError *error) {

    }];

}
/*****  关于我们 *****/
-(void)goToAboutUSVC
{
    XLTDDMineAboutUsVC *VC=[[XLTDDMineAboutUsVC alloc] init];
    VC.hidesBottomBarWhenPushed=YES;
    VC.jz_navigationBarHidden=YES;
    [self.navigationController pushViewController:VC animated:YES];
}
/*****  反馈 *****/
-(void)goToFeedBackVC
{
    XLTDDMineSettingFeedBackVC *VC=[[XLTDDMineSettingFeedBackVC alloc] init];
    VC.hidesBottomBarWhenPushed=YES;
    VC.jz_navigationBarHidden=YES;
    [self.navigationController pushViewController:VC animated:YES];
}
/*****  清除缓存 *****/
-(void)clearCache
{
    XLLog(@"123");
    [UIAlertTools showAlertWithTitle:nil message:@"确定要清除所有缓存？" cancelTitle:@"取消" alertStyle:UIAlertControllerStyleAlert titleArray:@[@"确认"] viewController:self confirm:^(NSInteger buttonTag) {

        [XLMBProgressHudTools showText:@"正在清除"];
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]){
            [storage deleteCookie:cookie];
        }
        //清除UIWebView的缓存
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        NSURLCache * cache = [NSURLCache sharedURLCache];
        [cache removeAllCachedResponses];
        [cache setDiskCapacity:0];
        [cache setMemoryCapacity:0];

    }];
    
}



#pragma mark - TableViewDelegate
/*****  分区数 *****/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
/*****  行数 *****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr=self.dataSource[section];
    return arr.count;
}
/*****  cell *****/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr=self.dataSource[indexPath.section];
    XLTDDMineSettingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"XLTDDMineSettingCell"];
    [cell loadData:arr[indexPath.row]];
    return cell;
}

/*****  点击了cell *****/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr=self.dataSource[indexPath.section];
    XLLog(@"点击了.....%@",arr[indexPath.row]);
    if(indexPath.section==0)
    {
        if (indexPath.row==0) {
            [self goToAccountInfoVC];
        }else if (indexPath.row==1)
        {
            [self goToAccountReceiveAddressVC];
        }else
        {
            [self goToChangePasswordVC];
        }
    }else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            [self goToAboutUSVC];
        }else if (indexPath.row==1)
        {
            [self goToFeedBackVC];
        }
    }else
    {
        [self clearCache];
    }

}
/*****  行高 *****/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
/*****  头视图 *****/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
/*****  脚视图图 *****/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

#pragma mark - lazyLoading
/*****  数据源 *****/
-(NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=@[@[@"账户信息",@"收货地址",@"修改密码"],@[@"关于我们",@"反馈"],@[@"清除缓存"]];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
