//
//  XLClassifySecondLevelModel.h
//  XLTaoMall
//
//  Created by Hawky on 2018/7/24.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLBaseModel.h"

@interface XLClassifySecondLevelModel : XLBaseModel
@property(nonatomic,copy)NSString *GoodsId;//分类id
@property(nonatomic,copy)NSString *name;//分类名字
@property (nonatomic,strong)NSArray *goodsList;//商品数组
@end
