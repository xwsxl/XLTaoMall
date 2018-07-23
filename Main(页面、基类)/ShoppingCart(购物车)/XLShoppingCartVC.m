//
//  XLShoppingCartVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/4/12.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLShoppingCartVC.h"

@interface XLShoppingCartVC ()

@end

@implementation XLShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"购物车"];
    //监听重复点击tabbar
    [KNotificationCenter addObserver:self selector:@selector(tabbarRepeatSelectNoti:) name:XLNotiTabBarDidSelectedRepeated object:nil];
    // Do any additional setup after loading the view.
}
#pragma mark - Noti
/*****  监听tabbar重复点击 进行刷新操作 *****/
-(void)tabbarRepeatSelectNoti:(NSNotification *)noti
{
    if ([self isShowingOnKeyWindow]) {
        XLLog(@"购物车被重复点击了");
    }
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
