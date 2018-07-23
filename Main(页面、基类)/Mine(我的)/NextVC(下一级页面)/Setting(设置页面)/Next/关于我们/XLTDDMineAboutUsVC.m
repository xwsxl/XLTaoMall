//
//  XLTDDMineAboutUsVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/5/31.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLTDDMineAboutUsVC.h"

@interface XLTDDMineAboutUsVC ()
{
    UIScrollView *_scroll;
}
@end

@implementation XLTDDMineAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"关于我们" ImageName:nil];
    typeof(self) weakSelf=self;
    navi.qurtBlock = ^{
        [weakSelf QurtButClick:nil];
    };
    [self.view addSubview:navi];
    UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, KScreen_Width, KScreen_Height-KSafeAreaTopNaviHeight)];
   // IV.image=KImage(@"xl_Mine_Setting_AboutUS_bg");
    [self.view addSubview:IV];

    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, KScreen_Width, KScreen_Height-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight)];
    _scroll.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scroll];

    CGFloat height=CWidth(43);
    UIImageView *LogoIV=[[UIImageView alloc] initWithFrame:CGRectMake((KScreen_Width-CWidth(100))/2, height, CWidth(100), CWidth(100))];
    LogoIV.image=KImage(@"AppIcon");
    [_scroll addSubview:LogoIV];

    height+=LogoIV.frame.size.height+CWidth(15);

    UILabel * versionLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CWidth(100)+CWidth(43)+CWidth(15), KScreen_Width, 22)];
    versionLab.font=KNSFONT(16);
    versionLab.textAlignment=NSTextAlignmentCenter;
    versionLab.textColor=RGB(74, 74, 74);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    versionLab.text=[NSString stringWithFormat:@"版本号:%@",app_Version];
    [_scroll addSubview:versionLab];

    height+=versionLab.frame.size.height+CWidth(30);

    NSString *str=@"      推丁丁，值得信赖的购物平台。服饰，家居，办公，美容，母婴，家电，鞋包，汽车……全品类覆盖，用心生活，精明消费，省钱又省心，分享好友，好友购物后有一定比例的返利，购买一定比例的金额，有优惠券赠送，购物可使用抵扣同等金额。每天使用推丁丁，与丁丁一起“惠享生活”；更多选择，更多实惠，更多返利，更好生活就在推丁丁";



    CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:CGSizeMake(KScreen_Width-CWidth(50), MAXFLOAT)];

    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(CWidth(25), CWidth(100)+CWidth(43)+CWidth(15)+22+CWidth(30), KScreen_Width-CWidth(50), size.height)];
    lab.font=KNSFONT(14);
    lab.numberOfLines=0;
    lab.textColor=RGB(102, 102, 102);
    lab.text=str;
    [_scroll addSubview:lab];
    height+=size.height+CWidth(10);

    if (height<_scroll.frame.size.height-22-CWidth(15)) {
        height=_scroll.frame.size.height-22-CWidth(15);
    }

    UILabel *banquanLable=[[UILabel alloc]initWithFrame:CGRectMake(CWidth(25), height, KScreen_Width-CWidth(50), 22)];
    banquanLable.font=KNSFONT(14);
    banquanLable.numberOfLines=0;
    banquanLable.textAlignment=NSTextAlignmentCenter;
    banquanLable.textColor=RGB(51, 51, 51);
    banquanLable.text=@"金木水火土公司版权所有   ©2017-2018";
    [_scroll addSubview:banquanLable];
    height+=22+CWidth(15);
    [_scroll setContentSize:CGSizeMake(KScreen_Width, height)];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
