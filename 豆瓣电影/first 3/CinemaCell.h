//
//  CinemaCell.h
//  作业
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CinemaModel.h"
@interface CinemaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cinemaLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;

@property (nonatomic,strong)CinemaModel *model;

@property (weak, nonatomic) IBOutlet UIView *view;


@end
