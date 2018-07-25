//
//  XLClassifyFirstLevelModel.h
//  XLTaoMall
//
//  Created by Hawky on 2018/7/24.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLBaseModel.h"
#import "XLClassifySecondLevelModel.h"
@interface XLClassifyFirstLevelModel : XLBaseModel

@property(nonatomic,copy)NSString *ClassiFyId;//分类id
@property(nonatomic,copy)NSString *name;//分类名字
@property (nonatomic,strong)NSArray *SmallClass_list;//二级分类

/*****  表视图的头部logo和头部logo商品gid *****/
@property (nonatomic,strong)NSString *logo;
@property (nonatomic,strong)NSString *gid;

@end
