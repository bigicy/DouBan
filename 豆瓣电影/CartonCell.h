//
//  CartonCell.h
//  作业
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartonModel.h"
@interface CartonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@property (nonatomic,strong)CartonModel *model;
@end
