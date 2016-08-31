//
//  ActivityCell.h
//  豆瓣电影
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *begin_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *category_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *wisher_countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property (weak, nonatomic) IBOutlet UILabel *participant_countLabel;


@property (nonatomic,strong)ActivityModel *model;

@end
