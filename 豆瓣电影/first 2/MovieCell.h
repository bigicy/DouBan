//
//  MovieCell.h
//  作业
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface MovieCell : UITableViewCell



@property (nonatomic,strong)MovieModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieLabel;
@property (weak, nonatomic) IBOutlet UIView *view;

@end
