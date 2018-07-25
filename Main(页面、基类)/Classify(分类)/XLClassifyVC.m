//
//  XLClassifyVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/4/12.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLClassifyVC.h"
#import "XLClassifyFirstLevelModel.h"
@interface XLClassifyVC ()
{
    UIScrollView  * _titleScroll;
    NSInteger selectIndex;
    UIView *_slidView;
}

/*****  存储左侧的一级分类 *****/
@property (nonatomic,strong)NSMutableArray *DataSource;

/*****  存储一级分类选中状态 *****/
@property (nonatomic,strong)NSMutableArray *statusArray;

/*****  右侧的tableview数组 *****/
@property (nonatomic,strong)NSMutableArray *tableViewArr;

@end

@implementation XLClassifyVC
#pragma mark - life cycle
/*****  视图初始化时候添加监听通知 *****/
-(instancetype)init
{
    self=[super init];
    /*****  监听其他页面跳转到分类的具体类目 *****/
    [KNotificationCenter addObserver:self selector:@selector(JumpToLeimu:) name:XLNotiJumpToLeiMuNoti object:nil];
    //监听重复点击tabbar
    [KNotificationCenter addObserver:self selector:@selector(tabbarRepeatSelectNoti:) name:XLNotiTabBarDidSelectedRepeated object:nil];
    return self;
}
/*****
 *  Description 加载
 ******/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUI];
    [self getLeftFirstLevelData];
    // Do any additional setup after loading the view.
}

#pragma mark - UI
/*****
 *
 *  Description 初始化视图
 *
 ******/
-(void)SetUI
{
    [self initSearchView];
}
/*****  搜索框 *****/
-(void)initSearchView
{
    /*****  背景 *****/
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSafeAreaTopNaviHeight)];
    view1.backgroundColor=MAINCOLOR;
    [self.view addSubview:view1];

    /*****  搜索白框 *****/
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(CWidth(15), 25+KSafeTopHeight, [UIScreen mainScreen].bounds.size.width-CWidth(30), 28)];
    searchView.backgroundColor = RGB(255, 255, 255);
    searchView.layer.cornerRadius  = 3;
    searchView.layer.masksToBounds = YES;
    [view1 addSubview:searchView];

    //搜索添加手势
    searchView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imgRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headSearchClick:)];
    [searchView addGestureRecognizer:imgRecongnizer];

    /*****  计算字符长度 *****/
    NSString *str=@"请搜索商品名称";
    CGSize size=[str sizeWithFont:KNSFONT(14) maxSize:KMAXSIZE];

    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake((KScreen_Width-CWidth(30)-(size.width+14+5))/2, 7, 14, 14)];
    imgView.image=[UIImage imageNamed:@"search_icon"];
    [searchView addSubview:imgView];

    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake((KScreen_Width-CWidth(30)-(size.width+14+5))/2+14+5, 7, size.width, 14)];
    label.text=str;
    label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    label.textColor=RGB(153, 153, 153);
    [searchView addSubview:label];
    /*****  底部分割线 *****/
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight-1, KScreen_Width, 1)];
    lineView.backgroundColor=RGB(225, 225, 225);
    [self.view addSubview:lineView];
}
/*****  左侧滑动选择框 *****/
-(void)initLeftSelectTypeView
{
    if (!_titleScroll) {
        CGFloat BHeight=40;
        CGFloat BWidth=CWidth(80);
        _titleScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight,BWidth+1, [UIScreen mainScreen].bounds.size.height-KSafeAreaTopNaviHeight-1-49-KSafeAreaBottomHeight)];
        _titleScroll.contentSize = CGSizeMake(BWidth, self.DataSource.count*BHeight);
        _titleScroll.bounces=NO;
        UIView *rightLine=[[UIView alloc] initWithFrame:CGRectMake(BWidth, 0, 1, _titleScroll.frame.size.height)];
        [rightLine setBackgroundColor:MAINSEPRATELINECOLOR];
        [_titleScroll addSubview:rightLine];
        for (int i=0; i<self.DataSource.count; i++) {
            XLClassifyFirstLevelModel *model=self.DataSource[i];
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, BHeight*i, BWidth, BHeight)];
            btn.backgroundColor=[UIColor whiteColor];
            [btn setTitle:model.name forState:UIControlStateNormal];
            [btn setTitleColor:TEXTSECONDBLACKCOLOR forState:UIControlStateNormal];
            [btn.titleLabel setFont:KNSFONT(14)];
            btn.tag=100+i;
            if (!selectIndex) {
                selectIndex=0;
                if (i==0) {
                    [btn setTitleColor:MAINBRIGHTCOLOR forState:0];
                    [btn setBackgroundColor:BACKGRAYCOLOR];
                    //[self getForYouSelectData];
                }
            }
            [_titleScroll addSubview:btn];
        }

        if (!_slidView) {
            _slidView=[[UIView alloc] init];
            [_slidView setBackgroundColor:MAINBRIGHTCOLOR];
        }
        [_titleScroll addSubview:_slidView];
        [_slidView setFrame:CGRectMake(0, BHeight*selectIndex+(BHeight-20)/2, 3, 20)];
        _titleScroll.showsVerticalScrollIndicator = NO;

        [self.view addSubview:_titleScroll];
    }
}
/*****  右侧的tableview *****/
-(void)initRightTableviews
{

}
#pragma mark - Network
/*****  左侧一级分类数据 *****/
-(void)getLeftFirstLevelData
{
    [XLNetworkManager POST:@"getHomePageClassification_mob.shtml" WithParams:nil AndView:self.view ForSuccess:^(NSDictionary *response) {
        if ([response[@"status"] isEqualToString:@"10000"]) {
            [self.DataSource removeAllObjects];
            XLClassifyFirstLevelModel *model=[[XLClassifyFirstLevelModel alloc] init];
            model.name=@"为你推荐";
            model.ClassiFyId=@"";
            [self.DataSource addObject:model];
            for (NSDictionary *dic in response[@"list1"]) {
                XLClassifyFirstLevelModel *model=[XLClassifyFirstLevelModel mj_objectWithKeyValues:dic];
                [self.DataSource addObject:model];
            }
            [self initLeftSelectTypeView];
        }
    } AndFaild:^(NSError *error) {

    }];
}


#pragma mark - events
-(void)headSearchClick:(UITapGestureRecognizer *)tap
{

}

#pragma mark - delegate

#pragma mark - Noti
/*****  监听tabbar重复点击 进行刷新操作 *****/
-(void)tabbarRepeatSelectNoti:(NSNotification *)noti
{
    if ([self isShowingOnKeyWindow]) {
        XLLog(@"分类被重复点击了");
    }
}
/*****  监听其他页面跳转到分类的某一个类目 *****/
-(void)JumpToLeimu:(NSNotification *)noti
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSMutableArray *)DataSource
{
    if (!_DataSource) {
        _DataSource=[[NSMutableArray alloc] init];
    }
    return _DataSource;
}
@end
