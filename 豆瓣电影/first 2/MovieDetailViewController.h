//
//  MovieDetailViewController.h
//  豆瓣电影
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailModel.h"
@interface MovieDetailViewController : UIViewController


@property (nonatomic,strong)MovieDetailModel *model;

@property (nonatomic, strong) NSString *string;

@property (nonatomic,strong)UILabel *label;

@property (nonatomic,strong)NSString *labelText;

- (void)analyseData;





@end
