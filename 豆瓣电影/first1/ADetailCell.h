//
//  ADetailCell.h
//  豆瓣电影
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface ADetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *beginLabel;

@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categaryLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic,strong)ActivityModel *model;

@end
