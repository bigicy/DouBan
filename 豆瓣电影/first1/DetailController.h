//
//  DetailController.h
//  豆瓣电影
//
//  Created by lanou on 16/6/19.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADetailCell.h"

#import "ActivityModel.h"
@interface DetailController : UIViewController


@property (nonatomic,strong)ActivityModel *model;

@property (nonatomic,strong)ADetailCell *cell;

@property (nonatomic,strong)UILabel *label;

@end
