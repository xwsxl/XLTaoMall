//
//  XLMineVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/4/12.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLMineVC.h"

#import "XLUserModel.h"
#import "XLNormalShopModel.h"



#import "XLMineTableHeaderView.h"

#pragma mark - 二级页面

#import "XLTDDLoginVC.h"
#import "XLTDDMineSettingVC.h"

#define  cellHeight (([UIScreen mainScreen].bounds.size.width-2)/2.0+90)

@interface XLMineVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,XLMineTableHeaderViewDelegate>
{
    UICollectionView *_collectionView;
}
@property (nonatomic,strong)XLUserModel *dataModel;
@property (nonatomic,strong)UITableView *tableview;

@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation XLMineVC

-(instancetype)init
{
    if (self=[super init]) {
        [KNotificationCenter addObserver:self selector:@selector(LogInSuccessNoti:) name:XLLoginInSuccessNoti object:nil];
        [KNotificationCenter addObserver:self selector:@selector(LogOutSuccessNoti:) name:XLLoginOutSucessNoti object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [_tableview.mj_header beginRefreshing];
    //监听重复点击tabbar
    [KNotificationCenter addObserver:self selector:@selector(tabbarRepeatSelectNoti:) name:XLNotiTabBarDidSelectedRepeated object:nil];
}

#pragma mark - network
/*****  刷新数据 *****/
-(void)refreshData
{
    [self getUserData];
    [self getHotShopData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableview.mj_header endRefreshing];
    });
}
/*****  获取个人信息数据 *****/
-(void)getUserData
{
    if ([UserDefaultsManager getSigen].length==0) {

    }else
    {
        [XLNetworkManager POST:@"getAccountInfo_mob.shtml" WithParams:@{@"sigen":[UserDefaultsManager getSigen]} AndView:self.navigationController.view ForSuccess:^(NSDictionary *response) {
            if ([response[@"status"] isEqualToString:@"10000"]) {
                NSArray *arr=response[@"list"];
                XLUserModel *model=[XLUserModel mj_objectWithKeyValues:arr.lastObject];
                [model mj_setKeyValues:response];
                model.isLogIn=YES;
                self.dataModel=model;
                XLLog(@"mdoel=%@",model);
                [self.tableview reloadData];
            }
        } AndFaild:^(NSError *error) {

        }];
    }
}
/*****  获取热门商品数据 *****/
-(void)getHotShopData
{
    [XLNetworkManager POST:@"selectForyouToData_mob.shtml" WithParams:@{@"sigen":[UserDefaultsManager getSigen]} AndView:self.navigationController.view ForSuccess:^(NSDictionary *response) {
        if ([response[@"status"] isEqualToString:@"10000"]) {
            NSArray *tempArr=response[@"list_goods"];
            [self.dataSource removeAllObjects];
//            NSDictionary *dic=tempArr.firstObject;
//            XLNormalShopModel *model=[XLNormalShopModel mj_objectWithKeyValues:dic];
//            [self.dataSource addObject:model];
        //    [self.tableview reloadData];
        }
    } AndFaild:^(NSError *error) {

    }];
}

#pragma mark - UI
/*****  UI布局 *****/
-(void)initUI
{
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, -20-KSafeTopHeight, KScreen_Width, KScreen_Height-KSafeAreaBottomHeight-49+KSafeTopHeight+20) style:UITableViewStyleGrouped];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    _tableview.showsHorizontalScrollIndicator=NO;
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.estimatedRowHeight=0;
    _tableview.estimatedSectionFooterHeight=0;
    _tableview.estimatedSectionHeaderHeight=0;

    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [_tableview registerClass:[XLMineTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    _tableview.mj_header=header;
   // _tableview.backgroundColor=MAINCOLOR;
    [self.view addSubview:self.tableview];

}

/*****  创建商品视图 *****/
-(void)initCollectionView
{

    float fWidth = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, fWidth, ((self.dataSource.count+1)/2)*cellHeight+2+20) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.scrollEnabled=NO;

}
#pragma mark - Noti
/*****  监听tabbar重复点击 进行刷新操作 *****/
-(void)tabbarRepeatSelectNoti:(NSNotification *)noti
{
    //调用父类的方法判断当前视图是否显示
    if ([self isShowingOnKeyWindow]) {
        [_tableview.mj_header beginRefreshing];
    }
}

