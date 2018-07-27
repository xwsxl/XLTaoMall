//
//  XLClassifyVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/4/12.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLClassifyVC.h"
#import "XLClassifyFirstLevelModel.h"
@interface XLClassifyVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{

    UIScrollView  * _titleScroll;/*****  左侧滑动视图 *****/
    UIScrollView *_mainScroll;/*****  右侧装tableview和热门推荐的视图 *****/
    UIScrollView *_RemenScroll;/*****  右侧的热门推荐视图 *****/

    NSInteger selectIndex;/*****  选中分类下标 *****/
    UIView *_slidView;/*****  选中分类的标识图标 *****/
    NSString *selectID;
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
            [btn addTarget:self action:@selector(ClassifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:KNSFONT(14)];
            btn.tag=100+i;
            if (!selectID) {
                selectIndex=0;
            }else if([selectID isEqualToString:model.ClassiFyId])
            {
                selectIndex=i;
            }
            [_titleScroll addSubview:btn];
        }

        if (!_slidView) {
            _slidView=[[UIView alloc] init];
            [_slidView setBackgroundColor:MAINBRIGHTCOLOR];
        }
        [_titleScroll addSubview:_slidView];
        _titleScroll.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_titleScroll];
    }
    [self selectIndex:selectIndex];
}
/*****  右侧的tableview *****/
-(void)initRightTableviews
{
    /*
     if (!_RemenScroll) {
        _RemenScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width-CWidth(80), KScreen_Height-KSafeAreaTopNaviHeight-49-KSafeAreaBottomHeight)];
        _RemenScroll.delegate=self;
        _RemenScroll.tag=3456;
        [_mainScroll addSubview:_RemenScroll];
    }else
    {
        [_RemenScroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [_RemenScroll setContentOffset:CGPointZero];
    CGFloat height=0;
    XLClassifyFirstLevelModel *_DataModel=[XLClassifyFirstLevelModel new];
    if (!([_DataModel.logo1 isEqualToString:@""]||[_DataModel.logo1 containsString:@"null"])) {
        UIImageView *headerIV=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15,KScreen_Width-CWidth(80)-30,(KScreen_Width-CWidth(80)-30)*96/264.0)];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBanner:)];

        headerIV.userInteractionEnabled=YES;
        tap.numberOfTapsRequired=1;
        [headerIV addGestureRecognizer:tap];
        [headerIV sd_setImageWithURL:KNSURL(_DataModel.logo1) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
        headerIV.layer.cornerRadius=5;
        [_RemenScroll addSubview:headerIV];
        height +=15+(kScreenWidth-Width(80)-30)*96/264.0;
    }
    if (_DataModel.SmallClass_list.count>0) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, height+15, 70, 14)];
        lab.font=KNSFONT(14);
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"热门分类";
        [_RemenScroll addSubview:lab];

        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(kScreenWidth-Width(80)-15-70, height+15, 70, 14);
        [but setImage:KImage(@"xl-icon-F5") forState:UIControlStateNormal];
        [but setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [but setTitle:@"换一换" forState:UIControlStateNormal];
        [but setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        but.titleLabel.font=KNSFONT(14);
        [but addTarget:self action:@selector(HuanYiHuan:) forControlEvents:UIControlEventTouchUpInside];
        [_RemenScroll addSubview:but];

        height+=15+14;

        CGFloat leading=(kScreenWidth-Width(80)-Width(65)*3)/4.0;

        CGFloat IVwidth=leading;
        CGFloat IVHeight=Width(10);

        CGFloat width=(kScreenWidth-Width(80))/3;
        CGFloat butHeight=5+14+Width(65)+Width(20);

        for (int i=0; i<_DataModel.SmallClass_list.count; i++) {
            IVwidth=leading+(leading+Width(65))*(i%3);
            IVHeight=height+Width(20)+(5+14+Width(65)+Width(20))*(i/3);

            ClassifyModel *model=_DataModel.SmallClass_list[i];
            UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(IVwidth, IVHeight, Width(65), Width(65))];
            [IV setImage:KImage(model.name)];
            [_RemenScroll addSubview:IV];
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(IVwidth, IVHeight+Width(65)+5, Width(65), 14)];
            lab.font=KNSFONT(13);
            lab.textColor=RGB(155, 155, 155);
            lab.text=model.name;
            lab.textAlignment=NSTextAlignmentCenter;
            [_RemenScroll addSubview:lab];

            width=((kScreenWidth-Width(80))/3)*(i%3);
            butHeight=(5+14+Width(65)+Width(20))*(i/3)+height;
            UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
            but.frame=CGRectMake(width, butHeight, (kScreenWidth-Width(80))/3, 5+14+Width(65)+Width(20));
            but.tag=1000+i;
            [but addTarget:self action:@selector(clickFenLei:) forControlEvents:UIControlEventTouchUpInside];
            [_RemenScroll addSubview:but];

        }
        height+=((_DataModel.SmallClass_list.count+2)/3)*(5+14+Width(65)+Width(20))+15;

    }

    if (_DataModel.SelectedBrand_list.count>0) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(15, height+15, 70, 18)];
        lab.font=KNSFONT(14);
        lab.textColor=RGB(51, 51, 51);
        lab.text=@"精选品牌";
        [_RemenScroll addSubview:lab];

        height+=15+18;
        CGFloat leading=(kScreenWidth-Width(80)-Width(65)*3)/4.0;

        CGFloat IVwidth=leading;
        CGFloat IVHeight=Width(10);

        CGFloat width=(kScreenWidth-Width(80))/3;
        CGFloat butHeight=5+14+Width(65)+Width(20);
        for (int i=0; i<_DataModel.SelectedBrand_list.count; i++) {
            IVwidth=leading+(leading+Width(65))*(i%3);
            IVHeight=height+Width(20)+(5+14+Width(65)+Width(20))*(i/3);

            HomeDPModel *model=_DataModel.SelectedBrand_list[i];
            UIImageView *IV=[[UIImageView alloc] initWithFrame:CGRectMake(IVwidth, IVHeight, Width(65), Width(65))];
            [IV sd_setImageWithURL:KNSURL(model.picpath) placeholderImage:KImage(@"default_image") options:SDWebImageProgressiveDownload];
            [_RemenScroll addSubview:IV];
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(IVwidth, IVHeight+Width(65)+5, Width(65), 14)];
            lab.font=KNSFONT(14);
            lab.textColor=RGB(155, 155, 155);
            lab.text=model.cream_name;
            lab.textAlignment=NSTextAlignmentCenter;
            [_RemenScroll addSubview:lab];

            width=((kScreenWidth-Width(80))/3)*(i%3);
            butHeight=(5+14+Width(65)+Width(20))*(i/3)+height;
            UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
            but.frame=CGRectMake(width, butHeight, (kScreenWidth-Width(80))/3, 5+14+Width(65)+Width(20));
            but.tag=2000+i;
            [but addTarget:self action:@selector(clickDP:) forControlEvents:UIControlEventTouchUpInside];
            [_RemenScroll addSubview:but];
        }
        height+=((_DataModel.SelectedBrand_list.count+2)/3)*(5+14+Width(65)+Width(20));

    }

    _RemenScroll.contentSize=CGSizeMake(0, height+20);
    [_mainScroll setContentOffset:CGPointMake(0, selectIndex*(kScreen_Height-49-KSafeAreaBottomHeight-KSafeAreaTopNaviHeight)) animated:YES];
    //*/
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
/*****  热门推荐数据 *****/
-(void)getHotSuggestData
{
    [XLNetworkManager POST:@"getClassificationRecommendData_mob.shtml" WithParams:nil AndView:self.view ForSuccess:^(NSDictionary *response) {
        if ([response[@"status"] isEqualToString:@"10000"]) {
            
        }
    } AndFaild:^(NSError *error) {

    }];
}
/*****  右侧小分类数据 *****/
-(void)getRightSencondCateData
{
    XLClassifyFirstLevelModel *TempModel=self.DataSource[selectIndex];
    [XLNetworkManager POST:@"getClassificationSecondLevelData_mob.shtml" WithParams:@{@"id":TempModel.ClassiFyId} AndView:self.view ForSuccess:^(NSDictionary *response) {

    } AndFaild:^(NSError *error) {

    }];
}

#pragma mark - events
/*****  顶部搜索点击 *****/
-(void)headSearchClick:(UITapGestureRecognizer *)tap
{

}
/*****  左侧分类按钮选择 *****/
-(void)ClassifyBtnClick:(UIButton *)sender
{
    [self selectIndex:sender.tag-100];
}

#pragma mark - RepeatCode
/*****  选择了第n个 *****/
-(void)selectIndex:(NSInteger )index
{
    if (index==self.DataSource.count) index=self.DataSource.count-1;
    if (index==-1) index=0;
    if (selectIndex!=index){
        selectIndex=index;
        for (NSInteger i = 0; i <self.DataSource.count; i++) {
            UIButton *button = (UIButton *)[self.view viewWithTag:100+i];
            [button setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:0];
            [button setBackgroundColor:RGB(255, 255, 255)];
            if (selectIndex ==i) {
                [button setTitleColor:MAINBRIGHTCOLOR forState:0];
                [button setBackgroundColor:BACKGRAYCOLOR];
            }
            CGFloat bheight = 40;
            [_slidView setFrame:CGRectMake(0, bheight*selectIndex+(bheight-20)/2, 3, 20)];
        }
    }
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