/*****  登录通知 *****/
-(void)LogInSuccessNoti:(NSNotification *)noti
{
    XLLog(@"login");
    [self getUserData];
}

/*****  登出通知 *****/
-(void)LogOutSuccessNoti:(NSNotification *)noti
{
    XLLog(@"logout");
    self.dataModel=nil;
    [self.tableview reloadData];
}


#pragma mark - TableViewDelegate
/*****  分区数 *****/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/*****  行数 *****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.dataSource.count>0)?1:0;
}
/*****  cell的样式 *****/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, 50)];
    NSString *str=@"热门商品";
    CGSize size=[str sizeWithFont:KNSFONT(15) maxSize:CGSizeMake(200, 40)];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake((KScreen_Width-size.width)/2, (40-size.height)/2, size.width, size.height)];
    lab.font=KNSFONT(15);
    lab.textColor=RGB(51, 51, 51);
    lab.text=str;

    [view1 addSubview:lab];
    UIImageView *IV=[[UIImageView alloc]initWithFrame:CGRectMake((KScreen_Width-size.width)/2-36-5, (40-7)/2, 36, 7)];
    IV.image=[UIImage imageNamed:@"XL_Mine_left"];
    [view1 addSubview:IV];
    UIImageView *IV1=[[UIImageView alloc]initWithFrame:CGRectMake((KScreen_Width-size.width)/2+size.width+5, (40-7)/2, 36, 7)];
    IV1.image=[UIImage imageNamed:@"XL_Mine_right"];
    [view1 addSubview:IV1];
    view1.backgroundColor=RGB(244, 244, 244);
    [cell addSubview:view1];
    [self initCollectionView];
    [cell addSubview:_collectionView];
    return cell;
}
/*****  cell高度 *****/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.dataSource.count+1)/2*(cellHeight+2)+40+2;
}
/*****  头部高度 *****/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180+KSafeTopHeight+50+5+80+135;
}
/*****  头部内容 *****/
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XLMineTableHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    header.delegate=self;
    [header loadData:self.dataModel];
    return header;
}
/*****  脚部高度 *****/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
/*****  脚视图 *****/
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
#pragma mark - collectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-2)/2.0, ([UIScreen mainScreen].bounds.size.width-2)/2.0+90);
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}
//最小行内部cell的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

//section的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上,左,下,右
    return UIEdgeInsetsMake(0, 0, 2, 0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UICollectionViewCell alloc] init];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


}


#pragma mark - xlmineTableHeaderViewDelegate
/*****  登录 *****/
-(void)loginButClick:(UIButton *)sender
{
    XLTDDLoginVC *VC=[[XLTDDLoginVC alloc] init];
    VC.hidesBottomBarWhenPushed=YES;
    VC.jz_navigationBarHidden=YES;
    [self.navigationController pushViewController:VC animated:YES];
}
/*****  设置 *****/
-(void)settingButClick:(UIButton *)sender
{
    XLTDDMineSettingVC *VC=[[XLTDDMineSettingVC alloc] init];
    VC.hidesBottomBarWhenPushed=YES;
    VC.jz_navigationBarHidden=YES;
    [self.navigationController pushViewController:VC animated:YES];
}
/*****  查看个人信息 *****/
-(void)PortraitButClick:(UIButton *)sender
{
    XLLog(@"个人信息");
}
/*****  订单详情 *****/
-(void)checkOrderListWithIndex:(NSInteger)index
{
    NSArray *arr=@[@"全部",@"待付款",@"待发货",@"待收货",@"交易完成",@"退款"];
    XLLog(@"订单详情%ld个--%@",index,arr[index]);
}
/*****  我的服务 *****/
-(void)checkServiceWithIndex:(NSInteger)index
{
    NSArray *arr=@[@"推广返利",@"账户余额",@"领券中心",@"优惠券"];
    XLLog(@"我的服务第%ld个----%@",index,arr[index]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazyLoad
/*****  存储个人信息 *****/
-(XLUserModel *)dataModel
{
    if (!_dataModel) {
        _dataModel=[[XLUserModel alloc] init];
    }
    return _dataModel;
}
/*****  存储商品信息列表 *****/
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc] init];
    }
    return _dataSource;
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
